//
//  Event.swift
//  E-Ventful
//
//  Created by Drake Neuenschwander on 3/30/22.
//

import Firebase

struct Event {
    
    let ref: DatabaseReference?
    let key: String
    let eventName: String
    let eventFromDate: String
    
    init(key: String = "", eventName: String, eventFromDate: String){
        self.ref = nil
        self.key = key
        self.eventName = eventName
        self.eventFromDate = eventFromDate
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let eventName = value ["eventName"] as? String,
            let eventFromDate = value["eventFromDate"] as? String
        else {
            return nil
        }
        
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.eventName = eventName
        self.eventFromDate = eventFromDate
    }
    
    func toAnyObject() -> Any {
        return [
            "eventName": eventName,
            "eventFromDate": eventFromDate
        ]
    }
}
