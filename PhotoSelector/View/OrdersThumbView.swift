//
//  OrdersListView.swift
//  PhotoSelector
//
//  Created by Maciej Rokiczan on 17/05/2023.
//

import SwiftUI

struct OrdersThumbView: View {
    @EnvironmentObject var viewState: ViewState
    @EnvironmentObject var store: OrderStore
    
    var body: some View {
        ScrollView{
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                ForEach(store.orders) { order in
                    OrderThumbView(order: order)
                }
            }
        }
    }
}

struct OrdersThumbView_Previews: PreviewProvider {
    static var previews: some View {
        OrdersListView()
            .environmentObject(ViewState())
            .environmentObject(OrderStore())
        
    }
}
