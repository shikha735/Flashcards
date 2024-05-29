//
//  FlashcardViewModel.swift
//  Flashcards
//
//  Created by Shikha Sharma on 5/28/24.
//

import Foundation
import Combine

class FlashcardViewModel: ObservableObject {
    @Published var books: [Book] = []

    func addBook(title: String) {
        let newBook = Book(title: title, chapters: [])
        books.append(newBook)
    }

    func updateBook(book: Book, newTitle: String) {
        if let index = books.firstIndex(where: { $0.id == book.id }) {
            books[index].title = newTitle
        }
    }

    func deleteBook(book: Book) {
        books.removeAll { $0.id == book.id }
    }

    func addChapter(to book: Book, title: String) {
        if let index = books.firstIndex(where: { $0.id == book.id }) {
            let newChapter = Chapter(title: title, flashcards: [])
            books[index].chapters.append(newChapter)
        }
    }

    func updateChapter(book: Book, chapter: Chapter, newTitle: String) {
        if let bookIndex = books.firstIndex(where: { $0.id == book.id }) {
            if let chapterIndex = books[bookIndex].chapters.firstIndex(where: { $0.id == chapter.id }) {
                books[bookIndex].chapters[chapterIndex].title = newTitle
            }
        }
    }

    func deleteChapter(book: Book, chapter: Chapter) {
        if let bookIndex = books.firstIndex(where: { $0.id == book.id }) {
            books[bookIndex].chapters.removeAll { $0.id == chapter.id }
        }
    }

    func addFlashcard(to chapter: Chapter, in book: Book, question: String, answer: String) {
        if let bookIndex = books.firstIndex(where: { $0.id == book.id }) {
            if let chapterIndex = books[bookIndex].chapters.firstIndex(where: { $0.id == chapter.id }) {
                let newFlashcard = Flashcard(question: question, answer: answer)
                books[bookIndex].chapters[chapterIndex].flashcards.append(newFlashcard)
            }
        }
    }

    func updateFlashcard(book: Book, chapter: Chapter, flashcard: Flashcard, newQuestion: String, newAnswer: String) {
        if let bookIndex = books.firstIndex(where: { $0.id == book.id }) {
            if let chapterIndex = books[bookIndex].chapters.firstIndex(where: { $0.id == chapter.id }) {
                if let flashcardIndex = books[bookIndex].chapters[chapterIndex].flashcards.firstIndex(where: { $0.id == flashcard.id }) {
                    books[bookIndex].chapters[chapterIndex].flashcards[flashcardIndex].question = newQuestion
                    books[bookIndex].chapters[chapterIndex].flashcards[flashcardIndex].answer = newAnswer
                }
            }
        }
    }

    func deleteFlashcard(book: Book, chapter: Chapter, flashcard: Flashcard) {
        if let bookIndex = books.firstIndex(where: { $0.id == book.id }) {
            if let chapterIndex = books[bookIndex].chapters.firstIndex(where: { $0.id == chapter.id }) {
                books[bookIndex].chapters[chapterIndex].flashcards.removeAll { $0.id == flashcard.id }
            }
        }
    }
}
