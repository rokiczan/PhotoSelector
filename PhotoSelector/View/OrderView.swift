//
//  OrderView.swift
//  PhotoSelector
//
//  Created by Maciej Rokiczan on 23/04/2023.
//

import SwiftUI
import PhotosUI

struct OrderView: View {
    @EnvironmentObject var viewState: ViewState
    @EnvironmentObject var store: OrderStore
    
    @State private var selectedItems = [PhotosPickerItem]()
    @State private var selectedPhotos = [Photo]()
    
    var body: some View {
        VStack {
            HStack{
                
                if let selectedOrder = viewState.selectedOrder, let index = store.index(for: selectedOrder) {
                    Text("zz\(selectedOrder.id)")
                }
                //Text("\(viewState.selectedOrder)")
                Button(action: {viewState.showAllOrders = true}) {
                    Text("Done")
                }
            }
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
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {viewState.showAllOrders = true}) {
                    Text("Done")
                }
            }
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
