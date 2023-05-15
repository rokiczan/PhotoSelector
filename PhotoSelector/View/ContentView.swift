//
//  ContentView.swift
//  PhotoSelector
//
//  Created by Maciej Rokiczan on 23/04/2023.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    
    @State private var selectedItems = [PhotosPickerItem]()
    @State private var selectedPhotos = [Photo]()
    
    var body: some View {
        VStack {
            
            TabView{
                ForEach(selectedPhotos) { selectedPhoto in
                    PhotoView(fileName: selectedPhoto.id)
                }
            }
            .tabViewStyle(.page)
            
            ScrollView(.horizontal){
                HStack{
                    ForEach(selectedPhotos) { selectedPhoto in
                        PhotoView(fileName: selectedPhoto.id)
                    }
                }
            }
            .frame(height: 100)
            
            ToolbarView(selectedItems: $selectedItems)
   
                .onChange(of: selectedItems) { selectedItems in
                    Task {
                        let savePath = FileManager.documentsDirectory
                        print(savePath)
                        for item in selectedItems {
                            if let data = try? await item.loadTransferable(type: Data.self){
                                if let uiImage = UIImage(data: data) {
                                    if let jpegData = uiImage.jpegData(compressionQuality: 0.8) {
                                        let uniqueName = UUID().uuidString
                                        try? jpegData.write(to: savePath.appendingPathComponent("\(uniqueName).jpg"))
                                        let photo = Photo(id: uniqueName)
                                        selectedPhotos.append(photo)
                                    }
                                }
                            }
                        }
                    }
                }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
