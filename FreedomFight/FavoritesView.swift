//
//  FavoritesView.swift
//  FreedomFight
//
//  Created by khaled abukhamireh on 8/6/24.
//

import SwiftUI

struct FavoritesView: View {
    let vm = ViewModel()
    @State var searchText = ""
    var filteredEvents: [Event]{
        return vm.searchFav(for: searchText)
    }
    var body: some View {
        NavigationStack{
            if filteredEvents.isEmpty
            {
                Text("No Favorites Available")
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
            }
            }
            .onAppear {
                Task {
                    try await vm.getFavoriteEvents()
                }
                
            }
            .navigationTitle("Favorites")
            .frame(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .searchable(text: $searchText, prompt: "City, Sponsor, Name, and More")
            
            .autocorrectionDisabled()
            .animation(.default, value: searchText)
        }
    }
}

#Preview {
    FavoritesView()
}
