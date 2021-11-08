//
//  SearchTableViewCell.swift
//  FlickrFinder
//
//  Created by Sarathi Murugesan on 11/4/21.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    //MARK: IBOutlets
    @IBOutlet weak var thumbNail: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    
    // MARK: - Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func loadCellFor(_ photo: Photo?) {
        titleLbl.text = photo?.title
        if let server = photo?.server, let id = photo?.id, let sercet = photo?.secret {
            thumbNail.downloadImage(url: "\(image_base_url)\(server)/\(id)_\(sercet)_s.png")
        }
    }
}
