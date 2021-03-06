//
//  ListCollectionViewCell.swift
//  IOS4_HW13_MIKHAIL_BAGMET
//
//  Created by Михаил on 19.01.2022.
//

import UIKit

// MARK: - Standard ListCollectionViewCell

extension AlbumsViewController {
    func configureListCell(with model: AlbumsItemModel, cell: UICollectionViewListCell) {
        var configuration = cell.defaultContentConfiguration()
        configuration.prefersSideBySideTextAndSecondaryText = true

        configuration.text = model.albumTitle
        configuration.textProperties.font = .systemFont(ofSize: Metrics.albumTitleFontSize, weight: .regular)
        configuration.textProperties.color = .link

        configuration.secondaryText = model.picturesQty
        configuration.secondaryTextProperties.font = .systemFont(ofSize: Metrics.photosQtyFontSize, weight: .regular)
        configuration.secondaryTextProperties.color = .systemGray

        guard let itemIcon = model.albumIcon else { return }
        configuration.image = UIImage(systemName: itemIcon)

        cell.contentConfiguration = configuration

        let options = UICellAccessory.OutlineDisclosureOptions(style: .cell, tintColor: .systemGray)
        let disclosureAccessory = UICellAccessory.outlineDisclosure(options: options)
        cell.accessories = [disclosureAccessory]
    }
}
