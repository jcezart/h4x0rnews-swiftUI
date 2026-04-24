//
//  DetailView.swift
//  H4X0R News
//
//  Created by Julio Cezar Teixeira on 24/04/26.
//

import SwiftUI

struct DetailView: View {
    
    let url: String?
    
    var body: some View {
        WebView(urlString: url)
    }
}


#Preview {
    DetailView(url: "https://www.google.com")
}


