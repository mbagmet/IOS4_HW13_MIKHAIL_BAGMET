//
//  SectionModel.swift
//  IOS4_HW13_MIKHAIL_BAGMET
//
//  Created by Михаил on 28.12.2021.
//

import Foundation

enum AlbumsSectionType {
    case myAlbums
    case commonAlbums
    case peopleAndPlaces
    case mediafilesTypes
    case another
}

struct AlbumsSectionModel {
    let type: AlbumsSectionType
    let title: String
    let items: [AlbumsItemModel]
}
