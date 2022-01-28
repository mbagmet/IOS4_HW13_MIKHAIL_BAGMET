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
        item.contentInsets = NSDirectionalEdgeInsets.init(top: Metrics.itemTopPadding, leading: Metrics.itemLeadingPadding,
                                                          bottom: Metrics.itemBottomPadding, trailing: Metrics.itemTrailingPadding)

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
        section.contentInsets = NSDirectionalEdgeInsets.init(top: Metrics.sectionTopPadding, leading: Metrics.sectionLeadingPadding,
                                                             bottom: Metrics.sectionBottomPadding, trailing: Metrics.sectionTrailingPadding)

        let header = createSectionHeader()
        section.boundarySupplementaryItems = [header]

        return section
    }

    private func createListSection(layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {

        let section = NSCollectionLayoutSection.list(using: .init(appearance: .plain), layoutEnvironment: layoutEnvironment)
        section.contentInsets = NSDirectionalEdgeInsets.init(top: Metrics.listSectionTopPadding, leading: Metrics.listSectionLeadingPadding,
                                                             bottom: Metrics.listSectionBottomPadding, trailing: Metrics.listSectionTrailingPadding)

        let header = createSectionHeader()
        header.contentInsets = NSDirectionalEdgeInsets.init(top: Metrics.listHeaderTopPadding, leading: Metrics.listHeaderLeadingPadding,
                                                            bottom: Metrics.listHeaderBottomPadding, trailing: Metrics.listHeaderTrailingPadding)

        section.boundarySupplementaryItems = [header]

        return section
    }

    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(Metrics.sectionHeaderHeight))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize,
                                                                        elementKind: UICollectionView.elementKindSectionHeader,
                                                                        alignment: .topLeading)

        sectionHeader.contentInsets = NSDirectionalEdgeInsets.init(top: Metrics.headerTopPadding, leading: Metrics.headerLeadingPadding,
                                                                   bottom: Metrics.headerBottomPadding, trailing: Metrics.headerTrailingPadding)

        return sectionHeader
    }
}
