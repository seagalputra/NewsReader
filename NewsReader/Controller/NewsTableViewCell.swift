//
//  NewsTableViewCell.swift
//  NewsReader
//
//  Created by Dwiferdio Seagal Putra on 20/07/21.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var newsPhoto: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsAdditionalData: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
