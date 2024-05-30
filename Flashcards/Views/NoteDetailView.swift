//
//  NoteDetailView.swift
//  Flashcards
//
//  Created by Shikha Sharma on 5/29/24.
//

import SwiftUI

struct NoteDetailView: View {
    @ObservedObject var viewModel: FlashcardViewModel
    var note: Note
    @State private var isEditing = false
    @State private var editedNoteTitle: String
    @State private var editedNoteContent: String

    init(viewModel: FlashcardViewModel, note: Note) {
        self.viewModel = viewModel
        self.note = note
        _editedNoteTitle = State(initialValue: note.title)
        _editedNoteContent = State(initialValue: note.content)
    }

    var body: some View {
        VStack(alignment: .leading) {
            if isEditing {
                TextField("Note Title", text: $editedNoteTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding([.horizontal, .top])
                    .font(.title2)
                    .bold()
                
                EditableTextEditor(text: $editedNoteContent, placeholder: "Note Content")
                    .padding([.horizontal, .bottom])
            } else {
                ScrollView {
                    Text(editedNoteTitle)
                        .font(.title2)
                        .bold()
                        .padding([.horizontal, .top])
                    
                    Text(editedNoteContent)
                        .padding([.horizontal, .bottom])
                }
            }
            
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if isEditing {
                    Button(action: {
                        viewModel.updateNote(note: note, title: editedNoteTitle, content: editedNoteContent)
                        isEditing = false
                    }) {
                        Image(systemName: "checkmark")
                            .foregroundColor(.blue)
                    }
                } else {
                    Button(action: {
                        isEditing = true
                    }) {
                        Image(systemName: "pencil")
                            .foregroundColor(.blue)
                    }
                }
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct NoteDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = FlashcardViewModel()
        let note = Note(id: UUID(), title: "Sample Note", content: "This is a sample note.")
        return NoteDetailView(viewModel: viewModel, note: note)
    }
}
