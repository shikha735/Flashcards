//
//  Book.swift
//  Flashcards
//
//  Created by Shikha Sharma on 5/28/24.
//

import Foundation

struct Book: Identifiable, Codable {
    var id = UUID()
    var title: String
    var chapters: [Chapter]
}
