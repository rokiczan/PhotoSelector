//
//  OrderThumbView.swift
//  PhotoSelector
//
//  Created by Maciej Rokiczan on 17/05/2023.
//

import SwiftUI

struct OrderThumbView: View {
    @EnvironmentObject var viewState: ViewState
    @EnvironmentObject var store: OrderStore
    
    let order: Order
    
    var body: some View {
        Text("order: \(order.id)")
            .cornerRadius(15)
            .frame(width: 200, height: 150)
            .onTapGesture {
                withAnimation {
                    viewState.selectedOrder = order
                    viewState.showAllOrders = false
                }
            }
    }
}

//struct OrderThumbView_Previews: PreviewProvider {
//    static var previews: some View {
//        OrderThumbView()
//    }
//}
