//
//  Flashcard.swift
//  Flashcards
//
//  Created by Shikha Sharma on 5/28/24.
//

import Foundation

struct Flashcard: Identifiable, Codable {
    var id = UUID()
    var question: String
    var answer: String
}
