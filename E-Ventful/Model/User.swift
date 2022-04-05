//
//  User.swift
//  E-Ventful
//
//  Created by Drake Neuenschwander on 4/4/22.
//

import Foundation

struct User: Codable {
    var firstName: String
    var lastName: String
    var signUpDate = Date.now
    
}
