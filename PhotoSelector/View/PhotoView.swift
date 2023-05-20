//
//  PhotoView.swift
//  PhotoSelector
//
//  Created by Maciej Rokiczan on 24/04/2023.
//

import SwiftUI

struct PhotoView: View {
    @Binding var fileName: String
    @Binding var score: Int
    
    var body: some View {
        
        if let uiImage = UIImage(contentsOfFile: FileManager.documentsDirectory.appending(path: "\(fileName).jpg").path() ) {
            ZStack{
                
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
                .cornerRadius(8.0)
                ScoreView(score: $score)
            }
        } else {
            ZStack{
                
            Image("example1")
                .resizable()
                .scaledToFit()
                .cornerRadius(8.0)
            ScoreView(score: $score)
            }
            
        }
    }
}

//struct PhotoView_Previews: PreviewProvider {
//    static var previews: some View {
//        PhotoView(fileName: nil, score: nil)
//    }
//}
