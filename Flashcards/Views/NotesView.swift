//
//  NotesView.swift
//  Flashcards
//
//  Created by Shikha Sharma on 5/29/24.
//

import SwiftUI

struct NotesView: View {
    @ObservedObject var viewModel: FlashcardViewModel
    @State private var newNoteTitle = ""
    @State private var newNoteContent = ""
    @State private var editingNote: Note?
    @State private var errorMessage = ""

    var body: some View {
        NavigationView{
            VStack {
                TextField("Note Title", text: $newNoteTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                EditableTextEditor(text: $newNoteContent, placeholder: "New Note Content")
                
                Button(action: {
                    if newNoteTitle.trimmingCharacters(in: .whitespaces).isEmpty || newNoteContent.trimmingCharacters(in: .whitespaces).isEmpty {
                        errorMessage = "Note title and content cannot be empty"
                    } else {
                        if let note = editingNote {
                            viewModel.updateNote(note: note, title: newNoteTitle, content: newNoteContent)
                            editingNote = nil
                        } else {
                            viewModel.addNote(title: newNoteTitle, content: newNoteContent)
                        }
                        newNoteTitle = ""
                        newNoteContent = ""
                        errorMessage = ""
                    }
                }) {
                    Text(editingNote == nil ? "Add Note" : "Update Note")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
                
                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding(.bottom)
                }
                
                List {
                    ForEach(viewModel.notes) { note in
                        NavigationLink(destination: NoteDetailView(viewModel: viewModel, note: note)) {
                            Text(note.title)
                        }
                    }
                }
            }
            .navigationTitle("Notes")
            .padding(.bottom, 60) // Adjust padding to accommodate BottomMenuBar
        }
    } // body
} // NotesView

struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        NotesView(viewModel: FlashcardViewModel())
    }
}

