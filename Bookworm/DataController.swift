//
//  Actor.swift
//  Bookworm
//
//  Created by Filippo on 27/12/23.
//

import Foundation
import SwiftData

@MainActor
class DataController {
 static let previewContainer: ModelContainer = {
	do {
	 let config = ModelConfiguration(isStoredInMemoryOnly: true)
	 let container = try ModelContainer(for: Book.self, configurations: config)
	 let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
	 for i in 1...9 {
		let book = Book(title: "Title \(i)", author:  "Author \(i)", genre:  genres[Int.random(in: 0 ..< genres.count)], review:  "Review \(i)", rating: Int.random(in: 0..<5), date: Date.now)
		container.mainContext.insert(book)
	 }
	 
	 return container
	} catch {
	 fatalError("Failed to create model container for previewing: \(error.localizedDescription)")
	}
 }()
}
