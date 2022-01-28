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

        static let sectionHeaderHeight: CGFloat = 40

        static let itemTopPadding: CGFloat = 0
        static let itemLeadingPadding: CGFloat = 5
        static let itemBottomPadding: CGFloat = 20
        static let itemTrailingPadding: CGFloat = 5

        static let sectionTopPadding: CGFloat = 0
        static let sectionLeadingPadding: CGFloat = 10
        static let sectionBottomPadding: CGFloat = 5
        static let sectionTrailingPadding: CGFloat = 14

        static let listSectionTopPadding: CGFloat = 0
        static let listSectionLeadingPadding: CGFloat = 0
        static let listSectionBottomPadding: CGFloat = 30
        static let listSectionTrailingPadding: CGFloat = 0

        static let headerTopPadding: CGFloat = 0
        static let headerLeadingPadding: CGFloat = 6
        static let headerBottomPadding: CGFloat = 0
        static let headerTrailingPadding: CGFloat = 6

        static let listHeaderTopPadding: CGFloat = 0
        static let listHeaderLeadingPadding: CGFloat = 15
        static let listHeaderBottomPadding: CGFloat = 0
        static let listHeaderTrailingPadding: CGFloat = 20
    }
}
