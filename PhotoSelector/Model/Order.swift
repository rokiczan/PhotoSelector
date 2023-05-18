//
//  Order.swift
//  PhotoSelector
//
//  Created by Maciej Rokiczan on 15/05/2023.
//

import SwiftUI

struct Order: Identifiable {
    var id = UUID()
    
    func save() {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(self)
            let filename = "\(id).order"
            if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(filename) {
                try data.write(to: url)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension Order: Codable {
    
}
