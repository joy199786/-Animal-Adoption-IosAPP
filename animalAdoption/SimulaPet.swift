//
//  SimulaPet.swift
//  animalAdoption
//
//  Created by User15 on 2020/1/5.
//  Copyright © 2020 ibob. All rights reserved.
//

import SwiftUI

struct SimulaPet: View {
    @ObservedObject var petsData = PetsData()
    @State var nowIndex = -1
    @State var showAddPet = false
    let photoWidth = (UIScreen.main.bounds.size.width - 10) / 2
   // var nowPet: Pet?
    
    let color = UIColor(red: 175/255, green: 220/255, blue: 195/255, alpha: 0.3)
       
    var body: some View {
        /*
        List{
                   ForEach(0..<names.count){ (row) in
                       HStack(spacing: 5){
                           ForEach(0..<self.names[row].count){(col) in
                               Image(self.names[row][col])
                               .resizable()
                               .scaledToFill()
                               .frame(width: self.photoWidth, height: self.photoWidth )
                               .clipped()
                           }
                       }
                   }
                   .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
               }
               .onAppear{
                   UITableView.appearance().separatorColor = .clear
               }
        
        */
        VStack{
            NavigationView{
                List{
                            ForEach(self.petsData.pets){ (pet) in
                                NavigationLink(destination: PetState(petsData: self.petsData, editPet: pet)){
                                    PetRow(pet: pet)
                                }
                            }.onMove { (indexSet, index) in
                                self.petsData.pets.move(fromOffsets: indexSet,
                                                toOffset: index)
                            }
                            .listRowBackground(Color.yellow)
                        //.listRowBackground(Color.init(color))
                }.onAppear{
                    UITableView.appearance().separatorColor = .clear
                }.navigationBarItems(leading: Button(action:{ self.showAddPet = true
                }, label: { Image(systemName:"plus.circle.fill") })).sheet(isPresented: $showAddPet){
                    NavigationView{
                        PetAdd(petsData:self.petsData)
                    }
                    
                }
            
            }
            
        
        }
    }
}

struct SimulaPet_Previews: PreviewProvider {
    static var previews: some View {
        SimulaPet()
    }
}
