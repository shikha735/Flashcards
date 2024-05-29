//
//  BookView.swift
//  Flashcards
//
//  Created by Shikha Sharma on 5/28/24.
//

import SwiftUI

struct BookView: View {
    @ObservedObject var viewModel: FlashcardViewModel
    var book: Book
    @State private var newChapterTitle = ""
    @State private var editingChapter: Chapter?
    @State private var errorMessage = ""

    var body: some View {
        VStack {
            HStack {
                TextField("Chapter Title", text: $newChapterTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {
                    if newChapterTitle.trimmingCharacters(in: .whitespaces).isEmpty {
                        errorMessage = "Chapter title cannot be empty"
                    } else {
                        if let chapter = editingChapter {
                            viewModel.updateChapter(book: book, chapter: chapter, title: newChapterTitle)
                            editingChapter = nil
                        } else {
                            viewModel.addChapter(to: book, title: newChapterTitle)
                        }
                        newChapterTitle = ""
                        errorMessage = ""
                    }
                }) {
                    Text(editingChapter == nil ? "Add Chapter" : "Update Chapter")
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
                ForEach(book.chapters) { chapter in
                    NavigationLink(destination: ChapterView(viewModel: viewModel, book: book, chapter: chapter)) {
                        Text(chapter.title)
                    }
                    .contextMenu {
                        Button(action: {
                            newChapterTitle = chapter.title
                            editingChapter = chapter
                        }) {
                            Text("Edit")
                            Image(systemName: "pencil")
                        }
                        Button(action: {
                            viewModel.deleteChapter(book: book, chapter: chapter)
                        }) {
                            Text("Delete")
                            Image(systemName: "trash")
                        }
                    }
                }
                .onDelete { indexSet in
                    indexSet.forEach { viewModel.deleteChapter(book: book, chapter: book.chapters[$0]) }
                }
            }
        }
        .navigationTitle(book.title)
    }
}

struct BookView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = FlashcardViewModel()
        let book = Book(title: "Sample Book", chapters: [])
        BookView(viewModel: viewModel, book: book)
    }
}

