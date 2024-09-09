

import SwiftUI
import MapKit

struct EventMap: View {
    
    // @State private var address: String = "6743 S 50th Street, Franklin, WI 53132"
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), // Default location (San Francisco)
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    @StateObject private var locationManager = LocationManager()
    // @State var position: MapCameraPosition
    @State var satellite = false
    @State var event: Event
    private let geocoder = CLGeocoder()
    
    var body: some View {
        VStack {
            
            Button(action: {
                startNavigation()
            }) {
                Text("Navigate to Address")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
            Spacer()
        }
        .padding()
        .scaledToFill()
    }
    
    
    private func startNavigation() {
        locationManager.geocode(address: event.address.fullAddress) { coordinate in
            guard let coordinate = coordinate else {
                print("Unable to find coordinates for address.")
                return
            }
            
            let placemark = MKPlacemark(coordinate: coordinate)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = event.address.fullAddress
            mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
        }
    }
}
    

