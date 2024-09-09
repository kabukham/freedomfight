import SwiftUI
import MapKit
import CoreLocation

class LocationViewModel: ObservableObject {
    @Published var coordinates: CLLocationCoordinate2D?
    @Published var errorMessage: String?

    func fetchCoordinates(for address: String) {
        getCoordinatesUsingMapKit(address: address) { coordinate, error in
                if let coordinate = coordinate {
                    DispatchQueue.main.async {
                        self.coordinates = coordinate
                        self.errorMessage = nil
                    }
                } else if let error = error {
                    DispatchQueue.main.async {
                        self.errorMessage = error.localizedDescription
                    }
                } else {
                    DispatchQueue.main.async {
                        self.errorMessage = "Unknown error occurred."
                    }
                }
            }
    }
    
    func getCoordinatesUsingMapKit(address: String, completion: @escaping (CLLocationCoordinate2D?, Error?) -> Void) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = address
        
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            if let error = error {
                print("Search failed: \(error.localizedDescription)")
                completion(nil, error)
                return
            }
            
            if let coordinate = response?.mapItems.first?.placemark.coordinate {
                print("Coordinates: \(coordinate.latitude), \(coordinate.longitude)")
                completion(coordinate, nil)
            } else {
                print("No coordinates found.")
                completion(nil, nil)
            }
        }
    }
}

