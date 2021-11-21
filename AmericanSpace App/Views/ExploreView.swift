//
//  ExploreView.swift
//  AmericanSpace App
//
//  Created by Darkhan on 26.04.2021.
//

import SwiftUI

struct ExploreView: View {
    
    @ObservedObject private var viewModel = EventsViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.events) { event in
                VStack(alignment: .leading) {
                    Text(event.title)
                        .font(.headline)
                    Text(event.description)
                        .font(.subheadline)
                }
            }
            .navigationBarTitle("Upcoming Events")
            .onAppear() {
                self.viewModel.fetchData()
            }
        }
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}
