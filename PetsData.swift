//
//  PetsData.swift
//  animalAdoption
//
//  Created by User15 on 2020/1/5.
//  Copyright © 2020 ibob. All rights reserved.
//

import Foundation
class PetsData: ObservableObject{
    
    @Published var pets = [Pet](){
        didSet{
            let encoder = JSONEncoder()
            if let data = try? encoder.encode(pets){
                UserDefaults.standard.set(data, forKey:"pets")
            }
        }
    }
    
    init(){
        if let data =
            UserDefaults.standard.data(forKey:"pets"){
            let decoder = JSONDecoder()
            if let decodedData = try? decoder.decode([Pet].self, from:data){
                pets = decodedData
            }
        }
    }
    
}
