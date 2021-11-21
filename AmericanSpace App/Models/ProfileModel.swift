//
//  ProfileModel.swift
//  AmericanSpace App
//
//  Created by Darkhan on 05.05.2021.
//

import Foundation

struct UserProfile: Codable {
    
    var uid: String
    var firstName: String
    var lastName: String
    var city: String
    var isAdmin: Bool

}

