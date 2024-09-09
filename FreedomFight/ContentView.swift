//
//  ContentView.swift
//  FreedomFight
//
//  Created by khaled abukhamireh on 7/17/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView
         {
             SearchView()
                 .toolbarBackground(.visible, for: .tabBar)
                 .tabItem {
                 Label("Home", systemImage: "house.fill")
                 }
             FavoritesView()
                  .toolbarBackground(.visible, for: .tabBar)
                  .tabItem {
                  Label("Favorite", systemImage: "star.fill")
                  }
         }
         .preferredColorScheme(.none)
     }
}

#Preview {
    ContentView()
}
