//
//  Chapter.swift
//  Flashcards
//
//  Created by Shikha Sharma on 5/28/24.
//

import Foundation

struct Chapter: Identifiable, Codable {
    var id = UUID()
    var title: String
    var flashcards: [Flashcard]
}
