//
//  ProfileView.swift
//  Flashcards
//
//  Created by Shikha Sharma on 5/29/24.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: FlashcardViewModel
    @State private var username: String = "John Doe"
    @State private var email: String = "johndoe@example.com"
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("User Information")) {
                        Text("Username: \(username)")
                        Text("Email: \(email)")
                    }
                    
                    Section(header: Text("Settings")) {
                        Toggle("Notifications", isOn: .constant(true))
                        Toggle("Dark Mode", isOn: .constant(false))
                    }
                    Section(header: Text("")) {
                        Text("Logout")
                    }
                }
            }
            .navigationTitle("Profile")
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(viewModel: FlashcardViewModel())
    }
}

