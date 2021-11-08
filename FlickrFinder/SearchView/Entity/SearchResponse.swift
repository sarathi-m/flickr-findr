//
//  SearchResponse.swift
//  FlickrFinder
//
//  Created by Sarathi Murugesan on 11/4/21.
//

import Foundation

// MARK: - SearchResponse
struct SearchResponse: Codable {
    let photos: Photos?
    let stat: String?
}
