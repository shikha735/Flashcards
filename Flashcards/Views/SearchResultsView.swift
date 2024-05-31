import SwiftUI

struct SearchResultsView: View {
    @ObservedObject var viewModel: FlashcardViewModel
    var searchText: String

    var body: some View {
        VStack(alignment: .leading) {
            Text("Search Results")
                .font(.title2)
                .padding([.top, .bottom])
            
            let filteredBooks = viewModel.books.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
            let filteredChapters = viewModel.books.flatMap { $0.chapters.filter { $0.title.localizedCaseInsensitiveContains(searchText) } }
            let filteredFlashcards = viewModel.books.flatMap { $0.chapters.flatMap { $0.flashcards.filter { $0.question.localizedCaseInsensitiveContains(searchText) || $0.answer.localizedCaseInsensitiveContains(searchText) } } }
            let filteredNotes = viewModel.notes.filter { $0.title.localizedCaseInsensitiveContains(searchText) || $0.content.localizedCaseInsensitiveContains(searchText) }
            
            if filteredBooks.isEmpty && filteredChapters.isEmpty && filteredFlashcards.isEmpty && filteredNotes.isEmpty {
                            Text("No results found")
                                .foregroundColor(.secondary)
                        }

            
            if !filteredBooks.isEmpty {
                Text("Books")
                    .font(.headline)
                ForEach(filteredBooks) { book in
                    NavigationLink(destination: BookView(viewModel: viewModel, book: book)) {
                        Text(book.title)
                    }
                }
            }

            if !filteredChapters.isEmpty {
                Text("Chapters")
                    .font(.headline)
                ForEach(filteredChapters) { chapter in
                    if let book = viewModel.books.first(where: { $0.chapters.contains(where: { $0.id == chapter.id }) }) {
                        NavigationLink(destination: ChapterView(viewModel: viewModel, book: book, chapter: chapter)) {
                            Text(chapter.title)
                        }
                    }
                }
            }

            if !filteredFlashcards.isEmpty {
                Text("Flashcards")
                    .font(.headline)
                ForEach(filteredFlashcards) { flashcard in
                    if let book = viewModel.books.first(where: { $0.chapters.contains(where: { $0.flashcards.contains(where: { $0.id == flashcard.id }) }) }),
                       let chapter = book.chapters.first(where: { $0.flashcards.contains(where: { $0.id == flashcard.id }) }) {
                        NavigationLink(destination: FlashcardView(flashcard: flashcard)) {
                            Text(flashcard.question)
                        }
                    }
                }
            }

            if !filteredNotes.isEmpty {
                Text("Notes")
                    .font(.headline)
                ForEach(filteredNotes) { note in
                    NavigationLink(destination: NoteDetailView(viewModel: viewModel, note: note)) {
                        Text(note.title)
                    }
                }
            }
        }
    }
}

struct SearchResultsView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultsView(viewModel: FlashcardViewModel(), searchText: "test")
    }
}
