<div align="center">

# 👾 H4X0R News

**A Hacker News reader built natively for iOS using SwiftUI**

![Swift](https://img.shields.io/badge/Swift-5.9-F05138?style=for-the-badge&logo=swift&logoColor=white)
![SwiftUI](https://img.shields.io/badge/SwiftUI-Framework-0069D9?style=for-the-badge&logo=swift&logoColor=white)
![iOS](https://img.shields.io/badge/iOS-16%2B-000000?style=for-the-badge&logo=apple&logoColor=white)
![Xcode](https://img.shields.io/badge/Xcode-15-147EFB?style=for-the-badge&logo=xcode&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)

</div>

---

## 📱 About

**H4X0R News** is an iOS app that fetches and displays the top stories from [Hacker News](https://news.ycombinator.com) in a clean, native SwiftUI interface. Users can browse the latest tech news and open any article directly inside the app through a native WebView — no external browser required.

---

## ✨ Features

- 📰 **Top Stories Feed** — Fetches the latest Hacker News front-page articles in real time
- 🌐 **In-App WebView** — Read any article without leaving the app using `WKWebView` via `UIViewRepresentable`
- 🔄 **Live Data Fetching** — Networking powered by `URLSession` and Codable JSON decoding
- 🎨 **Native SwiftUI UI** — Fully declarative interface with `List`, `NavigationView`, and custom row views

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| Language | Swift 5.9 |
| UI Framework | SwiftUI |
| Web Rendering | WKWebView via UIViewRepresentable |
| Networking | URLSession |
| Data Parsing | Codable / JSONDecoder |
| API | [Algolia Hacker News API](https://hn.algolia.com/api) |
| IDE | Xcode 15 |
| Platform | iOS 16+ |

---

## 🌐 API

This app consumes the **[Algolia Hacker News REST API](https://hn.algolia.com/api)** — a public, open API that provides structured access to Hacker News content.

**Endpoint used:**
```
GET https://hn.algolia.com/api/v1/search?tags=front_page
```

**Response model (decoded with `Codable`):**
```swift
struct Results: Decodable {
    let hits: [Post]
}

struct Post: Decodable, Identifiable {
    let objectID: String
    let title: String
    let url: String?
    let points: Int?
    let author: String?

    var id: String { objectID }
}
```

---

## 🏗️ Project Structure

```
h4x0rnews-swiftUI/
├── Models/
│   └── PostData.swift          # Decodable structs for API response
├── Views/
│   ├── ContentView.swift       # Main list view
│   ├── PostCell.swift          # Custom row component
│   └── WebView.swift           # WKWebView wrapped with UIViewRepresentable
├── Networking/
│   └── NetworkManager.swift    # URLSession + JSONDecoder logic
└── h4x0rnewsApp.swift          # App entry point
```

---

## 🔍 Key Implementation Details

### Networking with URLSession + Codable

Data fetching is done natively with `URLSession.shared.dataTask`, decoding the JSON response directly into Swift structs via `JSONDecoder` — no third-party libraries needed.

```swift
func fetchData(url: String) {
    if let url = URL(string: url) {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if error == nil {
                let decoder = JSONDecoder()
                if let safeData = data {
                    if let results = try? decoder.decode(Results.self, from: safeData) {
                        DispatchQueue.main.async {
                            self.posts = results.hits
                        }
                    }
                }
            }
        }
        task.resume()
    }
}
```

### WKWebView bridged to SwiftUI

Since SwiftUI doesn't have a native WebView component, `WKWebView` from the `WebKit` framework is bridged using the `UIViewRepresentable` protocol — a key pattern for integrating UIKit components into SwiftUI.

```swift
import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let urlString: String

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            uiView.load(request)
        }
    }
}
```

### State Management with @State and @StateObject

The app uses SwiftUI's native property wrappers to manage UI state reactively, keeping the interface in sync with the fetched data without the need for a formal architecture layer.

---

## 🚀 Getting Started

### Prerequisites

- macOS 13+ (Ventura or later)
- Xcode 15+
- iOS Simulator or physical device running iOS 16+

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/jcezart/h4x0rnews-swiftUI.git
```

2. **Open in Xcode**
```bash
cd h4x0rnews-swiftUI
open h4x0rnews.xcodeproj
```

3. **Run the app**

Select a simulator or connected device and press `⌘ + R`.

> ⚠️ No API key or additional configuration required — the Algolia Hacker News API is fully public.

---

## 📚 Concepts Practiced

- Declarative UI development with **SwiftUI**
- **REST API** consumption with `URLSession`
- **JSON decoding** using the `Codable` protocol
- **UIViewRepresentable** to bridge UIKit (`WKWebView`) into SwiftUI
- Reactive state management with `@State` and `@StateObject`
- SwiftUI navigation with `NavigationView` and `NavigationLink`
- Swift optionals, guard statements, and safe unwrapping
- `DispatchQueue.main.async` for UI updates from background threads

---

<div align="center">
  Made with ❤️ and Swift · <a href="https://github.com/jcezart">@jcezart</a>
</div>
