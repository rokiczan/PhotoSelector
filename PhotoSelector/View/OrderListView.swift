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
            .frame(maxWidth: .infinity)
            .padding(10)
            .font(.system(size: 20, weight: .bold))
            .foregroundColor(Color(.white))
            .background(Color(.gray))
            .onTapGesture {
                withAnimation {
                    viewState.selectedOrder = order
                    viewState.showAllOrders = false
                }
            }
        
    }
}

struct OrderListView_Previews: PreviewProvider {
    static var previews: some View {
        OrderListView(order: initialOrders[0])
            .environmentObject(ViewState())
            .environmentObject(OrderStore())
            .previewLayout(.sizeThatFits)
    }
}
