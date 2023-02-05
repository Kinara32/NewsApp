//
//  TableViewCell.swift
//  NewsApp
//
//  Created by Matvei Bykadorov on 04.02.2023.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var imageNews: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var counter: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
