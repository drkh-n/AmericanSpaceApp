//
//  ContentView.swift
//  AmericanSpace App
//
//  Created by Darkhan on 26.04.2021.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    @AppStorage("log_status") var status = false
    @ObservedObject var model =  UserData()
    @State var profile: UserProfile?
    
    var body: some View {
        if status {
            TabView {
                ExploreView()
                    .tabItem {
                        Image(systemName: "safari")
                        Text("Explore")
                    }
                HomeView()
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                if (model.profile!.isAdmin == true) {
                    CreateEventView()
                        .tabItem {
                            Image(systemName: "plus.circle")
                            Text("Create Event")
                        }
                } else {
                    QRScanView()
                        .tabItem {
                            Image(systemName: "qrcode.viewfinder")
                            Text("Scan")
                        }
                }
                ProfileView()
                    .tabItem {
                        Image(systemName: "person")
                        Text("Profile")
                    }
                SettingView()
                    .tabItem {
                        Image(systemName: "gearshape")
                        Text("Settings")
                    }
            }.font(.headline)
        } else {
            SignInView(model: model)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
