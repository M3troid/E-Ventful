//
//  Event.swift
//  E-Ventful
//
//  Created by Drake Neuenschwander on 3/30/22.
//

import Firebase

struct EventModel {
    
     
     var eventName: String?
     var eventFromDate: String?
     
     init(eventName: String?, eventFromDate: String?){
         self.eventName = eventName
         self.eventFromDate = eventFromDate
     }
}
