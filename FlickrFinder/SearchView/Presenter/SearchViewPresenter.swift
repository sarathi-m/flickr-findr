//
//  SearchPresenter.swift
//  FlickrFinder
//
//  Created by Sarathi Murugesan on 11/4/21.
//

import Foundation

class SearchViewPresenter: SearchViewToPresenterProtocol {

    // MARK: - Properties
    weak var view: SearchViewPresenterToViewProtocol?
    var interactor: SearchViewPresentorToInteractorProtocol?
    var router: SearchViewPresenterToRouterProtocol?
    
    // MARK: - Methods
    func searchRequest(text: String) {
        interactor?.fetchSearchResult(text: text)
    }
    
    func nextPageRequest() {
        interactor?.fetchNextPage()
    }
    
    func getPhotosCount() -> Int? {
        return interactor?.photos?.photo?.count
    }
    
    func isPageLoaderNeeded() -> Bool {
        return interactor?.photos?.photo?.count ?? 0 >= 25
    }
    
    func getPhoto(index: Int) -> Photo? {
        return interactor?.photos?.photo?[index]
    }
    
    func navigateToDetailView(fromRow row: Int?) {
        guard let tempRow = row, let photo = interactor?.photos?.photo?[tempRow] else {
            return
        }
        
        if let server = photo.server, let id = photo.id, let sercet = photo.secret {
            router?.launchDetailViewController(fromView: view, imageUrl: "\(image_base_url)\(server)/\(id)_\(sercet)_b.png")
        }
    }
}

// MARK: - SearchViewInteractorToPresenterProtocol
extension SearchViewPresenter: SearchViewInteractorToPresenterProtocol {
    func nextPageFetched() {
        view?.showNextPage()
    }
    
    func searchResultFetched() {
        view?.showSearchResult()
    }
    
    func searchFailed(error: NetworkError) {
        view?.showError(description: error.description)
    }
}

