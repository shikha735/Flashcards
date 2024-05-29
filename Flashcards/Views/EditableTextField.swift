//
//  EditableTextField.swift
//  Flashcards
//
//  Created by Shikha Sharma on 5/28/24.
//

import SwiftUI

struct EditableTextField: View {
    @Binding var text: String
    var placeholder: String = ""
    var body: some View {
        TextField(placeholder, text: $text)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
    }
}

struct EditableTextEditor: View {
    @Binding var text: String
    var placeholder: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(placeholder)
                .foregroundColor(.gray)
                .padding(.horizontal)
            TextEditor(text: $text)
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(8)
                .padding(.horizontal)
        }
        .padding(.vertical)
    }
}

struct EditableTextField_Previews: PreviewProvider {
    @State static var sampleText = "Sample"
    
    static var previews: some View {
        EditableTextField(text: $sampleText, placeholder: "Enter text")
        EditableTextEditor(text: $sampleText, placeholder: "Enter text")
    }
}

