//
//  EventViewModel.swift
//  AmericanSpace App
//
//  Created by Darkhan on 04.05.2021.
//

import Foundation
import Firebase
import Combine

class EventViewModel: ObservableObject {
    
    @Published var event: Event
    @Published var modified = false
    
    private var db = Firestore.firestore()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(event: Event = Event(title: "", description: "")) {
        self.event = event
        
        self.$event
            .dropFirst()
            .sink { [weak self] event in
                self?.modified = true
            }
            .store(in: &cancellables)
    }
    
    func addEvent(event: Event) {
        do {
            let _ = try db.collection("events").addDocument(from: event)
        } catch {
            print(error)
        }
    }
    
    func saveEvent() {
        addEvent(event: event)
    }
    
}
