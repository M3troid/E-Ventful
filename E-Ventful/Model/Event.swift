//
//  Event.swift
//  E-Ventful
//
//  Created by Drake Neuenschwander on 3/30/22.
//
// This model sets the data being accessed from the database back into the application. 

import Foundation

struct Event {
    
    //variables set
    var id:String
    var eventName:String
    var eventFromDate:String
    var randomID:String
    var eventToDate:String

    
    //variables initilized
    init(id:String, eventName:String, eventFromDate:String, randomID:String, eventToDate:String) {
        
        //variables reidentified after initilization. 
        self.id = id
        self.eventName = eventName
        self.eventFromDate = eventFromDate
        self.randomID = randomID
        self.eventToDate = eventToDate

    }
}
