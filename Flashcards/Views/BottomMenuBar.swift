//
//  BottomMenuBar.swift
//  Flashcards
//
//  Created by Shikha Sharma on 5/29/24.
//

import SwiftUI

struct BottomMenuBar: View {
    @Binding var selectedTab: Tab

    enum Tab {
        case home, books, notes, profile
    }

    var body: some View {
        HStack {
            Button(action: {
                if selectedTab != .home {
                    selectedTab = .home
                }
            }) {
                VStack {
                    Image(systemName: "house")
                    Text("Home")
                }
            }
            .padding()
            .frame(maxWidth: .infinity)

            NavigationLink(
                destination: BookListView(viewModel: FlashcardViewModel()),
                isActive: .constant(selectedTab == .books)
            ) {
                VStack {
                    Image(systemName: "book")
                    Text("Books")
                }
            }
            .padding()
            .frame(maxWidth: .infinity)

            NavigationLink(
                destination: NotesView(viewModel: FlashcardViewModel()),
                isActive: .constant(selectedTab == .notes)
            ) {
                VStack {
                    Image(systemName: "note.text")
                    Text("Notes")
                }
            }
            .padding()
            .frame(maxWidth: .infinity)

            NavigationLink(
                destination: ProfileView(viewModel: FlashcardViewModel()),
                isActive: .constant(selectedTab == .profile)
            ) {
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
}


