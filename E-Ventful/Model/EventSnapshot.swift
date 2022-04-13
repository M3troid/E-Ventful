//
//  EventSnapshot.swift
//  E-Ventful
//
//  Created by Drake Neuenschwander on 4/12/22.
//


import Foundation
import Firebase

struct EventSnapshot {
    
    let events: [Event]
    
    init?(with snapshot: DataSnapshot) {
        var events = [Event]()
        guard let snapDict = snapshot.value as? [String: [String: Any]] else { return nil }
        for snap in snapDict {
            guard let event = Event(eventID: snap.key, dict: snap.value) else { continue }
            events.append(event)
        }
        self.events = events
    }
}
