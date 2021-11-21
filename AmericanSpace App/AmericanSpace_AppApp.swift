//
//  AmericanSpace_AppApp.swift
//  AmericanSpace App
//
//  Created by Darkhan on 26.04.2021.
//

import SwiftUI
import Firebase

@main
struct AmericanSpace_AppApp: App {
    
    @UIApplicationDelegateAdaptor(Delegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class Delegate : NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        return true
        
    }
}
