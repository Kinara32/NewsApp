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
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            guard let data = data, let response = response else {return}
//            print(data)
//            print(response)
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
//        print(newsStruct.totalResults)
        return newsData
    } catch let error {
        print(error.localizedDescription)
    }
    return nil
}
