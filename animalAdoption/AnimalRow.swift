//
//  AnimalRow.swift
//  animalAdoption
//
//  Created by User09 on 2019/12/22.
//  Copyright © 2019 ibob. All rights reserved.
//

import SwiftUI

struct AnimalRow: View {
    
    var animal: Animal
     
    var body: some View {
     HStack{
            NetworkImage(url: animal.album_file)
                              .scaledToFill()
                              .frame(width: 120, height: 120)
                              .cornerRadius(30)
                    
               VStack(alignment: .leading) {
                   Text(animal.animal_kind)
                       .bold()
                    .foregroundColor(.blue)
                .font(.system(size: 25))
                   Text(animal.animal_place)
                   Text(animal.animal_colour)
                   // Text(animal.animal_sex)
               }.font(.system(size: 18))
                   .padding(5)
    
           }
    }
}
    


struct AnimalRow_Previews: PreviewProvider {
    
    static var previews: some View {
        AnimalRow(animal: Animal(animal_id: 135177, animal_subid: "1081434", animal_area_pkid: 5, animal_shelter_pkid: 78, animal_place: "宜蘭縣流浪動物中途之家", animal_kind: "狗", animal_sex: "M", animal_bodytype: "BIG", animal_colour: "黑白色",  animal_age: "ADULT", animal_sterilization: "T", animal_bacterin: "F", animal_foundplace: "城東路", animal_title: "", animal_status: "OPEN", animal_remark: "", animal_caption: "", animal_opendate: "2019-12-24", animal_closeddate: "2999-12-31", animal_update: "2019/12/17", animal_createtime: "2019/12/17", shelter_name: "宜蘭縣流浪動物中途之家", album_file:  "http://asms.coa.gov.tw/amlapp/upload/pic/936e23f0-a408-4bc9-bd8f-6ef882593359_org.jpg", album_update: "", cDate: "2019/12/17", shelter_address: "宜蘭縣五結鄉成興村利寶路60號", shelter_tel: "039602350 分機620"))

    }
}
