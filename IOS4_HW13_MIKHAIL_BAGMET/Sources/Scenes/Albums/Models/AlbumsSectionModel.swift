//
//  SectionModel.swift
//  IOS4_HW13_MIKHAIL_BAGMET
//
//  Created by Михаил on 28.12.2021.
//

import Foundation

enum AlbumsSectionType: Decodable, Hashable {
    case myAlbums
    case commonAlbums
    case peopleAndPlaces
    case mediafilesTypes
    case another
    case unknown(value: String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let status = try? container.decode(String.self)
        switch status {
              case "myAlbums": self = .myAlbums
              case "commonAlbums": self = .commonAlbums
              case "peopleAndPlaces": self = .peopleAndPlaces
              case "mediafilesTypes": self = .mediafilesTypes
              case "another": self = .another
              default:
                 self = .unknown(value: status ?? "unknown")
          }
    }
}

struct AlbumsSectionModel: Decodable, Hashable {
    let type: AlbumsSectionType
    let title: String
    let items: [AlbumsItemModel]
}
