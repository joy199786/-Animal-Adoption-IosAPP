//
//  AnimalDetailView.swift
//  animalAdoption
//
//  Created by User15 on 2020/1/4.
//  Copyright © 2020 ibob. All rights reserved.
//

import SwiftUI

struct AnimalDetailView: View {
    var animal:Animal
        var body: some View {
        ZStack{
            VStack(alignment: .center) {
            //Spacer()
                   NetworkImage(url: animal.album_file)
                     .scaledToFill()
                     .frame(width: 350, height: 350)
                     //.clipped()
                     .cornerRadius(40)
                    //.position(x: 200, y: 300)
                           
                Group{
                          Text(animal.animal_kind)
                              .bold()
                           .foregroundColor(.blue)
                    
                       .font(.system(size: 35))
                          Text(animal.animal_place)
                          Text(animal.animal_colour)
                        if animal.animal_sex == "F" {
                            Text("性別：母").padding(5)
                        }
                        if animal.animal_sex == "M" {
                           Text("性別：公").padding(5)
                        }
                        
                        Text("地址：\(animal.shelter_address)").padding(5)
                        Text("聯絡電話：\(animal.shelter_tel)").padding(5)
                        Text("其他：\(animal.animal_remark)").padding(5).font(.system(size: 15))
                    Spacer()
                }.font(.system(size: 20))//.padding(.init(integerLiteral:35))
                        Button(action: {
                            guard let url = URL(string: "https://asms.coa.gov.tw/Amlapp/App/AnnounceList.aspx?Id=\(self.animal.animal_id)&AcceptNum=\(self.animal.animal_subid)&PageType=Adopt") else { return }
                            /*"https://asms.coa.gov.tw/Amlapp/App/AnnounceList.aspx?Id=\(self.animal.animal_id)&AcceptNum=\(self.animal.animal_subid)&PageType=Adopt" https://asms.coa.gov.tw/Amlapp/Admin_A01/OutApplyEdit.aspx?type=add&ID=\(self.animal.animal_id)&AcceptNum=\(self.animal.animal_subid)&AmlTID=1 */
                            UIApplication.shared.open(url)
                           print("click")
                        }) {
                           Text("我要認養").font(.system(size: 40)).foregroundColor(.white).padding(10)
                            }.background(Color.green).cornerRadius(50)
                      }
            Spacer()
                }.edgesIgnoringSafeArea(.all).padding(.init(integerLiteral:5))
    
    }
}

struct AnimalDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AnimalDetailView(animal:Animal(animal_id: 135177, animal_subid: "1081434", animal_area_pkid: 5, animal_shelter_pkid: 78, animal_place: "宜蘭縣流浪動物中途之家", animal_kind: "狗", animal_sex: "M", animal_bodytype: "BIG", animal_colour: "黑白色",  animal_age: "ADULT", animal_sterilization: "T", animal_bacterin: "F", animal_foundplace: "城東路", animal_title: "", animal_status: "OPEN", animal_remark: "", animal_caption: "", animal_opendate: "2019-12-24", animal_closeddate: "2999-12-31", animal_update: "2019/12/17", animal_createtime: "2019/12/17", shelter_name: "宜蘭縣流浪動物中途之家", album_file:  "http://asms.coa.gov.tw/amlapp/upload/pic/936e23f0-a408-4bc9-bd8f-6ef882593359_org.jpg", album_update: "", cDate: "2019/12/17", shelter_address: "宜蘭縣五結鄉成興村利寶路60號", shelter_tel: "039602350 分機620"))
    }
}
