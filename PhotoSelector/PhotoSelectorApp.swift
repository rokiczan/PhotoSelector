//
//  PhotoSelectorApp.swift
//  PhotoSelector
//
//  Created by Maciej Rokiczan on 23/04/2023.
//

import SwiftUI

@main
struct PhotoSelectorApp: App {
    @StateObject var store = OrderStore()
    @StateObject var viewState = ViewState()
    
    var body: some Scene {
        WindowGroup {
            OrdersView()
                .environmentObject(store)
                .environmentObject(viewState)
                .onAppear{
                    print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.path ?? "zzz")
                }
        }
    }
}
