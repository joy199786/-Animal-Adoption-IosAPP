//
//  Data.swift
//  animalAdoption
//
//  Created by User15 on 2020/1/5.
//  Copyright © 2020 ibob. All rights reserved.
//

import Foundation

struct User:Codable {
    var Account: String
    var Password: String
    var Name: String
}
struct UserData:Codable {
    var data: [User]
}
