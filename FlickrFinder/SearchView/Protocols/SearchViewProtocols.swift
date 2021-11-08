//
//  SearchProtocols.swift
//  FlickrFinder
//
//  Created by Sarathi Murugesan on 11/4/21.
//

import Foundation

import UIKit

protocol SearchViewPresenterToViewProtocol: AnyObject {
    func showSearchResult()
    func showError()
}

protocol SearchViewInteractorToPresenterProtocol: AnyObject {
    func searchResultFetched()
    func searchFailed()
}

protocol SearchViewPresentorToInteractorProtocol: AnyObject {
    var presenter: SearchViewInteractorToPresenterProtocol? { get set }
    var photos: Photos? { get }
    var networkManager: NetworkManager? { get set }

    func fetchSearchResult()
}

protocol SearchViewToPresenterProtocol: AnyObject {
    var view: SearchViewPresenterToViewProtocol? { get set }
    var interactor: SearchViewPresentorToInteractorProtocol? { get set }
    var router: SearchViewPresenterToRouterProtocol? { get set }
    
    func updateView()
    func getPhotosCount() -> Int?
    func getPhoto(index: Int) -> Photo?
}

protocol SearchViewPresenterToRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
}
