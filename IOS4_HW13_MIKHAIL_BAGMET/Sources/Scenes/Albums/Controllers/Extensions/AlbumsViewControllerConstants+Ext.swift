//
//  AlbumViewControllerConstants+Ext.swift
//  IOS4_HW13_MIKHAIL_BAGMET
//
//  Created by Михаил on 28.01.2022.
//

import UIKit

// MARK: - Constants

extension AlbumsViewController {
    enum Strings {
        static let navigationTitle = "Альбомы"
    }

    enum GroupDirection {
        case vertical
        case horizontal
    }

    enum Metrics {
        static let estimatedItemWidth: CGFloat = 230
        static let itemsInColumn: CGFloat = 1
        static let muAlbumsItemsInColumn: CGFloat = 2

        static let itemWidth: CGFloat = 1.0
        static let itemHeight: CGFloat = 1.0
        static let myAlbumsItemHeight: CGFloat = 0.5

        static let heightWidthMultiplier: CGFloat = 1.28

        static let distanceBetweenItems: CGFloat = 0.03

        static let albumTitleFontSize: CGFloat = 19
        static let photosQtyFontSize: CGFloat = 15
    }
}
