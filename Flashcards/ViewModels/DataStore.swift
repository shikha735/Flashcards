//
//  DataStore.swift
//  Flashcards
//
//  Created by Shikha Sharma on 5/29/24.
//

/* import Foundation

class DataStore {
    static let shared = DataStore()
    
    private let booksKey = "books"
    private let notesKey = "notes"
    
    private init() {}
    
    func saveBooks(_ books: [Book]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(books) {
            UserDefaults.standard.set(encoded, forKey: booksKey)
        }
    }
    
    func saveNotes(_ notes: [Note]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(notes) {
            UserDefaults.standard.set(encoded, forKey: notesKey)
        }
    }
    
    func loadBooks() -> [Book] {
        if let data = UserDefaults.standard.data(forKey: booksKey) {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Book].self, from: data) {
                return decoded
            }
        }
        return []
    }
    
    func loadNotes() -> [Note] {
        if let data = UserDefaults.standard.data(forKey: notesKey) {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Note].self, from: data) {
                return decoded
            }
        }
        return []
    }
} */

