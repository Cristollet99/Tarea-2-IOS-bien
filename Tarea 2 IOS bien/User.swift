//
//  User.swift
//  Tarea 2 IOS bien
//
//  Created by Cristobal Lletget Luque on 19/1/22.
//

import Foundation

struct User: Decodable{
    let id: Int?
    let name: String?
    let email: String?
    let password: String?
    let workstation: String?
    let token: String?
    let salary: Int?
    let biography: String?
    
    let msg : String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case password
        case workstation
        case token
        case salary
        case biography
        case msg
    }
}

