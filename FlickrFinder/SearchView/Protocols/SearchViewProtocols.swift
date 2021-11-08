//
//  SearchProtocols.swift
//  FlickrFinder
//
//  Created by Sarathi Murugesan on 11/4/21.
//

import Foundation
import UIKit

// MARK: - Protocols
protocol SearchViewPresenterToViewProtocol: AnyObject {
    func showSearchResult()
    func showNextPage()
    func showError(description: String)
}

protocol SearchViewInteractorToPresenterProtocol: AnyObject {
    func nextPageFetched()
    func searchResultFetched()
    func searchFailed(error: NetworkError)
}

protocol SearchViewPresentorToInteractorProtocol: AnyObject {
    var presenter: SearchViewInteractorToPresenterProtocol? { get set }
    var networkManager: NetworkManager? { get set }

    var photos: Photos? { get }

    func fetchSearchResult(text: String)
    func fetchNextPage()
}

protocol SearchViewToPresenterProtocol: AnyObject {
    var view: SearchViewPresenterToViewProtocol? { get set }
    var interactor: SearchViewPresentorToInteractorProtocol? { get set }
    var router: SearchViewPresenterToRouterProtocol? { get set }
    
    func searchRequest(text: String)
    func nextPageRequest()
    
    func getPhotosCount() -> Int?
    func getPhoto(index: Int) -> Photo?
    func navigateToDetailView(fromRow row: Int?)
    
    func isPageLoaderNeeded() -> Bool
}

protocol SearchViewPresenterToRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
    func launchDetailViewController(fromView view: SearchViewPresenterToViewProtocol?, imageUrl: String?)

}
