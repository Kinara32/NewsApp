//
//  NewsData.swift
//  NewsApp
//
//  Created by Matvei Bykadorov on 05.02.2023.
//

import Foundation

struct NewsData {
    let status: String
    let totalResults: Int
    let articles: [Article]
    init? (newsStruct: NewsStruct) {
        status = newsStruct.status
        totalResults = newsStruct.totalResults
        articles = newsStruct.articles
    }
}




