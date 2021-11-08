//
//  DetailedRouter.swift
//  FlickrFinder
//
//  Created by Sarathi Murugesan on 11/5/21.
//

import Foundation

protocol DetailedViewPresenterToRouterProtocol: class {
    /// Create and return EQDetailViewController
    static func createEQDetailViewController() -> DetailedViewController
}

class DetailedViewRouter: DetailedViewPresenterToRouterProtocol{
    
    // MARK: - Methods
    class func createModule() -> UIViewController {
        
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
}
