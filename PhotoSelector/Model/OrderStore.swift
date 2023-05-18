//
//  OrderStore.swift
//  PhotoSelector
//
//  Created by Maciej Rokiczan on 15/05/2023.
//

import SwiftUI

class OrderStore: ObservableObject {
    @Published var orders: [Order] = []
    init() {
        orders = load()
    }
    
    func addOrder() -> Order {
        let order = Order()
        orders.append(order)
        order.save()
        return order
    }
    
    func index(for order: Order) -> Int? {
        orders.firstIndex { $0.id == order.id }
    }
}

extension OrderStore {
    func load() -> [Order] {
        var orders: [Order] = []
        guard let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.path,
              let enumerator = FileManager.default.enumerator(atPath: path),
              let files = enumerator.allObjects as? [String]
        else { return orders }
        let orderFiles = files.filter { $0.contains(".order")}
        for orderFile in orderFiles {
            do {
                let path = path + "/" + orderFile
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let decoder = JSONDecoder()
                let order = try decoder.decode(Order.self, from: data)
                orders.append(order)
            } catch {
                print("Error: ", error.localizedDescription)
            }
        }
        return orders
    }
}
