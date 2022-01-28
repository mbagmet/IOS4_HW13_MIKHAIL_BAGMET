//
//  AlbumsViewConntrollerCompositionalLayout+Ext.swift
//  IOS4_HW13_MIKHAIL_BAGMET
//
//  Created by Михаил on 28.01.2022.
//

import UIKit

// MARK: - Compositional Layout

extension AlbumsViewController {
    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let section = self.sections[sectionIndex]

            switch section.type {

            case .myAlbums:
                return self.createAlbumsSection(direction: .vertical,
                                                itemHeight: Metrics.myAlbumsItemHeight,
                                                itemsInColumn: Metrics.muAlbumsItemsInColumn,
                                                environment: layoutEnvironment)
            case .commonAlbums, .peopleAndPlaces:
                return self.createAlbumsSection(direction: .vertical,
                                                itemHeight: Metrics.itemHeight,
                                                itemsInColumn: Metrics.itemsInColumn,
                                                environment: layoutEnvironment)
            case .mediafilesTypes, .another:
                return self.createListSection(layoutEnvironment: layoutEnvironment)
            case .unknown:
                fatalError("Unknown section type!")
            }
        }

        return layout
    }

    private func createAlbumsSection(direction: GroupDirection, itemHeight: CGFloat, itemsInColumn: CGFloat, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(Metrics.itemWidth), heightDimension: .fractionalHeight(itemHeight))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 5, bottom: 20, trailing: 5)

        let itemsInRowCount = environment.container.effectiveContentSize.width / Metrics.estimatedItemWidth

        let groupWidth: CGFloat = 1 / (itemsInRowCount.rounded()) - Metrics.distanceBetweenItems
        let groupHeight: CGFloat = groupWidth * Metrics.heightWidthMultiplier * itemsInColumn
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(groupWidth), heightDimension: .fractionalWidth(groupHeight))

        var group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        if direction == .horizontal {
            group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        }

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 10, bottom: 5, trailing: 14)

        let header = createSectionHeader()
        section.boundarySupplementaryItems = [header]

        return section
    }

    private func createListSection(layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {

        let section = NSCollectionLayoutSection.list(using: .init(appearance: .plain), layoutEnvironment: layoutEnvironment)
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 30, trailing: 0)

        let header = createSectionHeader()
        header.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 15, bottom: 0, trailing: 20)

        section.boundarySupplementaryItems = [header]

        return section
    }

    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(40))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize,
                                                                        elementKind: UICollectionView.elementKindSectionHeader,
                                                                        alignment: .topLeading)

        sectionHeader.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 6, bottom: 0, trailing: 6)

        return sectionHeader
    }
}
