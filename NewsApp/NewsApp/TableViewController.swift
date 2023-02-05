//
//  TableViewController.swift
//  NewsApp
//
//  Created by Matvei Bykadorov on 04.02.2023.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
        
    var networkManager = NetworkManager()
    var newsData: NewsData?
    var newsCoreData: News?
    var counterCell = Array(repeating: 0, count: 20)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        networkManager.delegate = self
        networkManager.fetchNews()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @IBAction func refreshTapped(_ sender: UIBarButtonItem) {
        networkManager.fetchNews()
    }
    
    @objc func refresh(_ sender: AnyObject){
        networkManager.fetchNews()
        refreshControl?.endRefreshing()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        configurationCell(for: cell, indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let fullNewsViewController = FullNewsViewController()
        if let article = newsData?.articles[indexPath.row] {
            fullNewsViewController.titleNews = article.title
            fullNewsViewController.imageUrl = article.urlToImage
            fullNewsViewController.descNews = article.description
            fullNewsViewController.publishedAt = article.publishedAt
            fullNewsViewController.source = article.source?.name
            fullNewsViewController.url = article.url
        }
        counterCell[indexPath.row] += 1
        print(counterCell[indexPath.row])
        navigationController?.pushViewController(fullNewsViewController, animated: true)
    }
    
    private func configurationCell(for cell: TableViewCell, _ indexPath: IndexPath) {
        if let article = newsData?.articles[indexPath.row] {
            cell.titleLabel.text = article.title
            
            DispatchQueue.global().async{
                guard let urlToImage = article.urlToImage else {return}
                guard let imageUrl = URL(string: urlToImage) else {return}
                guard let imageData = try? Data(contentsOf: imageUrl) else {return}
                DispatchQueue.main.async {
                    cell.imageNews.image = UIImage(data: imageData)
                }
            }
        }
    }
    
}
extension TableViewController: NetworkManagerDelegate{
    func updateInterface(_: NetworkManager, with newsData: NewsData) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        self.newsData = newsData
    }
}
