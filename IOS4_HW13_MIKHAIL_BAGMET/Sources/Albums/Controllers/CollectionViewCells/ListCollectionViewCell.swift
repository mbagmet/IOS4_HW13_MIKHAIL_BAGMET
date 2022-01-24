//
//  ListCollectionViewCell.swift
//  IOS4_HW13_MIKHAIL_BAGMET
//
//  Created by Михаил on 19.01.2022.
//

import UIKit

// MARK: - Standard ListCollectionViewCell

extension AlbumsViewController {
    func createListCollectionViewCell() -> UICollectionView.CellRegistration<UICollectionViewListCell, AlbumsItemModel> {
        return .init { cell, _, item in

            var configuration = cell.defaultContentConfiguration()
            configuration.prefersSideBySideTextAndSecondaryText = true

            configuration.text = item.albumTitle
            configuration.textProperties.font = .systemFont(ofSize: 19, weight: .regular)
            configuration.textProperties.color = .link

            configuration.secondaryText = item.picturesQty
            configuration.secondaryTextProperties.font = .systemFont(ofSize: 15, weight: .regular)
            configuration.secondaryTextProperties.color = .systemGray

            guard let itemIcon = item.albumIcon else { return }
            configuration.image = UIImage(systemName: itemIcon)

            cell.contentConfiguration = configuration

            let options = UICellAccessory.OutlineDisclosureOptions(style: .cell, tintColor: .systemGray)
            let disclosureAccessory = UICellAccessory.outlineDisclosure(options: options)
            cell.accessories = [disclosureAccessory]
        }
    }
}
