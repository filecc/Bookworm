//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Filippo on 27/12/23.
//

import SwiftData
import SwiftUI

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(for: Book.self)
    }
}
