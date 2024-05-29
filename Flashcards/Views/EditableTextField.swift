//
//  EditableTextField.swift
//  Flashcards
//
//  Created by Shikha Sharma on 5/28/24.
//

import SwiftUI

struct EditableTextField: View {
    @Binding var text: String
    var placeholder: String

    var body: some View {
        TextField(placeholder, text: $text)
            .padding()
            .background(Color(UIColor.systemGray6))
            .cornerRadius(8)
    }
}

struct EditableTextField_Previews: PreviewProvider {
    static var previews: some View {
        EditableTextField(text: .constant("Sample Text"), placeholder: "Placeholder")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

