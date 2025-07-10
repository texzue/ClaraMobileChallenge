//
//  ContentView.swift
//  ClaraMobileChallenge
//
//  Created by alice on 10/07/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    var items: [String] = ["Ho", "Gola"]
    
    var body: some View {
        
        List {
            ForEach(items, id: \.self) { item in
                Text(item)
            }
            .onDelete(perform: deleteItems)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            ToolbarItem {
                Button(action: addItem) {
                    Label("Add Item", systemImage: "plus")
                }
            }
        }
        
    }

    private func addItem() {
        withAnimation {
            authenticate()
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            authenticate()
        }
    }
    
    private func authenticate() {
        OauthAuthenticator.shared.authorize()
    }
}

#Preview {
    ContentView()
}
