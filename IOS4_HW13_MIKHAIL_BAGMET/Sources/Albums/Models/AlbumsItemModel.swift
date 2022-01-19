//
//  AlbumsItemModel.swift
//  IOS4_HW13_MIKHAIL_BAGMET
//
//  Created by Михаил on 28.12.2021.
//

import Foundation

struct AlbumsItemModel: Decodable, Hashable {
    let albumTitle: String
    let picturesQty: String
    let albumPicture: String?
    let albumIcon: String?
    let peoplePhotos: [String]?
    let whoPost: String?
}
