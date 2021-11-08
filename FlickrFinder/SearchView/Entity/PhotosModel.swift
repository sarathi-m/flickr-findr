//
//  Model.swift
//  FlickrFindr
//
//  Created by Sarathi Murugesan on 11/4/21.
//

import Foundation

// MARK: - Photos
struct Photos: Codable {
    let page, pages, perpage, total: Int?
    let photo: [Photo]?
}

// MARK: - Photo
struct Photo: Codable {
    let id, owner, secret, server: String?
    let farm: Int?
    let title: String?
    let ispublic, isfriend, isfamily: Int?
}
