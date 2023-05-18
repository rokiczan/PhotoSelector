//
//  OrdersListView.swift
//  PhotoSelector
//
//  Created by Maciej Rokiczan on 17/05/2023.
//

import SwiftUI

struct OrdersListView: View {
    @EnvironmentObject var viewState: ViewState
    @EnvironmentObject var store: OrderStore
    
    var body: some View {
        ScrollView{
            LazyVGrid(columns: [GridItem(.flexible())]) {
                ForEach(store.orders) { order in
                    OrderListView(order: order)
                }
            }
        }
    }
}

struct OrdersListView_Previews: PreviewProvider {
    static var previews: some View {
        OrdersListView()
            .environmentObject(ViewState())
            .environmentObject(OrderStore())
        
    }
}
