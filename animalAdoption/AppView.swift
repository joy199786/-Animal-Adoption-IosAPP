//
//  AppView.swift
//  animalAdoption
//
//  Created by User15 on 2020/1/5.
//  Copyright © 2020 ibob. All rights reserved.
//

import SwiftUI

struct AppView: View {
    var body: some View {
        TabView{
            ContentView().tabItem{
                Image(systemName: "music.house.fill")
                Text("動物認養")
            }
            
            SimulaPet().tabItem{
                Image(systemName: "info.circle.fill")
                Text("寵物模擬")
            }
            /*
            AnimationView().tabItem{
                Image(systemName: "video.fill")
                Text("Fate系列動畫")
            }*/
        }.accentColor(.green)
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
