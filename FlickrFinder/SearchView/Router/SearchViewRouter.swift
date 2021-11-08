//
//  SearchViewRouter.swift
//  FlickrFinder
//
//  Created by Sarathi Murugesan on 11/5/21.
//

import Foundation
import UIKit

class SearchViewRouter: SearchViewPresenterToRouterProtocol{
    
    // MARK: - Methods
    static func createModule() -> UIViewController {
        
        let view = SearchTableViewController()
        let presenter: SearchViewToPresenterProtocol & SearchViewInteractorToPresenterProtocol = SearchViewPresenter()
        let interactor: SearchViewPresentorToInteractorProtocol = SearchViewInteractor()
        let router: SearchViewPresenterToRouterProtocol = SearchViewRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
    
    func launchDetailViewController(fromView view: SearchViewPresenterToViewProtocol?, imageUrl: String?) {
        guard let parentVC = view as? SearchTableViewController else {
            return
        }
        
        let detailViewController = DetailViewRouter.createDetailViewController()
        detailViewController.presenter?.imageUrl = imageUrl
        parentVC.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
