//
//  ToolbarView.swift
//  PhotoSelector
//
//  Created by Maciej Rokiczan on 24/04/2023.
//

import SwiftUI
import PhotosUI

struct ToolbarView: View {
    @State var showPicker: Bool = false
    @Binding var selectedItems: [PhotosPickerItem]
    var body: some View {
        HStack{
            Button(action: {showPicker.toggle()}) {
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
        .photosPicker(isPresented: $showPicker, selection: $selectedItems)
    }
}

//struct Toolbar_Previews: PreviewProvider {
//    static var previews: some View {
//        ToolbarView()
//            .previewLayout(.sizeThatFits)
//    }
//}
