//
//  ListSelectionView.swift
//  PhotoSelector
//
//  Created by Maciej Rokiczan on 16/05/2023.
//

import SwiftUI

struct ListSelectionView: View {
    @Binding var selection: OrderListState
    
    var body: some View {
        Picker(selection: $selection, label: Text("")) {
            Image(systemName: "list.bullet")
              .tag(OrderListState.list)
            Image(systemName: "square.grid.2x2.fill")
                .tag(OrderListState.thumb)
        }
        .pickerStyle(SegmentedPickerStyle())
        .frame(width: 180)
    }
}

struct ListSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ListSelectionView(selection: .constant(.list))
    }
}
