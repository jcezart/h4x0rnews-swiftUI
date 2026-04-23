//
//  ContentView.swift
//  H4X0R News
//
//  Created by Julio Cezar Teixeira on 23/04/26.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        NavigationView{
            List(networkManager.posts){ post in
                HStack {
                    Text(String(post.points))
                    Text(post.title)
                }
            }
            .navigationBarTitle("H4X0R News ")
        }
        .onAppear {
            self.networkManager.fetchData()
        }
    }
}

#Preview {
    ContentView()
}


//let posts = [
//    Post(id: "1", title: "hello"),
//    Post(id: "2", title: "bonjour"),
//    Post(id: "3", title: "hola")
//]
