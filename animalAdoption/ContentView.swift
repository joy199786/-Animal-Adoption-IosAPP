//
//  ContentView.swift
//  MusicApp
//
//  Created by SHIH-YING PAN on 2019/11/27.
//  Copyright © 2019 SHIH-YING PAN. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    
    @State private var animals = [Animal]()
    @State private var aniKind = [Animal]()
    @State private var aniKindAndplace = [Animal]()
    @State private var selectedKind = "所有"
    @State private var selectedPlace = ""
    @State private var selectedSex = 2
    @State private var pageCount = 0
    @State private var nowPage = 0
    //  let color = UIColor(red: 175/255, green: 220/255, blue: 195/255, alpha: 0.3)
    var sex = ["F", "M","All"]
     var types = ["狗", "貓", "所有"]
     var places = ["基隆市寵物銀行", "臺北市動物之家", "新北市板橋區公立動物之家", "新北市新店區公立動物之家", "新北市中和區公立動物之家", "新北市淡水區公立動物之家", "新北市瑞芳區公立動物之家", "新北市五股區公立動物之家", "新北市八里區公立動物之家", "新北市三芝區公立動物之家", "桃園市動物保護教育園區", "新竹市動物收容所", "新竹縣動物收容所", "臺中市動物之家南屯園區", "臺中市動物之家后里園區", "彰化縣流浪狗中途之家", "南投縣公立動物收容所", "嘉義市流浪犬收容中心", "嘉義縣流浪犬中途之家", "臺南市動物之家灣裡站", "臺南市動物之家善化站", "高雄市壽山動物保護教育園區", "高雄市燕巢動物保護關愛園區", "屏東縣流浪動物收容所", "宜蘭縣流浪動物中途之家", "花蓮縣流浪犬中途之家", "臺東縣動物收容中心", "連江縣流浪犬收容中心", "金門縣動物收容中心", "澎湖縣流浪動物收容中心", "雲林縣流浪動物收容所","新北市政府動物保護防疫處", "苗栗縣生態保育教育中心"]
    
    let color = UIColor(red: 102/255, green: 100/255, blue: 230/255, alpha: 0.3)
    
    
    func fetchAnimals(Page:Int) {
        let urlStr = "https://data.coa.gov.tw/Service/OpenData/TransService.aspx?UnitId=QcbUEzN6E6DL"
        if Page != 0{
          let urlStr = "https://data.coa.gov.tw/Service/OpenData/TransService.aspx?UnitId=QcbUEzN6E6DL$top=200$skip=\(Page*200)"
        }
          if let url = URL(string: urlStr) {
              URLSession.shared.dataTask(with: url) { (data, response , error) in
                  let decoder = JSONDecoder()
                
                do {
                     try decoder.decode([Animal].self, from: data!)
                } catch {
                    print("error", error)
                }
                
                  if let data = data, let animalResults = try? decoder.decode([Animal].self, from: data) {
                    if self.selectedKind == "所有"{
                        if self.selectedPlace == ""{
                            if self.selectedSex == 2{
                                self.animals = animalResults
                            }
                            else{
                                self.animals = animalResults.filter({ $0.animal_sex == self.sex[self.selectedSex]})
                            }
                        }
                        else{
                            if self.selectedSex == 2{
                                self.animals = animalResults.filter({ $0.animal_place == self.selectedPlace})
                            }
                            else{
                                self.animals = animalResults.filter({ $0.animal_place == self.selectedPlace && $0.animal_sex == self.sex[self.selectedSex]})
                            }
                        }
                    }
                    else{
                        if self.selectedPlace == ""{
                            if self.selectedSex == 2{
                                self.animals = animalResults.filter({ $0.animal_kind == self.selectedKind})
                            }
                            else{
                               self.animals = animalResults.filter({ $0.animal_kind == self.selectedKind && $0.animal_sex == self.sex[self.selectedSex]})
                            }
                        }
                        else{
                            if self.selectedSex == 2{
                                self.animals = animalResults.filter({ $0.animal_kind == self.selectedKind && $0.animal_place == self.selectedPlace})
                            }
                            else{
                                self.animals = animalResults.filter({ $0.animal_kind == self.selectedKind && $0.animal_place == self.selectedPlace})
                                self.animals = self.animals.filter({$0.animal_sex == self.sex[self.selectedSex]})
                            }
                        }
                    }
                    //print(self.selectedKind)
                  } else {
                    print("error")
                }
                 self.pageCount = self.animals.count / 200
                print(self.pageCount)
                print(self.pageCount)
              }.resume()
            
          }
      }
  
    
    var body: some View {
        GeometryReader { geometry in
        
        NavigationView {
            VStack{
            
                Form{
                    
                    profileType(selectedKind: self.$selectedKind)
                    .frame(width: 400  , height: 30, alignment: .bottomLeading)
                    profilePlace(selectedPlace: self.$selectedPlace)
                    .frame(width: 400, height: 30, alignment: .bottomLeading)
                    profileSex(selectedSex: self.$selectedSex)
                    .frame(width: 400, height: 30, alignment: .bottomLeading)
                   
                }.frame(width: 400, height: 60, alignment: .bottomLeading)
                
                
                   List{
                        if self.animals.count != 0{
                            Section(header:Text("認養動物")){
                                if self.nowPage == self.pageCount{
                                    ForEach(self.nowPage*200..<self.animals.count, id: \.self){ index in
                                        NavigationLink(destination: AnimalDetailView(animal: self.animals[index])){
                                               AnimalRow(animal: self.animals[index])
                                                }
                                        }
                                    }
                                else{
                                    ForEach(self.nowPage*200..<(self.nowPage+1)*200, id: \.self){ index in
                                    NavigationLink(destination: AnimalDetailView(animal: self.animals[index])){
                                           AnimalRow(animal: self.animals[index])
                                            }
                                    }
                                }
                            }
    
                            }
                        }
                            Text("page \(self.nowPage+1)")
                        pageBtn(pageCount: self.$pageCount, nowPage: self.$nowPage)
                .listRowBackground(Color.init(self.color))

                }
                    .onAppear {
                        self.fetchAnimals(Page:0)
                        UITableView.appearance().separatorColor = .clear
                        
                    }
                   
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct profileType: View
{
    @Binding var selectedKind: String
    var types = ["狗", "貓", "所有"]

    var body: some View
    {
        Picker(selection: $selectedKind, label: Text("種類"))
        {
            ForEach(types, id: \.self)
            {
                (type) in
                Text(type)
            }
           
        }
        //.frame(width: 180)
        //wired: only push the word
    }
}
struct profilePlace: View
{
    @Binding var selectedPlace: String
    var places = ["基隆市寵物銀行", "臺北市動物之家", "新北市板橋區公立動物之家", "新北市新店區公立動物之家", "新北市中和區公立動物之家", "新北市淡水區公立動物之家", "新北市瑞芳區公立動物之家", "新北市五股區公立動物之家", "新北市八里區公立動物之家", "新北市三芝區公立動物之家", "桃園市動物保護教育園區", "新竹市動物收容所", "新竹縣動物收容所", "臺中市動物之家南屯園區", "臺中市動物之家后里園區", "彰化縣流浪狗中途之家", "南投縣公立動物收容所", "嘉義市流浪犬收容中心", "嘉義縣流浪犬中途之家", "臺南市動物之家灣裡站", "臺南市動物之家善化站", "高雄市壽山動物保護教育園區", "高雄市燕巢動物保護關愛園區", "屏東縣流浪動物收容所", "宜蘭縣流浪動物中途之家", "花蓮縣流浪犬中途之家", "臺東縣動物收容中心", "連江縣流浪犬收容中心", "金門縣動物收容中心", "澎湖縣流浪動物收容中心", "雲林縣流浪動物收容所","新北市政府動物保護防疫處", "苗栗縣生態保育教育中心"]

    var body: some View
    {
        Picker(selection: $selectedPlace, label: Text("收容所"))
        {
            ForEach(places, id: \.self)
            {
                (places) in
                Text(places)
            }
           
        }
        //.frame(width: 180)
        
    }
}

struct profileSex: View
{
    @Binding var selectedSex: Int
    var sex = ["母", "公","All"]

    var body: some View
    {
        Picker(selection: $selectedSex, label: Text("性別"))
        {
            ForEach(0..<sex.count)
            {
                (index) in
                Text(self.sex[index])
        
            }
           
        }
        //.frame(width: 180)
        //wired: only push the word
    }
}

struct pageBtn: View
{
    @Binding var pageCount: Int
    @Binding var nowPage: Int
    
    @State var color = UIColor(red: 150/255, green: 0/255, blue: 205/255, alpha: 0.7)
    var body: some View
    {
        ScrollView(.horizontal) {
            HStack{
                ForEach(0 ..< self.pageCount+1, id: \.self){ index  in
                  
                    Button("\(index+1)"){
                        self.nowPage = index
                    }.frame(width: 20 , height: 20, alignment: .leading)
                        .foregroundColor(Color.init(self.color))
                   
                }
            }
        }.frame(width: 300  , height: 20, alignment: .leading)
    }
}


