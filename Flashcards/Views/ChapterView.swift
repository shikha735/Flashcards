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
    @State private var editingFlashcard: Flashcard?
    @State private var errorMessage = ""

    var body: some View {
        VStack {
            EditableTextField(text: $newFlashcardQuestion, placeholder: "Question")
            EditableTextEditor(text: $newFlashcardAnswer, placeholder: "Answer")
            Button(action: {
                if newFlashcardQuestion.trimmingCharacters(in: .whitespaces).isEmpty || newFlashcardAnswer.trimmingCharacters(in: .whitespaces).isEmpty {
                    errorMessage = "Flashcard question and answer cannot be empty"
                } else {
                    if let flashcard = editingFlashcard {
                        viewModel.updateFlashcard(book: book, chapter: chapter, flashcard: flashcard, newQuestion: newFlashcardQuestion, newAnswer: newFlashcardAnswer)
                        editingFlashcard = nil
                    } else {
                        viewModel.addFlashcard(to: chapter, in: book, question: newFlashcardQuestion, answer: newFlashcardAnswer)
                    }
                    newFlashcardQuestion = ""
                    newFlashcardAnswer = ""
                    errorMessage = ""
                }
            }) {
                Text(editingFlashcard == nil ? "Add Flashcard" : "Update Flashcard")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.horizontal)
            
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding(.bottom)
            }
            
            List {
                ForEach(chapter.flashcards) { flashcard in
                    FlashcardView(flashcard: flashcard)
                        .contextMenu {
                            Button(action: {
                                newFlashcardQuestion = flashcard.question
                                newFlashcardAnswer = flashcard.answer
                                editingFlashcard = flashcard
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

