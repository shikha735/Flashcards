//
//  AddItemView.swift
//  Flashcards
//
//  Created by Shikha Sharma on 5/29/24.
//

import SwiftUI

struct AddItemView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: FlashcardViewModel
    @State private var selectedType: ItemType = .book
    @State private var title = ""
    @State private var question = ""
    @State private var answer = ""
    @State private var content = ""

    enum ItemType: String, CaseIterable {
        case book, chapter, flashcard, note
    }

    var body: some View {
        NavigationView {
            Form {
                Picker("Select Type", selection: $selectedType) {
                    ForEach(ItemType.allCases, id: \.self) { type in
                        Text(type.rawValue.capitalized)
                            .tag(type)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())

                if selectedType == .book || selectedType == .chapter || selectedType == .note {
                    TextField("Title", text: $title)
                }

                if selectedType == .flashcard {
                    TextField("Question", text: $question)
                    TextEditor(text: $answer)
                        .frame(height: 200)
                }

                if selectedType == .note {
                    TextEditor(text: $content)
                        .frame(height: 200)
                }
            }
            .navigationBarTitle("Add New Item", displayMode: .inline)
            .navigationBarItems(leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            }, trailing: Button("Save") {
                addItem()
                presentationMode.wrappedValue.dismiss()
            })
        }
    }

    private func addItem() {
        switch selectedType {
        case .book:
            guard !title.trimmingCharacters(in: .whitespaces).isEmpty else { return }
            viewModel.addBook(title: title)
        case .chapter:
            guard !title.trimmingCharacters(in: .whitespaces).isEmpty else { return }
            // Assuming a book is selected
            // viewModel.addChapter(to: selectedBook, title: title)
        case .flashcard:
            guard !question.trimmingCharacters(in: .whitespaces).isEmpty, !answer.trimmingCharacters(in: .whitespaces).isEmpty else { return }
            // Assuming a book and chapter are selected
            // viewModel.addFlashcard(to: selectedChapter, in: selectedBook, question: question, answer: answer)
        case .note:
            guard !content.trimmingCharacters(in: .whitespaces).isEmpty else { return }
            // viewModel.addNote(content: content)
        }
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView(viewModel: FlashcardViewModel())
    }
}
