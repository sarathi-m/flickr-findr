//
//  SearchTableViewCell.swift
//  FlickrFinder
//
//  Created by Sarathi Murugesan on 11/4/21.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbNail: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func loadCell(_ objEQHomeViewDisplayEntity: Photo) {

    }
}
