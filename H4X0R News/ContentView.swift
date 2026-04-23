//
//  ContentView.swift
//  H4X0R News
//
//  Created by Julio Cezar Teixeira on 23/04/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            List(posts){ post in
                Text(post.title)
            }
            .navigationBarTitle("H4X0R News ")
        }
        
    }
}

#Preview {
    ContentView()
}

struct Post: Identifiable {
    let id: String
    let title: String
}

let posts = [
    Post(id: "1", title: "hello"),
    Post(id: "2", title: "bonjour"),
    Post(id: "3", title: "hola")
]
