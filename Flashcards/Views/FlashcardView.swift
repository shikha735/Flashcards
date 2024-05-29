//
//  FlashcardView.swift
//  Flashcards
//
//  Created by Shikha Sharma on 5/28/24.
//

import SwiftUI

struct FlashcardView: View {
    var flashcard: Flashcard
    @State private var flipped = false
    
    var body: some View {
        VStack {
            if flipped {
                Text(flashcard.answer)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            } else {
                Text(flashcard.question)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white)
                    .foregroundColor(.black)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.blue, lineWidth: 2)
                    )
            }
        }
        .padding()
        .onTapGesture {
            withAnimation {
                flipped.toggle()
            }
        }
        .frame(height: 200)
    }
}

struct FlashcardView_Previews: PreviewProvider {
    static var previews: some View {
        FlashcardView(flashcard: Flashcard(question: "Sample Question", answer: "Sample Answer"))
    }
}
