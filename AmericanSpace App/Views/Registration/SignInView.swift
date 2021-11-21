//
//  SingInView.swift
//  AmericanSpace App
//
//  Created by Darkhan on 30.04.2021.
//

import SwiftUI
import Firebase

struct SignInView: View {
    
    @ObservedObject var model: UserData
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                
                Text("Sign In")
                    .bold()
                    .font(.title)
                    .foregroundColor(.blue)
                
                CustomTextField(placeholder: "Email", txt: $model.email)
                CustomTextField(placeholder: "Password", txt: $model.password)
                Button(action: model.resetPassword) {
                    Text("Forget password?")
                        .font(.footnote)
                }
                
                Button(action: model.signIn) {
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
                
                VStack {
                    Text("Don't have an account?")
                    NavigationLink(destination: SignUpView(model: model)) {
                        Text("Sign up here!")
                            .bold()
                    }
                }
                .padding(.top, 40)
                
            }
            .padding(.top, 0)
        }
        .alert(isPresented: $model.alert) {
            Alert(title: Text("Message"), message: Text(model.alertMessage), dismissButton: .destructive(Text("Ok")))
        }

    }
}

struct CustomTextField: View {
    
    var placeholder: String
    @Binding var txt: String
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
            
            ZStack {
                if (placeholder == "Password" || placeholder == "Re-enter Password") {
                    SecureField(placeholder, text: $txt)
                } else {
                    TextField(placeholder, text: $txt)
                }
            }
            .padding(.horizontal)
            .padding(.leading, 10)
            .frame(height: 60)
            .clipShape(Capsule())
            
        }
        .padding(.horizontal)
    }
    
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(model: UserData.init())
    }
}

