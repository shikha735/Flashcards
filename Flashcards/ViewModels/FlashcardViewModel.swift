//
//  FlashcardViewModel.swift
//  Flashcards
//
//  Created by Shikha Sharma on 5/28/24.
//

import Foundation

class FlashcardViewModel: ObservableObject {
    @Published var books: [Book] = []

    func addBook(title: String) {
        let newBook = Book(title: title, chapters: [])
        books.append(newBook)
    }

    func deleteBook(book: Book) {
        if let index = books.firstIndex(where: { $0.id == book.id }) {
            books.remove(at: index)
        }
    }

    func updateBook(book: Book, title: String) {
        if let index = books.firstIndex(where: { $0.id == book.id }) {
            books[index].title = title
        }
    }

    func addChapter(to book: Book, title: String) {
        let newChapter = Chapter(title: title, flashcards: [])
        if let index = books.firstIndex(where: { $0.id == book.id }) {
            books[index].chapters.append(newChapter)
        }
    }

    func deleteChapter(book: Book, chapter: Chapter) {
        if let bookIndex = books.firstIndex(where: { $0.id == book.id }) {
            if let chapterIndex = books[bookIndex].chapters.firstIndex(where: { $0.id == chapter.id }) {
                books[bookIndex].chapters.remove(at: chapterIndex)
            }
        }
    }

    func updateChapter(book: Book, chapter: Chapter, title: String) {
        if let bookIndex = books.firstIndex(where: { $0.id == book.id }) {
            if let chapterIndex = books[bookIndex].chapters.firstIndex(where: { $0.id == chapter.id }) {
                books[bookIndex].chapters[chapterIndex].title = title
            }
        }
    }

    func addFlashcard(to chapter: Chapter, in book: Book, question: String, answer: String) {
        let newFlashcard = Flashcard(question: question, answer: answer)
        if let bookIndex = books.firstIndex(where: { $0.id == book.id }) {
            if let chapterIndex = books[bookIndex].chapters.firstIndex(where: { $0.id == chapter.id }) {
                books[bookIndex].chapters[chapterIndex].flashcards.append(newFlashcard)
            }
        }
    }

    func deleteFlashcard(book: Book, chapter: Chapter, flashcard: Flashcard) {
        if let bookIndex = books.firstIndex(where: { $0.id == book.id }) {
            if let chapterIndex = books[bookIndex].chapters.firstIndex(where: { $0.id == chapter.id }) {
                if let flashcardIndex = books[bookIndex].chapters[chapterIndex].flashcards.firstIndex(where: { $0.id == flashcard.id }) {
                    books[bookIndex].chapters[chapterIndex].flashcards.remove(at: flashcardIndex)
                }
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
}

