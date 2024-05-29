//
//  BookListView.swift
//  Flashcards
//
//  Created by Shikha Sharma on 5/29/24.
//

import SwiftUI

struct BookListView: View {
    @ObservedObject var viewModel: FlashcardViewModel
    @State private var newBookTitle = ""
    @State private var editingBook: Book?
    @State private var errorMessage = ""

    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    TextField("Book Title", text: $newBookTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: {
                        if newBookTitle.trimmingCharacters(in: .whitespaces).isEmpty {
                            errorMessage = "Book title cannot be empty"
                        } else {
                            if let book = editingBook {
                                viewModel.updateBook(book: book, title: newBookTitle)
                                editingBook = nil
                            } else {
                                viewModel.addBook(title: newBookTitle)
                            }
                            newBookTitle = ""
                            errorMessage = ""
                        }
                    }) {
                        Text(editingBook == nil ? "Add Book" : "Update Book")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .padding()
                
                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding(.bottom)
                }
                
                List {
                    ForEach(viewModel.books) { book in
                        NavigationLink(destination: BookView(viewModel: viewModel, book: book)) {
                            Text(book.title)
                        }
                        .contextMenu {
                            Button(action: {
                                newBookTitle = book.title
                                editingBook = book
                            }) {
                                Text("Edit")
                                Image(systemName: "pencil")
                            }
                            Button(action: {
                                viewModel.deleteBook(book: book)
                            }) {
                                Text("Delete")
                                Image(systemName: "trash")
                            }
                        }
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { viewModel.deleteBook(book: viewModel.books[$0]) }
                    }
                }
                .frame(height: UIScreen.main.bounds.height * 0.7) // Adjust the height of the list if needed
            }
            .navigationTitle("Books")
        }
    }
}

#Preview {
    BookListView(viewModel: FlashcardViewModel())
}
