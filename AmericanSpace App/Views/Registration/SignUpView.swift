//
//  SignUpView.swift
//  AmericanSpace App
//
//  Created by Darkhan on 30.04.2021.
//

import SwiftUI
import Firebase

struct SignUpView: View {
    
    @ObservedObject var model: UserData
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("Sign Up")
                .bold()
                .font(.title)
                .foregroundColor(.blue)
            
            CustomTextField(placeholder: "Email", txt: $model.email_SignUp)
//            CustomTextField(placeholder: "Full Name", txt: $model.fullName)
//            CustomTextField(placeholder: "Phone", txt: $model.phone)
            CustomTextField(placeholder: "Password", txt: $model.password_SignUp)
            CustomTextField(placeholder: "Re-enter Password", txt: $model.rePassword_SignUp)

            
            Button(action: model.signUp) {
                Text("Let's go!")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 40)
                    .background(Color.blue)
                    .clipShape(Capsule())
            }
            .padding(.top, 40)
            
        }
        .padding(.top, 20)
        .alert(isPresented: $model.alert, content: {
            Alert(title: Text("Message"), message: Text(model.alertMessage), dismissButton: .destructive(Text("Ok")))
        })
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(model: UserData.init())
    }
}
