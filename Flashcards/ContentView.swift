//
//  ContentView.swift
//  Flashcards
//
//  Created by Shikha Sharma on 5/28/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView().tabItem {
                VStack {
                    Image(systemName: "house")
                    Text("Home")
                }
            }
            BookListView(viewModel: FlashcardViewModel()).tabItem {
                VStack {
                    Image(systemName: "book")
                    Text("Books")
                }
            }
            NotesView(viewModel: FlashcardViewModel()).tabItem {
                VStack {
                    Image(systemName: "note.text")
                    Text("Notes")
                }
            }
            ProfileView(viewModel: FlashcardViewModel()).tabItem {
                VStack {
                    Image(systemName: "person")
                    Text("Profile")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

