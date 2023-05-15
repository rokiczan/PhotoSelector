//
//  PhotoView.swift
//  PhotoSelector
//
//  Created by Maciej Rokiczan on 24/04/2023.
//

import SwiftUI

struct PhotoView: View {
    let fileName: String?
    
    var body: some View {
        
        if let fileName = fileName,
           let uiImage = UIImage(contentsOfFile: FileManager.documentsDirectory.appending(path: "\(fileName).jpg").path() ) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
                .cornerRadius(8.0)
        } else {
            Image("example1")
                .resizable()
                .scaledToFit()
                .cornerRadius(8.0)
        }
    }
}

struct PhotoView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoView(fileName: nil)
    }
}
