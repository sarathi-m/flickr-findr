//
//  DetailedRouter.swift
//  FlickrFinder
//
//  Created by Sarathi Murugesan on 11/5/21.
//

import Foundation
import UIKit

protocol DetailViewPresenterToRouterProtocol: AnyObject {
    static func createDetailViewController() -> DetailViewController
}

class DetailViewRouter: DetailViewPresenterToRouterProtocol {
    // MARK: - Methods
    static func createDetailViewController() -> DetailViewController {
        let viewController = DetailViewController()
        let presenter: DetailViewToPresenterProtocol = DetailViewPresenter()

        viewController.presenter = presenter
        return viewController
    }
}
