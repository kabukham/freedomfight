

import Foundation


struct FetchService{
    private enum FetchError: Error{
        case badResponse
    }
    private let baseUrlString = "https://oec0jfck1c.execute-api.us-east-1.amazonaws.com/dev/events"
    private let baseURL = URL(string: "https://oec0jfck1c.execute-api.us-east-1.amazonaws.com/dev/events")!
    
    func fetchFavoriteEvents(listOfEvents: [EventKey]) async throws-> [Event]
    {
        //build fetch url
        //let eventsURL = baseURL.appending(path: "quotes/random")
        let fetchURL = baseURL //quoteURL.appending(queryItems: [URLQueryItem(name: "production", value: show)])
        //fetch data
        var request = URLRequest(url: fetchURL)
        request.httpMethod = "POST"
        
        let jsonData = try JSONEncoder().encode(listOfEvents)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let (body, response) = try await URLSession.shared.data(for: request)
        
        //handle response
        guard let response = response as? HTTPURLResponse, response.statusCode == 200
        else {
            throw FetchError.badResponse
        }
        
        //decode data
        var resultData: ResultData? = nil
        var favoriteEvents: [Event] = []
        do {
            resultData = try JSONDecoder().decode(ResultData.self, from: body)
            favoriteEvents = resultData!.body
        } catch {
            print("Decoding failed with error: \(error)")
        }
        return favoriteEvents
    }
    
    func fetchEvents(from show: String) async throws-> [Event]
    {
        let parameters = [
            //  "state": state,
            //"country": country,
            "city": show
            // "zip": zip
        ]
        
        // Build the URL with query parameters
        var urlComponents = URLComponents(string: baseUrlString)
        urlComponents?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        // Create the URL from urlComponents
        guard let fetchURL = urlComponents?.url else {
            print("Invalid URL")
            return []
        }
        //fetch data
        let (body, response) = try await URLSession.shared.data(from: fetchURL)
        
        //handle response
        guard let response = response as? HTTPURLResponse, response.statusCode == 200
        else {
            throw FetchError.badResponse
        }
        
        //decode data
        var resultData: ResultData? = nil
        var events: [Event] = []
        var allEvents: [Event] = []
        do {
            resultData = try JSONDecoder().decode(ResultData.self, from: body)
            events = resultData!.body
            allEvents = events
        } catch {
            print("Decoding failed with error: \(error)")
        }
        return allEvents
        
    }
}
