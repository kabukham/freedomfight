//
//  HomeView.swift
//  FreedomFight
//
//  Created by khaled abukhamireh on 7/17/24.
//

import SwiftUI
import MapKit

struct HomeView: View {
    var body: some View {
        EventDetails(event: ViewModel.currentEvent)
    }
}


#Preview {
    HomeView()
}
