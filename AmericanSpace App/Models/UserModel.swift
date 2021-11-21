//
//  UserModel.swift
//  AmericanSpace App
//
//  Created by Darkhan on 03.05.2021.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift
import Combine

class UserData: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var email_SignUp = ""
    @Published var password_SignUp = ""
    @Published var rePassword_SignUp = ""
    @Published var resetEmail = ""
    @Published var isLinkSent = false
    
    // Error alerts
    @Published var alert = false
    @Published var alertMessage = ""
    
    //User status
    @AppStorage("log_status") var status = false
    
    @Published var session: User?
    @Published var profile: UserProfile?
    
    private var profileRepository = UserProfileRepository()
    
    func resetPassword() {
        
        let alert = UIAlertController(title: "Reset password", message: "Enter your email to reset your password", preferredStyle: .alert)
        
        alert.addTextField { (password) in password.placeholder = "Email"}
        
        let proceed = UIAlertAction(title: "Reset", style: .default) { (_) in
            if alert.textFields![0].text! != "" {
                
                Auth.auth().sendPasswordReset(withEmail: alert.textFields![0].text!) { (error) in
                    if error != nil {
                        self.alertMessage = error!.localizedDescription
                        self.alert.toggle()
                        return
                    }
                    
                    self.alertMessage = "Password Reset Link has been sent!"
                    self.alert.toggle()
                }
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        alert.addAction(proceed)
        alert.addAction(cancel)
        
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
        
    }
    
    func signIn() {
        
        if email == "" || password == "" {
            self.alertMessage = "Fill the fields correctly!"
            self.alert.toggle()
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if error != nil {
                self.alertMessage = error!.localizedDescription
                self.alert.toggle()
                return
            }
            
            let user = Auth.auth().currentUser
            
            if !user!.isEmailVerified {
                
                self.alertMessage = "Please verify your email!"
                self.alert.toggle()
                
                try! Auth.auth().signOut()
                return
                
            }
            
//            guard let userIn = result?.user else { return }

            self.profileRepository.fetchProfile(userId: user!.uid) { (profile, error) in
                
                if error != nil {
                    self.alertMessage = error!.localizedDescription
                    self.alert.toggle()
                    return
                }

                self.profile = profile
            }
            
            withAnimation {
                self.status = true
            }
        }
    }
    
    func signUp() {
        
        if email_SignUp == "" || password_SignUp == "" || rePassword_SignUp == "" {
            self.alertMessage = "Fill the fields correctly!"
            self.alert.toggle()
            return
        }
        
        if password_SignUp != rePassword_SignUp {
            self.alertMessage = "Passwords don't match!"
            self.alert.toggle()
            return
        }
        
        Auth.auth().createUser(withEmail: email_SignUp, password: password_SignUp) { (result, error) in
            
            if error != nil {
                self.alertMessage = error!.localizedDescription
                self.alert.toggle()
                return
            }
            
            result?.user.sendEmailVerification(completion: { (error) in
                if error != nil {
                    self.alertMessage = error!.localizedDescription
                    self.alert.toggle()
                    return
                }
                
                self.alertMessage = "Email Verification Link has been sent!"
                self.alert.toggle()
            })
            
            guard let user = result?.user else { return }
            
            let userProfile = UserProfile(uid: user.uid, firstName: "", lastName: "", city: "", isAdmin: false)
            
            self.profileRepository.createProfile(profile: userProfile) { (profile, error) in
                if let error = error {
                  print("Error while fetching the user profile: \(error)")
                  return
                }
                self.profile = profile
            }
        }
    }
    
    func logOut() {
        
        do {
            try Auth.auth().signOut()
            self.session = nil
            self.profile = nil
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError)")
          }
        
        withAnimation {
            self.status = false
        }
        
        email = ""
        password = ""
        email_SignUp = ""
        password_SignUp = ""
        rePassword_SignUp = ""
        resetEmail = ""
        
    }
    
}
