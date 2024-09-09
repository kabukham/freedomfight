import Foundation
import CoreLocation

private let geocoder = CLGeocoder()

@Observable
class ViewModel
{
    
    enum fetchStatus{
        case notStarted
        case fetching
        case success
        case failed(error: Error)
    }
    
    var events: [Event] = []
    var allEvents: [Event] = []
    static var favoriteEventPKs: [EventKey] = []
    var favoriteEvens: [Event] = []
    static var currentEvent: Event = Event()
    
    private (set) var status: fetchStatus = .notStarted
    
    private let fetcher = FetchService()
    var isLoading = true
    
    func search (for searchTerm: String) -> [Event]
    {
        if searchTerm.isEmpty
        {
            return events
        } else
        {
            return events.filter{ event in
                event.name
                    .localizedCaseInsensitiveContains(searchTerm) ||
                event.address.fullAddress.localizedCaseInsensitiveContains(searchTerm) ||
                event.address.zipCode.localizedCaseInsensitiveContains(searchTerm) ||
                event.description.localizedCaseInsensitiveContains(searchTerm) ||
                event.sponsors.contains(where: { $0.localizedCaseInsensitiveContains(searchTerm) == true })
            }
        }
    }
    func searchFav (for searchTerm: String) -> [Event]
    {
        if searchTerm.isEmpty
        {
            return favoriteEvens
        } else
        {
            return favoriteEvens.filter{ event in
                event.name
                    .localizedCaseInsensitiveContains(searchTerm) ||
                event.address.fullAddress.localizedCaseInsensitiveContains(searchTerm) ||
                event.address.zipCode.localizedCaseInsensitiveContains(searchTerm) ||
                event.description.localizedCaseInsensitiveContains(searchTerm)
            }
        }
    }

    func getFavoriteEvents() async throws -> [Event] {
        _ = ViewModel.getSavedFavoriteEvents()
        status = .fetching
        do{
            _ =  convertToJson()
            favoriteEvens = try await fetcher.fetchFavoriteEvents(listOfEvents: ViewModel.favoriteEventPKs)
            ViewModel.refreshFavorites(events: favoriteEvens)
            status = .success
        }catch
        {
            status = .failed(error: error)
        }
        return events
    }
    
    func convertToJson() -> String{
        let encoder = JSONEncoder()
        //encoder.outputFormatting = .prettyPrinted
        var jsonString: String = ""
        do {
            let jsonData = try encoder.encode(ViewModel.favoriteEventPKs)
            jsonString = String(data: jsonData, encoding: .utf8) ?? "Error encoding JSON"
        } catch {
            jsonString = "Error encoding JSON: \(error.localizedDescription)"
        }
        print(jsonString)
        return jsonString
    }
    
    func getData(for show: String) async throws -> [Event] {
        status = .fetching
        do{
            events = try await fetcher.fetchEvents(from: show)
            status = .success
        }catch
        {
            status = .failed(error: error)
        }
        return events
    }
    
    
    static func formatTime(timeString: String) -> (String?) {
        let dateFormatter = ISO8601DateFormatter()
        var dateStr = ""
        //dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        if let date = dateFormatter.date(from: timeString) {
            let calendar = Calendar.current
                let components = calendar.dateComponents([.year, .month, .day], from: date)
                
            if let year = components.year, let month = components.month, let day = components.day {
                dateStr = "\(month)/\(day)/\(year)"
            }
            let outputFormatter = DateFormatter()
            outputFormatter.timeStyle = .medium
            outputFormatter.timeZone = TimeZone(identifier: "America/Chicago") // Central Time Zone
            let time = outputFormatter.string(from: date)
            return "\(dateStr) @ \(time)"
        } else {
            return nil
        }
    }
    
    static func refreshFavorites(events: [Event]){
        self.favoriteEventPKs = []
        for event in events {
            var newKey = EventKey()
            newKey.PK = event.PK
            newKey.SK = event.SK
            self.favoriteEventPKs.append(newKey)
        }
        if let encodedData = try? JSONEncoder().encode(self.favoriteEventPKs) {
            // Save the JSON data to UserDefaults
            UserDefaults.standard.set(encodedData, forKey: "favoriteEvents")
        }
    }
    
    static func getSavedFavoriteEvents()-> [EventKey]
    {
        if let savedEvents = UserDefaults.standard.data(forKey: "favoriteEvents") {
            // Decode the JSON data to an array of structs
            if let decodedArray = try? JSONDecoder().decode([EventKey].self, from: savedEvents) {
                favoriteEventPKs = decodedArray
            }
        }
        return self.favoriteEventPKs
    }
    
    static func containsFavoriteKey(newKey: EventKey) -> Bool {
        var isContains = false
        do {
            isContains = ViewModel.favoriteEventPKs.contains(where: { $0 == newKey })
        }
        return isContains
    }
    
    static func containsFavoriteEvent(event: Event) -> Bool {
        var newKey = EventKey()
        newKey.PK = event.PK
        newKey.SK = event.SK
        return containsFavoriteKey(newKey: newKey)
    }
    
    static func removeFavoriteKey(keyToRemove: EventKey) {
        ViewModel.favoriteEventPKs.removeAll(where: { $0 == keyToRemove })
        print("count: \(favoriteEventPKs.count)")
        print(self.favoriteEventPKs)
    }
    
    static func saveToFavoriteEvents(newEvent: Event)
    {
        var newKey = EventKey()
        newKey.PK = newEvent.PK
        newKey.SK = newEvent.SK
        
        self.favoriteEventPKs = getSavedFavoriteEvents()
        
        if (!containsFavoriteKey(newKey: newKey))
        {
            self.favoriteEventPKs.append(newKey)
            if let encodedData = try? JSONEncoder().encode(self.favoriteEventPKs) {
                // Save the JSON data to UserDefaults
                UserDefaults.standard.set(encodedData, forKey: "favoriteEvents")
            }
            print("count: \(favoriteEventPKs.count)")
        }
        print(self.favoriteEventPKs)
        //else do nothing.
    }
    
    static func removeFromFavoriteEvents(eventToRemove: Event)
    {
        var k = EventKey()
        k.PK = eventToRemove.PK
        k.SK = eventToRemove.SK
        
        self.favoriteEventPKs = getSavedFavoriteEvents()
        self.removeFavoriteKey(keyToRemove: k)
        
        if let encodedData = try? JSONEncoder().encode(self.favoriteEventPKs) {
            // Save the JSON data to UserDefaults
            UserDefaults.standard.set(encodedData, forKey: "favoriteEvents")
            print(self.favoriteEventPKs)
            //else do nothing.
        }
    }
}
    
