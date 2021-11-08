//
//  SearchInteractor.swift
//  FlickrFinder
//
//  Created by Sarathi Murugesan on 11/4/21.
//

import Foundation

class SearchViewInteractor: SearchViewPresentorToInteractorProtocol {

    // MARK: - Properties
    weak var presenter: SearchViewInteractorToPresenterProtocol?
    var networkManager: NetworkManager? = NetworkManager()
    
    var photos: Photos?
    var currentSearchText: String?
    
    // MARK: - Methods
    func fetchSearchResult(text: String) {
        currentSearchText = text
        
        guard let url = createURL(from: text) else {
            self.presenter?.searchFailed(error: .UrlError)
            return
        }
        
        networkManager?.fetchData(url: url, dataHandler: { [unowned self] (response: Result<SearchResponse?, NetworkError>) in
            DispatchQueue.main.async {
                switch response {
                    case .failure(let err):
                        self.presenter?.searchFailed(error: err)
                    case .success(let data):
                        if let status = data?.stat, status == "fail", let message = data?.message, data?.photos == nil {
                            self.presenter?.searchFailed(error: .CustomError(description: message))
                        } else {
                            self.photos = data?.photos
                            self.presenter?.searchResultFetched()
                        }
                }
            }
        })
    }
    
    func fetchNextPage() {
        if let searchText = currentSearchText {

            guard let totalFetchedPages = self.photos?.page, let url = createURL(from: searchText, page: "\(totalFetchedPages + 1)") else {
                self.presenter?.searchFailed(error: .UrlError)
                return
            }
            
            networkManager?.fetchData(url: url, dataHandler: { [unowned self] (response: Result<SearchResponse?, NetworkError>) in
                DispatchQueue.main.async {
                    switch response {
                        case .failure(let err):
                            self.presenter?.searchFailed(error: err)
                        case .success(let data):
                            if let photo = data?.photos?.photo {
                                self.photos?.photo?.append(contentsOf: photo)
                                self.presenter?.nextPageFetched()
                        }
                    }
                }
            })
        }
    }
    
    private func createURL(from urlString: String, page: String = "1") -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = domain
        components.path = path
        
        let queryItemToken = URLQueryItem(name: "method", value: api_name)
        let queryItemQuery = URLQueryItem(name: "api_key", value: api_key)
        let queryItemText = URLQueryItem(name: "text", value: urlString)
        let queryItemPerPage = URLQueryItem(name: "per_page", value: photos_per_page)
        let queryItemPage = URLQueryItem(name: "page", value: page)
        let queryItemFormat = URLQueryItem(name: "format", value: data_format)
        let queryItemCallBack = URLQueryItem(name: "nojsoncallback", value: "1")

        components.queryItems = [queryItemToken, queryItemQuery, queryItemText, queryItemPerPage, queryItemPage, queryItemFormat, queryItemCallBack]
        return components.url
    }
    
}
