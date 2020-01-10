//
//  Pet.swift
//  animalAdoption
//
//  Created by User15 on 2020/1/5.
//  Copyright © 2020 ibob. All rights reserved.
//

import Foundation

struct Pet: Identifiable, Codable {
    var id = UUID()
    var name: String
    var petType: String
    var card1: String
    var card2: String
    var card3: String
    var favor: Int
    var isOn: Bool
    var feedTime : Date
    var playTime : Date
    var isDead: Bool
}
