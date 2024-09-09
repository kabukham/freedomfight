import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject {
    private let geocoder = CLGeocoder()
    
    func geocode(address: String, completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        geocoder.geocodeAddressString(address) { placemarks, error in
            if let error = error {
                print("Geocoding error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let placemark = placemarks?.first, let location = placemark.location else {
                completion(nil)
                return
            }
            
            completion(location.coordinate)
        }
    }
}
