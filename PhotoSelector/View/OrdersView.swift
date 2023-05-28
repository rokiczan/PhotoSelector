//
//  OrdersView.swift
//  PhotoSelector
//
//  Created by Maciej Rokiczan on 15/05/2023.
//

import SwiftUI

struct OrdersView: View {
    @EnvironmentObject var viewState: ViewState
    @EnvironmentObject var store: OrderStore
    
    var body: some View {
        VStack(spacing: 1) {
            if viewState.showAllOrders {
                ListSelectionView(selection: $viewState.orderListState)
                
                addButton
                    .padding([.top], 20)
                ZStack {
                    switch viewState.orderListState {
                    case .list:
                        OrdersListView()
                    case .thumb:
                        OrdersThumbView()
                    }
                }
            }
            if !viewState.showAllOrders {
                if let index = store.index(for: viewState.selectedOrder!) {
                    OrderView(order: $store.orders[index])
                        .transition(.move(edge: .bottom))
                        .zIndex(1)
                }
            }
        }
        .background(
            Color(.systemGray6)
                .edgesIgnoringSafeArea(.all))
        
    }
    
    var addButton: some View {
        Button {
            viewState.selectedOrder = store.addOrder()
            viewState.showAllOrders = false
        } label: {
            Label("New Order", systemImage: "plus")
                .frame(maxWidth: .infinity)
                .padding(10)
        }
        .font(.system(size: 20, weight: .bold))
        .foregroundColor(Color(.white))
        .background(Color(.black))
        .padding([.top, .bottom], 0)

    }
}

struct OrdersView_Previews: PreviewProvider {
    static var previews: some View {
        OrdersView()
            .environmentObject(ViewState())
            .environmentObject(OrderStore(previewData: true))
    }
}
