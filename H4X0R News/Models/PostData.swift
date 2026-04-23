//
//  PostData.swift
//  H4X0R News
//
//  Created by Julio Cezar Teixeira on 23/04/26.
//
import Foundation

struct Results: Decodable {
    let hits: [Post]
}

struct Post: Decodable, Identifiable, Sendable {
    var id: String {
        return objectID
    }
    let objectID: String
    let points: Int
    let title: String
    let url: String?
}
