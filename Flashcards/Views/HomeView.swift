//
//  HomeView.swift
//  Flashcards
//
//  Created by Shikha Sharma on 5/29/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = FlashcardViewModel()
    @State private var motivationalQuote = "Stay positive, work hard, make it happen."
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    VStack(alignment: .leading) {
                        SearchBar(text: $searchText)
                            .padding()

                        if !searchText.isEmpty {
                            SearchResultsView(viewModel: viewModel, searchText: searchText)
                                .padding()
                        }
                        else {
                            Text("Welcome!")
                                .font(.largeTitle)
                                .padding()
                            
                            Text(motivationalQuote)
                                .font(.headline)
                                .italic()
                                .padding([.leading, .trailing])
                            
                            RecentlyModifiedView(viewModel: viewModel)
                                .padding()
                        }
                    }
                }
            }
            .navigationTitle("Flashcards")
            .onAppear {
                loadMotivationalQuote()
            }
        }
    }

    private func loadMotivationalQuote() {
        let quotes = [
            "Success is not final, failure is not fatal: It is the courage to continue that counts. - Winston Churchill",
            "Don't watch the clock; do what it does. Keep going. - Sam Levenson",
            "The future belongs to those who believe in the beauty of their dreams. - Eleanor Roosevelt",
            "The only way to achieve the impossible is to believe it is possible. - Charles Kingsleigh"
        ]
        motivationalQuote = quotes.randomElement() ?? motivationalQuote
    }
}

struct SearchBar: UIViewRepresentable {
    @Binding var text: String

    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String

        init(text: Binding<String>) {
            _text = text
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }

    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = text
    }
}

struct RecentlyModifiedView: View {
    @ObservedObject var viewModel: FlashcardViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Text("Recent Activity")
                .font(.title2)
                .padding([.top, .bottom])
            
            ForEach(viewModel.recentlyModifiedBooks) { book in
                Text("Book: \(book.title)")
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView() // Pass a constant binding for selectedTab
    }
}
