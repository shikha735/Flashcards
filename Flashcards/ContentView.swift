//
//  ContentView.swift
//  Flashcards
//
//  Created by Shikha Sharma on 5/28/24.
//

//import SwiftUI
//
//struct ContentView: View {
//    var body: some View {
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
//            Text("Hello, world!")
//        }
//        .padding()
//    }
//}
//
//#Preview {
//    ContentView()
//}


import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = FlashcardViewModel()
    @State private var newBookTitle = ""
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    EditableTextField(text: $newBookTitle, placeholder: "New Book Title")
                    Button(action: {
                        if !newBookTitle.isEmpty {
                            viewModel.addBook(title: newBookTitle)
                            newBookTitle = ""
                        }
                    }) {
                        Text("Add Book")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .padding()
                
                List {
                    ForEach(viewModel.books) { book in
                        NavigationLink(destination: BookView(viewModel: viewModel, book: book)) {
                            Text(book.title)
                        }
                        .contextMenu {
                            Button(action: {
                                if let index = viewModel.books.firstIndex(where: { $0.id == book.id }) {
                                    newBookTitle = viewModel.books[index].title
                                }
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
            }
            .navigationTitle("Books")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

