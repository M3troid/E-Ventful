//
//  DatabaseService.swift
//  E-Ventful
//
//  Created by Drake Neuenschwander on 4/8/22.
//

import Foundation
import Firebase
import FirebaseAuth


class DatabaseService {
    
    static let shared = DatabaseService()
    private init() {}
    
    
    
    let eventRef = Database.database().reference().child("users")
    let userRef = Database.database().reference()
}
