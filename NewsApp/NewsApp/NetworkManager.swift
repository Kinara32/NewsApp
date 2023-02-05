//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Matvei Bykadorov on 05.02.2023.
//

import Foundation

protocol NetworkManagerDelegate: AnyObject {
    func updateInterface(_:NetworkManager, with newsData: NewsData)
}

final class NetworkManager {
    
    weak var delegate: NetworkManagerDelegate?
    
    func fetchNews() {
        guard let url = URL(string: "https://newsapi.org/v2/everything?q=Apple&from=2023-02-04&sortBy=popularity&apiKey=\(ApiKey)") else {return}
//        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(ApiKey)") else {return}
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            guard error == nil else {return}
            guard let data = data, let _ = response else {return}
            if let newsData = parseJSON(data: data) {
                self.delegate?.updateInterface(self, with: newsData)
            }
        }.resume()
    }
}

private func parseJSON(data:Data) -> NewsData? {
    do {
        let newsStruct = try JSONDecoder().decode(NewsStruct.self, from: data)
        guard let newsData = NewsData(newsStruct: newsStruct) else {return nil}
        return newsData
    } catch let error {
        print(error)
    }
    return nil
}
