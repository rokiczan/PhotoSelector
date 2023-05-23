//
//  Photo.swift
//  PhotoSelector
//
//  Created by Maciej Rokiczan on 24/04/2023.
//

import SwiftUI

struct Photo: Identifiable, Codable, Hashable {
    var id: UUID
    var score: Int
}
