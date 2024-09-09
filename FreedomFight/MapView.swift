//
//  MapView.swift
//  FreedomFight
//
//  Created by khaled abukhamireh on 8/10/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State public var coordinate:  CLLocationCoordinate2D
    
    var body: some View {
        VStack {
            
            Map(initialPosition:  .camera(MapCamera(centerCoordinate:
                                                        coordinate,
                                                    distance: 10000,
                                                    heading: 250,
                                                    pitch: 80)))
            {
            }
            .frame(height: 125)
            .clipShape(.rect(cornerRadius: 15))
            .overlay(alignment: .trailing)
            {
                Image(systemName: "greaterthan")
                    .imageScale(.large)
                    .font(.title3)
                    .padding(.trailing, 5)
                
            }
            .clipShape(
                .rect(bottomTrailingRadius: 15))
        }
    }
}

