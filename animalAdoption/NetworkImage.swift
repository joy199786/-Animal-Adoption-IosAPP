//
//  NetworkImage.swift
//  MusicApp
//
//  Created by SHIH-YING PAN on 2019/11/27.
//  Copyright © 2019 SHIH-YING PAN. All rights reserved.
//

import SwiftUI

struct NetworkImage: View {
    var url: String
    @State private var uiImage = UIImage(systemName: "photo")!
    
    func downLoad() {
        if let url = URL(string: url) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data, let uiImage = UIImage(data: data) {
                    self.uiImage = uiImage
                    
                }
            }.resume()
            
        }
        
        
    }
    
    var body: some View {
        Image(uiImage: uiImage)
            .resizable()
            .onAppear {
                self.downLoad()
        }
    }
    
    
}

struct NetworkImage_Previews: PreviewProvider {
    static var previews: some View {
        NetworkImage(url:  "http://asms.coa.gov.tw/amlapp/upload/pic/783193a3-6a40-4a22-9737-4366959700a6_org.jpg")
    }
}
