//
//  TableViewController.swift
//  NewsApp
//
//  Created by Matvei Bykadorov on 04.02.2023.
//

import UIKit

class TableViewController: UITableViewController {
        
    var networkManager = NetworkManager()
    var newsData: NewsData?
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

//        print(newsData?.status)
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
//        cell.counter.text = String(counterCell[indexPath.row])
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}
extension TableViewController: NetworkManagerDelegate{
    func updateInterface(_: NetworkManager, with newsData: NewsData) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        self.newsData = newsData
    }
}
