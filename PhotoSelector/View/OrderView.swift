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
    @Environment(\.scenePhase) private var scenePhase
    
    @Binding var order: Order
    
    @State private var selectedItems = [PhotosPickerItem]()

    
    var body: some View {
        VStack {
            HStack{
                
                if let selectedOrder = viewState.selectedOrder {
                    Text("zz\(selectedOrder.id)")
                    Button(action: {
                        viewState.showAllOrders = true
                    }) {
                        Text("Done")
                    }
                }
                //Text("\(viewState.selectedOrder)")
            }
            TabView{
                ForEach($order.photos, id: \.id) { $photo in
                    PhotoView(fileName: $photo.id, score: $photo.score)
                }
            }
            .tabViewStyle(.page)
            
            ScrollView(.horizontal){
                HStack{
                    ForEach($order.photos, id: \.id) { $photo in
                        PhotoView(fileName: $photo.id, score: $photo.score)
                    }
                }

            }
            .frame(height: 100)
            
            ToolbarView(selectedItems: $selectedItems)
   
                .onChange(of: selectedItems) { selectedItems in
                    Task {
                        let savePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                        print(savePath)
                        for item in selectedItems {
                            if let data = try? await item.loadTransferable(type: Data.self){
                                if let uiImage = UIImage(data: data) {
                                    if let jpegData = uiImage.jpegData(compressionQuality: 0.8) {
                                        let uniqueName = UUID().uuidString
                                        try? jpegData.write(to: savePath.appendingPathComponent("\(uniqueName).jpg"))
                                        let photo = Photo(id: uniqueName, score: 1)
                                        
                                        order.addPhoto(photo: photo)
                                    }
                                }
                            }
                        }
                    }
                }
        }
        .onChange(of: scenePhase) { newScenePhase in
          if newScenePhase == .inactive {
            order.save()
          }
        }
        .onDisappear {
          order.save()
        }
        .padding()

    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
