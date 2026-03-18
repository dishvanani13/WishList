//
//  WishListApp.swift
//  WishList
//
//  Created by Disha Limbani on 2026-03-16.
//

import SwiftUI
import SwiftData

@main
struct WishListApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Wish.self)
        }
    }
}
