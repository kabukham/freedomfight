#  <#Title#>

            //let coordinate = CLLocationCoordinate2D(latitude: event.latitude, longitude: event.longitude)
            //MapView(coordinate: coordinate)
             
//            Map(initialPosition: .camera(MapCamera(centerCoordinate:
//                                                    coordinate,
//                                              distance: 10000,
//                                              heading: 250,
//                                                   pitch: 80))){
//                Annotation(event.name,
//                           coordinate: CLLocationCoordinate2D(latitude: event.latitude, longitude: event.longitude))
//                {
//                    Image(systemName: "mappin.and.ellipse.circle")
//                        .font(.largeTitle)
//                        .imageScale(.large)
//                        .symbolEffect(.pulse)
//                }
//                .annotationTitles(.hidden)
//            }



    
    
//    func GetLocation(fullAddress: String) -> CLLocationCoordinate2D{
//        var lat: Double = 4.938497785245886
//        var long: Double = -8.06196738717541
//        convertAddressToCoordinates(address: fullAddress) { (coordinate, error) in
//            if let error = error {
//                print("Error: \(error.localizedDescription)")
//            } else if let coordinate = coordinate {
//                lat = coordinate.longitude
//                long = coordinate.latitude
//                print("Latitude: \(coordinate.latitude), Longitude: \(coordinate.longitude)")
//            }
//        }
//        return CLLocationCoordinate2D(latitude: lat, longitude: long)
//    }
//    
//    func convertAddressToCoordinates(address: String, completion: @escaping (CLLocationCoordinate2D?, Error?) -> Void) {
//        let geocoder = CLGeocoder()
//        geocoder.geocodeAddressString(address) { (placemarks, error) in
//            if let error = error {
//                completion(nil, error)
//                return
//            }
//            
//            if let placemark = placemarks?.first, let location = placemark.location {
//                let coordinate = location.coordinate
//                completion(coordinate, nil)
//            } else {
//                let error = NSError(domain: "GeocodingError", code: 0, userInfo: [NSLocalizedDescriptionKey: "No coordinates found for the address"])
//                completion(nil, error)
//            }
//        }
//    }
//    
    
//    private func geocodeAddress() {
//        locationManager.geocode(address: event.address.fullAddress) { coordinate in
//            if let coordinate = coordinate {
//                region = MKCoordinateRegion(
//                    center: coordinate,
//                    span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
//                )
//            } else {
//                print("Unable to find coordinates for address.")
//            }
//        }
//    }


//                    NavigationLink{
//                        EventMap(event: event)
//                        
//                    }label:{
//                        MapView(coordinate: coordinate)
//                            .frame(width: geo.size.width/1.5,height: geo.size.height/3)
//                        Map(initialPosition:  .camera(MapCamera(centerCoordinate:
//                                                                    coordinate,
//                                                                distance: 10000,
//                                                                heading: 250,
//                                                                pitch: 80)))
//                        {
//                            Annotation(event.name,
//                                       coordinate: GetLocation(fullAddress: event.address.fullAddress))
//                            {
//                                Image(systemName: "mappin.and.ellipse.circle")
//                                    .font(.largeTitle)
//                                    .imageScale(.large)
//                                    .symbolEffect(.pulse)
//                            }
//                            .annotationTitles(.hidden)
//                        }
//                        .frame(height: 125)
//                        .clipShape(.rect(cornerRadius: 15))
//                        .overlay(alignment: .trailing)
//                        {
//                            Image(systemName: "greaterthan")
//                                .imageScale(.large)
//                                .font(.title3)
//                                .padding(.trailing, 5)
//                            
//                        }
//                        .clipShape(
//                            .rect(bottomTrailingRadius: 15))
//                    }
//                    .padding()


//    private func navigateToLocation(latitude: Double, longitude: Double) {
//            let newRegion = MKCoordinateRegion(
//                center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
//                span: MKCoordinateSpan(latitudeDelta: latitude, longitudeDelta: longitude)
//            )
//            region = newRegion
//        }
}
//struct MapView: UIViewRepresentable {
//    @Binding var region: MKCoordinateRegion
//    @Binding var directions: [String]
//    
//    func makeUIView(context: Context) -> MKMapView {
//        let mapView = MKMapView()
//        mapView.delegate = context.coordinator
//        return mapView
//    }
//    
//    func updateUIView(_ uiView: MKMapView, context: Context) {
//        uiView.setRegion(region, animated: true)
//        uiView.removeOverlays(uiView.overlays)
//        
//        if let route = context.coordinator.currentRoute {
//            uiView.addOverlay(route.polyline)
//        }
//    }
//    
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//    
//    class Coordinator: NSObject, MKMapViewDelegate {
//        var parent: MapView
//        var currentRoute: MKRoute?
//        
//        init(_ parent: MapView) {
//            self.parent = parent
//        }
//        
//        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
//            let renderer = MKPolylineRenderer(overlay: overlay)
//            renderer.strokeColor = .blue
//            renderer.lineWidth = 5
//            return renderer
//        }
//    }
//}

//#Preview {
//    PredatorMap(position: .camera(MapCamera(centerCoordinate:
//                                                Predators().apexPredators[2].location,
//                                            distance: 1000,
//                                            heading: 250,
//                                            pitch: 80)))
//}

//#Preview {
//    NavigationStack{
//        let coordinate = CLLocationCoordinate2D(latitude: 42.938497785245886, longitude: -88.06196738717541)
//        EventDetails(event: Event())
//            .preferredColorScheme(.none)
//    }
//    
//}
