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
        
        let image = UIImage(contentsOfFile: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appending(path: "\(fileName).jpg").path())
                            
        ZStack{

        Image(uiImage: image ?? UIImage(systemName: "exclamationmark.triangle.fill")!)
            .resizable()
            .scaledToFit()
            .cornerRadius(8.0)
            ScoreView(score: $score)
        }
    }
}

struct PhotoView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoView(fileName: .constant(""), score: .constant(3))
    }
}
