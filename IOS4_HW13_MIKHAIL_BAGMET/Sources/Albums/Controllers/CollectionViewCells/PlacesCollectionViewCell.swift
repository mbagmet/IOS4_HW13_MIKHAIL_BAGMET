//
//  PlacesCollectionViewCell.swift
//  IOS4_HW13_MIKHAIL_BAGMET
//
//  Created by Михаил on 21.01.2022.
//

import UIKit

class PlacesCollectionViewCell: AlbumCollectionViewCell {
    static let identifierPlacesCell = "PlacesCollectionViewCell"

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
