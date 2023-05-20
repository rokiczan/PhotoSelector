//
//  Order.swift
//  PhotoSelector
//
//  Created by Maciej Rokiczan on 15/05/2023.
//

import SwiftUI

struct Order: Identifiable {
    
    var id = UUID()
    var photos: [Photo] = []
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
    
    mutating func addPhoto(photo: Photo) {
        photos.append(photo)
        save()
    }
}

extension Order: Codable {
    enum CodingKeys: CodingKey {
        case id, photos
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id = try container.decode(String.self, forKey: .id)
        self.id = UUID(uuidString: id) ?? UUID()
        
        photos += try container.decode([Photo].self, forKey: .photos)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id.uuidString, forKey: .id)
        let photos: [Photo] = photos.compactMap{$0 as Photo}
        try container.encode(photos, forKey: .photos)
    }
}
