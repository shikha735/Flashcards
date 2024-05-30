//
//  BottomNavigationBar.swift
//  Flashcards
//
//  Created by Shikha Sharma on 5/29/24.
//

import SwiftUI

struct BottomNavigationBar: View {
    @Binding var selectedTab: HomeView.Tab
    var viewModel: FlashcardViewModel

    var body: some View {
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

            Button(action: {
                selectedTab = .books
            }) {
                VStack {
                    Image(systemName: "book")
                    Text("Books")
                }
            }
            .padding()
            .frame(maxWidth: .infinity)

            Button(action: {
                selectedTab = .notes
            }) {
                VStack {
                    Image(systemName: "note.text")
                    Text("Notes")
                }
            }
            .padding()
            .frame(maxWidth: .infinity)

            NavigationLink(destination: ProfileView(viewModel: viewModel), isActive: $selectedTab) {
                EmptyView()
            }
            .frame(width: 0, height: 0)
            .hidden()
        }
        .background(Color(UIColor.systemGray6))
    }
}

private func handleNavigation(_ tab: Tab) {
    switch tab {
    case .home:
        // Handle navigation to HomeView
        break
    case .books:
        // Handle navigation to BookListView
        break
    case .notes:
        // Handle navigation to NotesView
        break
    }
}
