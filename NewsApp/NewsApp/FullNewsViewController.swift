//
//  FullNewsViewController.swift
//  NewsApp
//
//  Created by Matvei Bykadorov on 04.02.2023.
//

import UIKit

class FullNewsViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageFront: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var publishedAtLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var linkButton: UIButton!
    
    var titleNews: String?
    var imageUrl: String?
    var descNews: String?
    var publishedAt: String?
    var source: String?
    var url: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        titleLabel.text = titleNews
        descriptionLabel.text = descNews
        publishedAtLabel.text = publishedAt
        sourceLabel.text = source
        linkButton.titleLabel?.textAlignment = .justified
        linkButton.setTitle(url, for: .normal)
        
        DispatchQueue.global().async {
            guard let imageUrl = self.imageUrl else {return}
            guard let urlForImage = URL(string: imageUrl) else {return}
            guard let imageData = try? Data(contentsOf: urlForImage) else {return}
            DispatchQueue.main.async {
                self.imageFront.image = UIImage(data: imageData)
            }
        }
    }
    
    @IBAction func linkTapped(_ sender: UIButton) {
        let webViewController = WebViewController()
        webViewController.newsUrl = url
        navigationController?.pushViewController(webViewController, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//extension FullNewsViewController:
