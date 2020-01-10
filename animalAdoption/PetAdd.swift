//
//  PetAdd.swift
//  animalAdoption
//
//  Created by User15 on 2020/1/5.
//  Copyright © 2020 ibob. All rights reserved.
//

import SwiftUI

struct PetAdd: View {
    @Environment(\.presentationMode) var presentationMode
          var petsData: PetsData
    
    @State private var name = ""
   @State private var selectedType = ""
      @State private var card1 = ""
       @State private var card2 = ""
       @State private var card3 = ""
       @State private var favor = 0
        @State private var isOn = true
     @State private var feedTime = Date()
     @State private var playTime = Date()
    
     @State private var showNameAlert = false
    
    var body: some View {
      Form {
           TextField("寵物名字", text: $name)
        proType(selectedType: self.$selectedType)
           //Toggle("真心", isOn: $trueHeart)
       }
        .navigationBarTitle("Add new pet")
                      .navigationBarItems(trailing: Button("Save") {
                       
                       if (self.name == "") || (self.selectedType == "")
                       {
                           self.showNameAlert = true
                       }
                       else{
                        let pet = Pet(name: self.name, petType: self.selectedType, card1: "catCard1",card2: "catCard3",card3: "catCard5",favor: 0, isOn: true, feedTime:Date(), playTime:Date(), isDead: false)
                              
                            self.petsData.pets.insert(pet, at: 0)
                            self.presentationMode.wrappedValue.dismiss()
                       }
                          
                  }
                  .alert(isPresented: $showNameAlert)
                         {
                             () -> Alert in
                             return Alert(title: Text("無法儲存!!"), message: Text("輸入不得為空白"))
                         })
                    
    }
}

struct PetAdd_Previews: PreviewProvider {
    static var previews: some View {
        PetAdd(petsData: PetsData())
    }
}

struct proType: View
{
    @Binding var selectedType: String
    var types = ["cat", "dog"]
    var body: some View
    {
        Picker(selection: $selectedType, label: Text("類型"))
        {
            ForEach(types, id: \.self)
            {
                (type) in
                Text(type)
            }
        }
        //.frame(width: 180)
        .pickerStyle(SegmentedPickerStyle())
    }
}
