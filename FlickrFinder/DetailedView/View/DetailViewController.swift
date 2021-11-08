//
//  DetailedViewController.swift
//  FlickrFinder
//
//  Created by Sarathi Murugesan on 11/5/21.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    //MARK: IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    
    //MARK: Presenter
    var presenter: DetailViewToPresenterProtocol?
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imageView.downloadImage(url: presenter?.imageUrl)
    }
    
}
