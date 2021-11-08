//
//  Extension.swift
//  FlickrFinder
//
//  Created by Sarathi Murugesan on 11/4/21.
//

import UIKit

//MARK: Extension to show activity indicator
extension UIActivityIndicatorView {
    func show() {
        startAnimating()
        isHidden = false
    }
    
    func hide() {
        stopAnimating()
        isHidden = true
    }
}

//MARK: Image caching for downloaded image
var imageCache =  NSCache<AnyObject, AnyObject>()

//MARK: Downloaded image
extension UIImageView {
    func downloadImage(url: String?) {
        self.image = nil

        guard let urlString = url else {
            return
        }
        
        //Retrieve image from imageCache variable
        if let image = imageCache.object(forKey: urlString as NSString) {
            self.image = image as? UIImage
        }
        
        if let url = URL(string: urlString) {
            DispatchQueue.global().async { [weak self] in
                //Download image
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        //Update ui: set image in main queue
                        DispatchQueue.main.async {
                            //Store image in cache memory imageCache
                            imageCache.setObject(image, forKey: urlString as NSString)
                            //set image
                            self?.image = image
                        }
                    }
                }
            }
        }
    }
}
