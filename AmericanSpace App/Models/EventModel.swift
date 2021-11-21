//
//  EventModel.swift
//  AmericanSpace App
//
//  Created by Darkhan on 28.04.2021.
//

import Foundation
import FirebaseFirestoreSwift

struct Event: Identifiable, Codable {
    
    @DocumentID var id: String? = UUID().uuidString
    
    var title: String
    var description: String

    enum CodingKeys: String, CodingKey {
        case title
        case description
        
    }
    
}
