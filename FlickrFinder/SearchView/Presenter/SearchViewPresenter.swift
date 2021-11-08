//
//  SearchPresenter.swift
//  FlickrFinder
//
//  Created by Sarathi Murugesan on 11/4/21.
//

import Foundation

class SearchPresenter: SearchViewToPresenterProtocol {

    // MARK: - Properties
    weak var view: SearchViewPresenterToViewProtocol?
    var interactor: SearchViewPresentorToInteractorProtocol?
    var router: SearchViewPresenterToRouterProtocol?
    
    // MARK: - Methods
    func updateView() {
        interactor?.fetchSearchResult()
    }
    
    func getNewsListCount() -> Int? {
        return interactor?.photos?.photo?.count
    }
    
    func getPhoto(index: Int) -> Photo? {
        return interactor?.photos?.photo?[index]
    }
}

// MARK: - SearchViewInteractorToPresenterProtocol
extension SearchPresenter: SearchViewInteractorToPresenterProtocol {
    func searchResultFetched() {
        view?.showSearchResult()
    }
    
    func searchFailed() {
        view?.showError()
    }
}

