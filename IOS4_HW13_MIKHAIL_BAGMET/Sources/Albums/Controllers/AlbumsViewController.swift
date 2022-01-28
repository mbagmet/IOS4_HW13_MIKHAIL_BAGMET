//
//  AlbumsCollectionViewController.swift
//  IOS4_HW13_MIKHAIL_BAGMET
//
//  Created by Михаил on 28.12.2021.
//

import UIKit

class AlbumsViewController: UIViewController {

    let sections = Bundle.main.decode([AlbumsSectionModel].self, from: "Model.json")

    private lazy var collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())

    var dataSource: UICollectionViewDiffableDataSource<AlbumsSectionModel, AlbumsItemModel>?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupHierarchy()
        setupView()
        setupNavigation()

        setupCollectionView()
        createDataSource()
        reloadData()
    }

    // MARK: - Settings

    private func setupHierarchy() {
        view.addSubview(collectionView)
    }

    private func setupView() {
        view.backgroundColor = .systemBackground
    }

    private func setupCollectionView() {
        collectionView.backgroundColor = .systemBackground
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

    // MARK: - Navigation

    private func setupNavigation() {
        navigationItem.title = Strings.navigationTitle
        self.navigationController?.navigationBar.prefersLargeTitles = true

        let navItem = UIBarButtonItem(image: UIImage(systemName: "plus"), menu: createMenu())
        navigationItem.leftBarButtonItem = navItem
    }

    // MARK: - Compositional Layout

    private func createCompositionalLayout() -> UICollectionViewLayout {
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

// MARK: - CollectionView DiffableDataSource

extension AlbumsViewController {
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

        self.createHeaderSupplementary() //(cellType: AlbumsSectionHeader.self, reuseIdentifier: AlbumsSectionHeader.identifier)
    }

    private func createHeaderSupplementary() /*<T: AlbumsSectionHeader>(cellType: T.Type, reuseIdentifier: String)*/ {

        let headerSuplementaryRegistration = UICollectionView.SupplementaryRegistration<AlbumsSectionHeader>(elementKind: UICollectionView.elementKindSectionHeader) { sectionHeaderView, elementKind, indexPath in

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
    }
}
