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
    @State var showPicker: Bool = false
    @State var selectedPhoto: UUID = UUID()
    
    @State var filter: Int = 0
    
    var body: some View {
        VStack {
            ScoreView(score: $filter)
            HStack{
                
                if let selectedOrder = viewState.selectedOrder {
                    Text("zz\(selectedOrder.id)")
                    Button(action: {
                        viewState.showAllOrders = true
                    }) {
                        Text("Done")
                    }
                }
                Text("x\(selectedPhoto)")

            }
           
            TabView(selection: $selectedPhoto){
                ForEach($order.photos) { photo in
                    if (filter <= photo.score.wrappedValue){
                        PhotoView(fileName: photo.id, score: photo.score)
                    }
                }
            }
            .tabViewStyle(.page)
            
            ScrollView(.horizontal){
                HStack{
                    ForEach($order.photos) { photo in
                        if (filter <= photo.score.wrappedValue){ //to access underlying Int value
                            Button(action: { selectedPhoto = photo.id }) {
                                PhotoView(fileName: photo.id, score: photo.score)
                            }
                        }
                    }
                }

            }
            .frame(height: 100)
            
            HStack{
                Button(action: {
                    selectedItems.removeAll() //show picker without previous selection
                    showPicker.toggle()
                }) {
                    VStack {
                        Image(systemName: "photo")
                        Text("Add photos")
                    }
                }

                Button(action: {}) {
                    VStack {
                        Image(systemName: "delete.left")
                        Text("Delete photos")
                    }
                }
            }
            .photosPicker(isPresented: $showPicker, selection: $selectedItems, matching: .images)
   
                .onChange(of: selectedItems) { selectedItems in
                    Task {
                        let savePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                        print(savePath)
                        for item in selectedItems {
                            if let data = try? await item.loadTransferable(type: Data.self){
                                if let uiImage = UIImage(data: data) {
                                    let reducedImage = uiImage.reduceToHeight(targetHeight: 800)
                                    if let jpegData = reducedImage.jpegData(compressionQuality: 0.7) {
                                        let uniqueName = UUID()
                                        try? jpegData.write(to: savePath.appendingPathComponent("\(uniqueName.uuidString).jpg"))
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView(order: .constant(initialOrders[0]))
            .environmentObject(ViewState())
            .environmentObject(OrderStore())
    }
}
