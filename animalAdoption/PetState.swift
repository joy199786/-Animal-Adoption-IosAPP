//
//  PetState.swift
//  animalAdoption
//
//  Created by User15 on 2020/1/5.
//  Copyright © 2020 ibob. All rights reserved.
//

import SwiftUI

struct PetState: View {
    @Environment(\.presentationMode) var presentationMode
    var petsData: PetsData
    
    let color = UIColor(red: 175/255, green: 220/255, blue: 195/255, alpha: 0.3)
    
    @State private var name = ""
    @State private var petType = ""
    @State private var card1 = ""
    @State private var card2 = ""
    @State private var card3 = ""
    @State private var favor = 0
    @State private var feedTime = Date()
    @State private var playTime = Date()
    
    @State private var offset = CGSize.zero
    @State private var newPosition = CGSize.zero  //記上次結束的位置
    
    @State private var rotateDegree = 0.0
    @State private var canFeedPet = false
    @State private var canPlayWithPet = true
    @State private var showCard1 = false
    
    var foodTimer: Timer?
    var playTimer: Timer?
    
    @State private var showNameAlert = false
    
    @State private var catState = "cat"
     @State var editPet : Pet
    
    //date count
    //@ObservedObject private var feedTime = timeData()
    @State private var lifetime=DateComponents()
    @State private var playtime=DateComponents()
    @State private var stop=true
    
    
    var timer:Timer{
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true){_ in
            self.lifetime.second! -= 1
            self.playtime.second! -= 1
            if self.lifetime.second! == -1
            {
                self.lifetime.second!=59
                self.lifetime.minute! -= 1
            }
            if self.lifetime.minute! == -1
            {
                self.lifetime.minute!=59
                self.lifetime.hour! -= 1
            }
            if self.lifetime.hour! == -1
            {
                self.lifetime.hour!=23
                self.lifetime.day! -= 1
            }
            if self.lifetime.minute! == 0 && self.lifetime.second! == 0{
                self.canFeedPet = true
            }
            //playtime
            if self.playtime.second! == -1
            {
                self.playtime.second!=59
                self.playtime.minute! -= 1
            }
            if self.playtime.minute! == -1
            {
                self.playtime.minute!=59
                self.playtime.hour! -= 1
            }
            if self.playtime.hour! == -1
            {
                self.playtime.hour!=23
                self.playtime.day! -= 1
            }
        }
    }
    func countDownString(nowDate: DateComponents) -> String {
        return String(format: "%02d:%02d:%02d",
                      nowDate.hour ?? 00,
                      nowDate.minute ?? 00,
                      nowDate.second ?? 00)
    }
    
    
    var body: some View {
        
        
        ZStack{
            
            Image("background").resizable().scaledToFill().frame(minWidth: 0, maxWidth: .infinity)
            //Color.init(color)
            /*
             self.name = editPet.name
             self.card1 = editPet.card1
             self.card2 = editPet.card2
             self.card3 = editPet.card3
             self.favor = editPet.favor
             */
            Group{
                Image("catGiftDark").position(x: 100, y: 100)
                Image("catGiftDark").position(x: 200, y: 100)
                Image("catGiftDark").position(x: 300, y: 100)
                Image("catToyDark").position(x: 150, y: 450)
                Image("catFoodDark").position(x: 40, y: 600)
                // Text("\(self.name)").font(.system(size: 30)).padding().background(.pink)
                
                
                Image(catState)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 120)
                    .offset(offset)
                    .rotationEffect(Angle(degrees: self.rotateDegree))
                    .animation(Animation.linear(duration: 0.5).repeatCount(3, autoreverses: true))

                    .gesture(DragGesture()
                        .onChanged({(value) in self.offset = CGSize(width: value.translation.width + self.newPosition.width, height: value.translation.height + self.newPosition.height)}).onEnded({(value) in
                            self.rotateDegree = 0
                                self.newPosition = self.offset
                                 let disWidth = self.newPosition.width-100
                                   let disHeight = self.newPosition.height-110
                            print(self.newPosition)
                                   if disWidth<40 && disWidth > -40 && disHeight<40 && disHeight > -40{
                                   self.catState="cat_sleep"
                                    }
                                   else{self.catState="cat"}
                            })
        
                )
            }
            
            /*
             let disWidth = self.newPosition.width-300
             let disHeight = self.newPosition.width-300
             if disWidth<50  && disHeight<50{
             self.catState="cat_sleep"
             }
             */
            //Text("\(self.name)").font(.system(size: 30)).padding().background(.pink).position(x: 40, y: 50)
            
            
            if canFeedPet == true{
                Button(action: {
                    self.feedTime = Date()+100
                    self.lifetime=Calendar.current.dateComponents([.year,.day,.hour,.minute,.second], from: Date()
                        , to: self.feedTime)
                    _ = self.timer
                    self.canFeedPet = false
                    if self.favor < 12{
                        self.favor = self.favor+1
                    }
                    var pet = Pet(name: self.name,petType:self.petType, card1: self.card1,card2: self.card2,card3: self.card3, favor: self.favor, isOn :true, feedTime:self.feedTime, playTime:self.playTime, isDead: false)
                    pet.id = self.editPet.id
                    self.editPet = pet
                    let index = self.petsData.pets.firstIndex {
                        $0.id == self.editPet.id
                        }!
                    self.petsData.pets[index] = pet
                    print(self.favor)
                    print("food")
                }){
                    
                    Image("catFood")
                }.position(x: 40, y: 600)
                    .buttonStyle(PlainButtonStyle())
            }
            if canPlayWithPet == true{
                Button(action: {
                     self.rotateDegree += 30
                    self.catState = "catPlay"
                    self.canPlayWithPet = false
                    print("play")
                }){
                    Image("catToy")
                }.position(x: 150, y: 450)
                    .buttonStyle(PlainButtonStyle())
            }
            showFavor(favor: self.favor, card1:self.card1 , card2: self.card2, card3:self.card3 )
            FeedTimer(lifetime: self.$lifetime, canFeedPet:self.$canFeedPet)
            
            
        }.onAppear{
            self.name = self.editPet.name
            self.petType = self.editPet.petType
            self.card1 = self.editPet.card1
            self.card2 = self.editPet.card2
            self.card3 = self.editPet.card3
            self.favor = self.editPet.favor
            self.feedTime = self.editPet.feedTime
            self.playTime = self.editPet.playTime
            
            self.lifetime=Calendar.current.dateComponents([.year,.day,.hour,.minute,.second], from: Date()
                , to: self.feedTime)
            _ = self.timer
            if self.feedTime<Date(){
                self.canFeedPet = true
                print()
            }
            self.playtime=Calendar.current.dateComponents([.year,.day,.hour,.minute,.second], from: Date()
                , to: self.feedTime)
            _ = self.timer
            if self.playTime<Date(){
                self.canPlayWithPet = true
                print()
            }
            
            //time
        }
    }
}

