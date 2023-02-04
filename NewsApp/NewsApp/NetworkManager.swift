//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Matvei Bykadorov on 05.02.2023.
//

import Foundation

final class NetworkManager {
    
    func fetchNews () {
        guard let url = URL(string: "https://newsapi.org/v2/everything?q=Apple&from=2023-02-04&sortBy=popularity&apiKey=\(ApiKey)") else {return}
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            guard let data = data, let response = response else {return}
            print(data)
            print(response)
            do {
                let newsStruct = try JSONDecoder().decode(NewsStruct.self, from: data)
                print(newsStruct.totalResults)
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
