//
//  DetailedViewPresenter.swift
//  FlickrFinder
//
//  Created by Sarathi Murugesan on 11/5/21.
//

import Foundation

protocol DetailViewToPresenterProtocol: AnyObject {
    var imageUrl: String? { get set }
}

class DetailViewPresenter: DetailViewToPresenterProtocol {
    // MARK: - Properties
    var imageUrl: String?
}