struct PetState_Previews: PreviewProvider {
    static var previews: some View {
        PetState(petsData: PetsData(), editPet: Pet(name: "", petType: "", card1: "", card2: "", card3: "", favor: 0, isOn: false, feedTime:Date(), playTime:Date(),isDead: false))
    }
}

struct showFavor:View{
    
    let screenwidth = UIScreen.main.bounds.size.width
    let screenheight = UIScreen.main.bounds.size.height
    @State private var showCard1 = false
    @State private var showCard2 = false
    @State private var showCard3 = false
    var favor: Int
    var card1: String
    var card2: String
    var card3: String
    var body: some View{
        ZStack{
            
            if self.favor > 3{
                Button(action: {self.showCard1 = true}){
                    Image("catGift").position(x: 100, y: 100)
                    // .animation(Animation.easeIn(duration:0.4))
                }
                .buttonStyle(PlainButtonStyle())
            }
            if self.favor > 7{
                Button(action: {self.showCard2 = true}){
                    Image("catGift").position(x: 200, y: 100)
                    // .animation(Animation.easeIn(duration:0.4))
                }
                .buttonStyle(PlainButtonStyle())
            }
            if self.favor > 11{
                Button(action: {self.showCard3 = true}){
                    Image("catGift").position(x: 300, y: 100)
                    //.animation(Animation.easeIn(duration:0.4))
                }
                .buttonStyle(PlainButtonStyle())
            }
            showCard(card1: self.card1, card2: self.card2, card3: self.card3, showCard1: self.$showCard1, showCard2: self.$showCard2, showCard3: self.$showCard3)
            
        }
    }
}


struct  showCard:View {
    var card1: String
    var card2: String
    var card3: String
    @Binding  var showCard1:Bool
    @Binding  var showCard2:Bool
    @Binding  var showCard3:Bool
    let screenwidth = UIScreen.main.bounds.size.width
    let screenheight = UIScreen.main.bounds.size.height
    var body: some View{
        VStack{
            if showCard1{
                Button(action:{
                    self.showCard1 = false
                }, label: {
                    Image(self.card1) .resizable().scaledToFill()
                        .frame(width: screenwidth-300, height: screenheight-250)
                }).buttonStyle(PlainButtonStyle())
            }
            
            if showCard2{
                Button(action:{
                    self.showCard2 = false
                }, label: {
                    Image(self.card2) .resizable().scaledToFill()
                        .frame(width: screenwidth-300, height: screenheight-250)
                    
                }).buttonStyle(PlainButtonStyle())
            }
            if showCard3{
                Button(action:{
                    self.showCard3 = false
                }, label: {
                    Image(self.card3) .resizable().scaledToFill()
                        .frame(width: screenwidth-300, height: screenheight-250)
                    
                }).buttonStyle(PlainButtonStyle())
            }
        }
    }
}


struct  FeedTimer: View {
    
    func countDownString(nowDate: DateComponents) -> String {
        return String(format: "%02d:%02d:%02d",
                      nowDate.hour ?? 00,
                      nowDate.minute ?? 00,
                      nowDate.second ?? 00)
    }
    func setFeedTrue() {
        canFeedPet = true
    }
    @Binding var lifetime: DateComponents
    @Binding var canFeedPet : Bool
    
    var body: some View{
        ZStack{
            //ZStack{
            if canFeedPet == false{
            if lifetime.second != nil{
                if lifetime.second != 0{
                   Text("\(lifetime.hour!):\(lifetime.minute!):\(lifetime.second!)").position(x: 40, y: 650).font(Font.system(size: 16))
                    
                }

            }
            //print(self.lifetime)
            }
            
        }
        
        }
    }

