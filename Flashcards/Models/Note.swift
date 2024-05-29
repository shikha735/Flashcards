//
//  Note.swift
//  Flashcards
//
//  Created by Shikha Sharma on 5/29/24.
//

import SwiftUI

struct Note: Identifiable, Equatable, Encodable, Decodable {
    var id = UUID()
    var title: String
    var content: String
}
