//
//  ChapterView.swift
//  Flashcards
//
//  Created by Shikha Sharma on 5/28/24.
//
import SwiftUI

struct ChapterView: View {
    @ObservedObject var viewModel: FlashcardViewModel
    var book: Book
    var chapter: Chapter
    @State private var newFlashcardQuestion = ""
    @State private var newFlashcardAnswer = ""

    var body: some View {
        VStack {
            EditableTextField(text: $newFlashcardQuestion, placeholder: "New Question")
            EditableTextEditor(text: $newFlashcardAnswer, placeholder: "New Answer")
            Button(action: {
                if !newFlashcardQuestion.isEmpty && !newFlashcardAnswer.isEmpty {
                    viewModel.addFlashcard(to: chapter, in: book, question: newFlashcardQuestion, answer: newFlashcardAnswer)
                    newFlashcardQuestion = ""
                    newFlashcardAnswer = ""
                }
            }) {
                Text("Add Flashcard")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.horizontal)
            
            List {
                ForEach(chapter.flashcards) { flashcard in
                    FlashcardView(flashcard: flashcard)
                        .contextMenu {
                            Button(action: {
                                newFlashcardQuestion = flashcard.question
                                newFlashcardAnswer = flashcard.answer
                            }) {
                                Text("Edit")
                                Image(systemName: "pencil")
                            }
                            Button(action: {
                                viewModel.deleteFlashcard(book: book, chapter: chapter, flashcard: flashcard)
                            }) {
                                Text("Delete")
                                Image(systemName: "trash")
                            }
                        }
                }
                .onDelete { indexSet in
                    indexSet.forEach { viewModel.deleteFlashcard(book: book, chapter: chapter, flashcard: chapter.flashcards[$0]) }
                }
            }
        }
        .navigationTitle(chapter.title)
    }
}

struct ChapterView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = FlashcardViewModel()
        let chapter = Chapter(title: "Sample Chapter", flashcards: [])
        let book = Book(title: "Sample Book", chapters: [chapter])
        ChapterView(viewModel: viewModel, book: book, chapter: chapter)
    }
}
