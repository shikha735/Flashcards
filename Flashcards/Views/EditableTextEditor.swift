//
//  EditableTextEditor.swift
//  Flashcards
//
//  Created by Shikha Sharma on 5/29/24.
//

import SwiftUI

struct EditableTextEditor: View {
    @Binding var text: String
    var placeholder: String

    var body: some View {
        ZStack(alignment: .topLeading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(Color(UIColor.placeholderText))
                    .padding(.top, 8)
                    .padding(.horizontal, 4)
            }
            TextEditor(text: $text)
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(8)
        }
    }
}

struct EditableTextEditor_Previews: PreviewProvider {
    static var previews: some View {
        EditableTextEditor(text: .constant(""), placeholder: "Placeholder")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
