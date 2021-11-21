//
//  EventViewModel.swift
//  AmericanSpace App
//
//  Created by Darkhan on 01.05.2021.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class EventsViewModel: ObservableObject {
    
    @Published var events = [Event]()
    private var db = Firestore.firestore()
    
    func fetchData() {
        
        db.collection("events").addSnapshotListener { (querySnapshot, error) in
            
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.events = documents.compactMap { (queryDocumentSnapshot) -> Event? in
                
                return try? queryDocumentSnapshot.data(as: Event.self)
                
            }
        }
        
    }
}
