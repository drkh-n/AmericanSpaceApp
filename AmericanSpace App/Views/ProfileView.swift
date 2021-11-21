//
//  ProfileView.swift
//  AmericanSpace App
//
//  Created by Darkhan on 26.04.2021.
//

import SwiftUI
import Firebase

struct ProfileView: View {
    
    @AppStorage("log_status") var status = false
    @StateObject var model =  UserData()
    
    var body: some View {
        
        if status {
            VStack {
                Button(action: model.logOut, label: {
                    Text("Log out")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 40)
                        .background(Color.blue)
                        .clipShape(Capsule())
                })
            }
            .navigationTitle("Profile")
        } else {
            SignInView(model: model)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
