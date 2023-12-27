//
//  ContentView.swift
//  Bookworm
//
//  Created by Filippo on 27/12/23.
//

import SwiftData
import SwiftUI

struct ContentView: View {
 @Environment(\.modelContext) var modelContext
 @Query(sort: [
	SortDescriptor(\Book.title),
	SortDescriptor(\Book.author)
 ]) var books: [Book]
 
 @State private var showingAddScreen = false
 
 var body: some View {
	NavigationStack {
	 List {
		ForEach(books) { book in
		 NavigationLink(value: book) {
			HStack {
			 EmojiRatingView(rating: book.rating)
				.font(.largeTitle)
			 
			 VStack(alignment: .leading) {
				Text(book.title)
				 .font(.headline)
				Text(book.author)
				 .foregroundStyle(.secondary)
			 }
			}
		 }
		}.onDelete(perform: deleteBooks)
	 }
	 .navigationDestination(for: Book.self) { book in
		DetailView(book: book)
	 }
		.navigationTitle("Bookworm")
		.toolbar {
		 ToolbarItem(placement: .topBarTrailing) {
			Button("Add Book", systemImage: "plus") {
			 showingAddScreen.toggle()
			}
		 }
		 ToolbarItem(placement: .topBarLeading) {
			EditButton()
		 }
		}
		.sheet(isPresented: $showingAddScreen) {
		 AddBookView()
		}
	}
 }
 
 func deleteBooks(at offsets: IndexSet) {
	for offset in offsets {
	 // find this book in our query
	 let book = books[offset]
	 
	 // delete it from the context
	 modelContext.delete(book)
	}
 }
 
}



#Preview {
 let config = ModelConfiguration(isStoredInMemoryOnly: true)
 let container = try! ModelContainer(for: Book.self, configurations: config)
 let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
 
 for i in 1..<10 {
	let book = Book(title: "Title \(i)", author: "Author \(i)", genre: genres[Int.random(in: 0 ..< genres.count)], review: "Review \(i)", rating: Int.random(in: 1 ... 5), date: Date.now)
	container.mainContext.insert(book)
 }
 
 let std_container = DataController()
 
 return ContentView()
	.modelContainer(container)
}
