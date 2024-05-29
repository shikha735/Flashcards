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
    @State private var selectedTab: Tab = .home

    private enum Tab {
        case home, books, notes
    }

    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    VStack(alignment: .leading) {
                        Text("Welcome!")
                            .font(.largeTitle)
                            .padding()

                        Text(motivationalQuote)
                            .font(.headline)
                            .italic()
                            .padding([.leading, .trailing])

                        RecentlyCreatedView(viewModel: viewModel)
                            .padding()
                    }
                }

                Spacer()

                HStack {
                    Button(action: {
                        selectedTab = .home
                    }) {
                        VStack {
                            Image(systemName: "house")
                            Text("Home")
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)

                    NavigationLink(destination: BookListView(viewModel: viewModel)) {
                        VStack {
                            Image(systemName: "book")
                            Text("Books")
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)

                    NavigationLink(destination: NotesView(viewModel: viewModel)) {
                        VStack {
                            Image(systemName: "note.text")
                            Text("Notes")
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    
                    NavigationLink(destination: ProfileView(viewModel: viewModel)) {
                        VStack {
                            Image(systemName: "person.circle")
                            Text("Profile")
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                }
                .background(Color(UIColor.systemGray6))
            }
            .navigationTitle("Flashcards")
        }
        .onAppear {
            loadMotivationalQuote()
        }
    }

    private func loadMotivationalQuote() {
        // Fetch the motivational quote from an online source.
        // This is a placeholder implementation.
        let quotes = [
            "Success is not final, failure is not fatal: It is the courage to continue that counts. - Winston Churchill",
            "Don't watch the clock; do what it does. Keep going. - Sam Levenson",
            "The future belongs to those who believe in the beauty of their dreams. - Eleanor Roosevelt",
            "The only way to achieve the impossible is to believe it is possible. - Charles Kingsleigh"
        ]
        motivationalQuote = quotes.randomElement() ?? motivationalQuote
    }
}

struct RecentlyCreatedView: View {
    @ObservedObject var viewModel: FlashcardViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Text("Recently Modified")
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
        HomeView()
    }
}


