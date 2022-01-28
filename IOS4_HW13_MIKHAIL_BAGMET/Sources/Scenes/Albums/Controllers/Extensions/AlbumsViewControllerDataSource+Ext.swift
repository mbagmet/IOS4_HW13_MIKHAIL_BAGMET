//
//  AlbumsViewControllerDataSource+Ext.swift
//  IOS4_HW13_MIKHAIL_BAGMET
//
//  Created by Михаил on 28.01.2022.
//

import UIKit

// MARK: - CollectionView DiffableDataSource

extension AlbumsViewController {
    func createData() {
        createDataSource()
        reloadData()
    }

    private func createDataSource() {

        let albumCellRegistration = UICollectionView.CellRegistration<AlbumCollectionViewCell, AlbumsItemModel> { (cell, indexPath, item) in
            cell.configureCell(with: item)
        }

        let peopleCellRegistration = UICollectionView.CellRegistration<PeopleCollectionViewCell, AlbumsItemModel> { (cell, indexPath, item) in
            cell.configureCell(with: item)
        }

        let placesCellRegistration = UICollectionView.CellRegistration<PlacesCollectionViewCell, AlbumsItemModel> { (cell, indexPath, item) in
            cell.configureCell(with: item)
        }

        let listCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, AlbumsItemModel> { (cell, indexPath, item) in
            self.configureListCell(with: item, cell: cell)
        }

        dataSource = UICollectionViewDiffableDataSource<AlbumsSectionModel, AlbumsItemModel>(collectionView: collectionView, cellProvider: {
            (collectionView, indexPath, item) -> UICollectionViewCell? in

            let item = self.sections[indexPath.section].items[indexPath.item]

            switch self.sections[indexPath.section].type {

            case .myAlbums, .commonAlbums:
                return collectionView.dequeueConfiguredReusableCell(using: albumCellRegistration, for: indexPath, item: item)

            case .peopleAndPlaces:
                if self.sections[indexPath.section].items[indexPath.item].peoplePhotos != nil {
                    return collectionView.dequeueConfiguredReusableCell(using: peopleCellRegistration, for: indexPath, item: item)
                } else {
                    return collectionView.dequeueConfiguredReusableCell(using: placesCellRegistration, for: indexPath, item: item)
                }

            case .mediafilesTypes, .another:
                return collectionView.dequeueConfiguredReusableCell(using: listCellRegistration, for: indexPath, item: item)

            case .unknown:
                fatalError("Unknown section type!")
            }
        })

        self.createHeaderSupplementary()
    }

    private func createHeaderSupplementary() {

        let headerSuplementaryRegistration = UICollectionView.SupplementaryRegistration<AlbumsSectionHeader>(
            elementKind: UICollectionView.elementKindSectionHeader) { sectionHeaderView, elementKind, indexPath in

            guard let firstItem = self.dataSource?.itemIdentifier(for: indexPath) else { return }
            guard let section = self.dataSource?.snapshot().sectionIdentifier(containingItem: firstItem) else { return }

            if section.title.isEmpty {
                return
            } else {
                switch self.sections[indexPath.section].type {
                case .myAlbums, .commonAlbums:
                    sectionHeaderView.configureHeader(with: section, button: true)
                default:
                    sectionHeaderView.configureHeader(with: section, button: false)
                }
            }
        }

        dataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            return self?.collectionView.dequeueConfiguredReusableSupplementary(using: headerSuplementaryRegistration, for: indexPath)
        }
    }

    private func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<AlbumsSectionModel, AlbumsItemModel>()
        snapshot.appendSections(sections)

        for section in sections {
            snapshot.appendItems(section.items, toSection: section)
        }

        dataSource?.apply(snapshot)
    }
}
