//
//  PetRow.swift
//  animalAdoption
//
//  Created by User15 on 2020/1/5.
//  Copyright © 2020 ibob. All rights reserved.
//

import SwiftUI

struct PetRow: View {
    
    var pet : Pet
    var body: some View {
         ZStack{
            VStack{
                
               HStack{
               
                if pet.isDead != true{
                    Image(pet.petType).resizable()
                    .scaledToFill().frame(width: 100, height: 100)
                }
                   VStack(alignment: .leading){
                       Text(pet.name)
                       .foregroundColor(.purple)
                        .font(.system(size: 36))
                   }
                   Spacer()
               }
               
                 typeBarChart(typeWidths: pet.favor)//editPet!.favor
                
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

struct PetRow_Previews: PreviewProvider {
    static var previews: some View {
        PetRow(pet: Pet(name: "", petType: "", card1: "", card2: "", card3: "", favor: 0, isOn: false, feedTime:Date(), playTime:Date(), isDead:false))
    }
}


struct typeBarChart: View
{
   
    var typeWidths: Int
    var body: some View
    {
        HStack//(totalHeight:270)
        {
        
           Text("好感").padding(EdgeInsets(top: 0, leading: 10, bottom: 8, trailing: 0))
                ZStack(alignment: .leading)
                {
                    Path
                    {
                        (path) in
                        path.move(to: CGPoint(x: 0, y: 18))
                        path.addLine(to: CGPoint(x: 0, y: 40))
                        path.addLine(to: CGPoint(x: 242, y: 40))
                        path.addLine(to: CGPoint(x: 242, y: 18))
                        path.addLine(to: CGPoint(x: 0, y: 18))
                    }
 
                    .stroke(Color.black, lineWidth: 2)
                    
                    typeBar(finalWidth: typeWidths, r: 1, g: 0, b: 0).padding(EdgeInsets(top: 19, leading: 0.5, bottom: 20, trailing: 0))
                }
            }
            .frame(width: 300, height: 40)
            .padding(EdgeInsets(top: 0, leading: -30, bottom: 0, trailing: 0))

    }
}


struct typeBar: View
{
    var finalWidth: Int
    var r: Double
    var g: Double
    var b: Double
    @State private var width: CGFloat = 0
    var body: some View
    {
       
            Rectangle()
            .fill(Color(red: r, green: g, blue: b))
            .frame(width: width, height: 20)
            .animation(.linear(duration: 1))
            .onAppear
            {
                self.width = CGFloat(self.finalWidth)*20
            }
        
    }
}
