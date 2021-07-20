//
//  GenericResponse.swift
//  NewsReader
//
//  Created by Dwiferdio Seagal Putra on 20/07/21.
//

struct GenericResponse: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]
}
