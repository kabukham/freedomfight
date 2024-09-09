//
//  EventDetails.swift
//  FreedomFight
//
//  Created by khaled abukhamireh on 7/19/24.
//

import SwiftUI
import MapKit
import CoreLocation

struct EventDetails: View {
    let event: Event
    //@State var position: MapCameraPosition
    
    @State private var directions: [String] = []
    @State private var showDirections = false
    @State public var isfavAdded = false
    @State private var favText =  "Add to Favorites"
    public var eventDateTime = ""
    
    @StateObject private var locationManager = LocationManager()
    
    @ObservedObject private var viewModel = LocationViewModel()
    
    @State private var coordinate:  CLLocationCoordinate2D = CLLocationCoordinate2D()
    
    var body: some View {
        GeometryReader { geo in
            ScrollView{ 
                 VStack(alignment: .leading)
                 {
                     //background image
                     AsyncImage(url: URL(string: event.image)) { phase in
                         switch phase {
                         case .empty:
                             ProgressView()
                         case .success(let image):
                             image
                                 .resizable()
                                 .scaledToFill()
                         case .failure:
                             Image(systemName: "exclamationmark.triangle.fill") // Show an error image if the image fails to load
                         @unknown default:
                             EmptyView()
                         }
                     }
                 }
                VStack(alignment: .leading){
                    Divider()
                        .background(Color.green)  // Change the color of the divider
                        .frame(height: 2)         // Change the thickness of the divider
                        .padding(.leading)
                    
                    Text(favText)
                        .foregroundColor(.blue)
                        .underline()
                        .onAppear(){
                            if (ViewModel.containsFavoriteEvent(event: event) == true )
                            {
                                isfavAdded = true
                                favText = "Remove from Favorites"
                            }else
                            {
                                isfavAdded = false
                                favText = "Add to Favorites"
                            }
                        }
                        .onTapGesture {
                            if (isfavAdded == true)
                            {
                                ViewModel.removeFromFavoriteEvents(eventToRemove: event)
                                isfavAdded = false
                                favText = "Add to Favorites"
                            }else
                            {
                                ViewModel.saveToFavoriteEvents(newEvent: event)
                                isfavAdded = true
                                favText = "Remove from Favorites"
                                
                            }
                        }
                    Divider()
                    VStack(alignment: .leading)
                    {
                        Text(event.name)
                            .font(.headline)
                            .frame(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        //description here:
                        Text(event.description)
                            .padding([.leading, .bottom],
                                     5)
                            .clipShape(.rect(cornerRadius:  15))
                    }
                    Divider()
                        .background(Color.green)  // Change the color of the divider
                        .frame(height: 2)         // Change the thickness of the divider
                        .padding(.leading)
                    VStack(alignment: .leading)
                    {
                        Text("Event Date and Time")
                            .frame(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .bold()
                        Text(ViewModel.formatTime(timeString: event.eventDateTime)!)
                            .frame(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                    Divider()
                        .background(Color.green)  // Change the color of the divider
                        .frame(height: 2)         // Change the thickness of the divider
                        .padding(.leading)
                    VStack(alignment: .leading)
                    {
                        Text("Sponsored by")
                            .frame(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .bold()
                        
                        ForEach(event.sponsors, id: \.self) { sponsor in
                            Text("• \(sponsor)")
                                .frame(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        }
                    }
                    Divider()
                        .background(Color.green)  // Change the color of the divider
                        .frame(height: 2)         // Change the thickness of the divider
                        .padding(.leading)
                    Divider()
                        .background(Color.green)  // Change the color of the divider
                        .frame(height: 2)         // Change the thickness of the divider
                        .padding(.leading)
                    VStack(alignment: .leading)
                    {
                        Text("Location")
                            .frame(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .bold()
                        
                        Text(event.address.fullAddress)
                    }
                    Divider()
                        .background(Color.green)  // Change the color of the divider
                        .frame(height: 2)         // Change the thickness of the divider
                        .padding(.leading)
                    
                }
                Button(action: {
                    startNavigation()
                    
                }) {
                    Text("Navigate to Location")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
        }
        .padding()
        .toolbarBackground(.automatic)
    }
   
    func GetLocation(fullAddress: String) -> CLLocationCoordinate2D{
        var lat: Double = 0.0
        var long: Double = 0.0
        convertAddressToCoordinates(address: fullAddress) { (coordinate, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else if let coordinate = coordinate {
                lat = coordinate.longitude
                long = coordinate.latitude
                print("Latitude1: \(coordinate.latitude), Longitude1: \(coordinate.longitude)")
                self.coordinate = coordinate
            }
        }
        return CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
    
    func convertAddressToCoordinates(address: String, completion: @escaping (CLLocationCoordinate2D?, Error?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            if let placemark = placemarks?.first, let location = placemark.location {
                let coordinate = location.coordinate
                completion(coordinate, nil)
            } else {
                let error = NSError(domain: "GeocodingError", code: 0, userInfo: [NSLocalizedDescriptionKey: "No coordinates found for the address"])
                completion(nil, error)
            }
        }
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

