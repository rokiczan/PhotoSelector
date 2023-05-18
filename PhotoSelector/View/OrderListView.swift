//
//  OrderListView.swift
//  PhotoSelector
//
//  Created by Maciej Rokiczan on 18/05/2023.
//

import SwiftUI

struct OrderListView: View {
    @EnvironmentObject var viewState: ViewState
    @EnvironmentObject var store: OrderStore
    
    let order: Order
    
    var body: some View {
        Text("order: \(order.id)")
            .onTapGesture {
                withAnimation {
                    viewState.selectedOrder = order
                    viewState.showAllOrders = false
                }
            }
        
    }
}

//struct OrderListView_Previews: PreviewProvider {
//    static var previews: some View {
//        OrderListView()
//    }
//}
