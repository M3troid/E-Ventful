//
//  Event.swift
//  E-Ventful
//
//  Created by Drake Neuenschwander on 3/30/22.
//

import Foundation

struct Event {
    
    var id:String
    var eventName:String
    var eventFromDate:String
    
    init(id:String, eventName:String, eventFromDate:String) {
        self.id = id
        self.eventName = eventName
        self.eventFromDate = eventFromDate
    }
}
