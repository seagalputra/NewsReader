//
//  Article.swift
//  NewsReader
//
//  Created by Dwiferdio Seagal Putra on 20/07/21.
//

import Foundation

struct Article: Codable {
    let source: Source
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

struct Source: Codable {
    let id: String?
    let name: String?
}
