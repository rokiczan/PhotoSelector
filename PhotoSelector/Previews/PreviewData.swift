//
//  PreviewData.swift
//  PhotoSelector
//
//  Created by Maciej Rokiczan on 21/05/2023.
//

import SwiftUI

let initialPhotos: [Photo] = [
Photo(id: UUID(), score: 3)]

let initialOrders: [Order] = [
Order(id: UUID(), photos: initialPhotos),
Order(id: UUID(), photos: initialPhotos),
Order(id: UUID(), photos: initialPhotos),
Order(id: UUID(), photos: initialPhotos)
]
