//
//  ViewState.swift
//  PhotoSelector
//
//  Created by Maciej Rokiczan on 15/05/2023.
//

import SwiftUI

enum OrderListState {
    case list, thumb
}

class ViewState: ObservableObject {
    @Published var showAllOrders = true {
        didSet {
            if showAllOrders {
                selectedOrder = nil
            }
        }
    }
    
    var selectedOrder: Order?
    
    @Published var orderListState: OrderListState = .list
    
}
