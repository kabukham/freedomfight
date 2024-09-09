//
//  SearchView.swift
//  FreedomFight
//
//  Created by khaled abukhamireh on 7/17/24.
//

import SwiftUI
import MapKit

struct SearchView: View {
    let vm = ViewModel()
    @State var searchText = ""
    var filteredEvents: [Event]{
        return vm.search(for: searchText)
    }
    var body: some View {
        NavigationStack{
            if filteredEvents.isEmpty
            {
                Text("No events available")
                    .font(.headline)
                    .foregroundColor(.gray)
            }
            
            List(filteredEvents){ event in
                NavigationLink{
                    EventDetails(event: event)
                }
            label: {
                HStack{
                    VStack(alignment: .leading){
                        Text(event.name)
                            .font(.headline)
                        Text(ViewModel.formatTime(timeString: event.eventDateTime)!)
                        Text(event.address.fullAddress)
                    }
                }
                Divider()
                    .background(Color.green)  // Change the color of the divider
                    .frame(height: 2)         // Change the thickness of the divider
                    .padding(.leading)
            }
            }
            .onAppear {
                Task {
                    try await vm.getData(for: searchText)
                }
                
            }
            .navigationTitle("Events")
            .searchable(text: $searchText, prompt: "City, Sponsor, Name, and More")
            .animation(.default, value: searchText)
            .autocorrectionDisabled()
            .animation(.default, value: searchText)
        }
        .refreshable {
            Task {
                try await vm.getData(for: searchText)
            }
        }
    }
}

#Preview {
    SearchView()
}
