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
//        setupLayout()
        setupNavigation()

        setupCollectionView()
        createDataSource()
        reloadData()
    }

    // MARK: - Settings

    private func setupHierarchy() {
        view.addSubview(collectionView)
    }

    private func setupLayout() {

    }

    private func setupView() {
        view.backgroundColor = .systemBackground
    }

    private func setupCollectionView() {
        collectionView.backgroundColor = .systemBackground
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        collectionView.register(AlbumCollectionViewCell.self, forCellWithReuseIdentifier: AlbumCollectionViewCell.identifier)
        collectionView.register(PeopleCollectionViewCell.self, forCellWithReuseIdentifier: PeopleCollectionViewCell.identifierPeopleCell)
        collectionView.register(PlacesCollectionViewCell.self, forCellWithReuseIdentifier: PlacesCollectionViewCell.identifierPlacesCell)
        collectionView.register(ListCollectionViewCell.self, forCellWithReuseIdentifier: ListCollectionViewCell.identifier)

        collectionView.register(AlbumsSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: AlbumsSectionHeader.identifier)
    }

    // MARK: - Private functions

    private func setupNavigation() {
        navigationItem.title = Strings.navigationTitle
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

    // MARK: - Compositional Layout

    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let section = self.sections[sectionIndex]

            switch section.type {
            
            case .myAlbums:
                return self.createAlbumsSection(direction: .vertical, itemHeight: Metrics.myAlbumsItemHeight, groupHeight: Metrics.myAlbumsGroupHeight)
            case .commonAlbums, .peopleAndPlaces:
                return self.createAlbumsSection(direction: .vertical, itemHeight: Metrics.itemHeight, groupHeight: Metrics.groupHeight)
            case .mediafilesTypes, .another:
                return self.createListSection(layoutEnvironment: layoutEnvironment)
            case .unknown:
                fatalError("Unknown section type!")
            }
        }

        return layout
    }

    private func createAlbumsSection(direction: GroupDirection, itemHeight: CGFloat, groupHeight: CGFloat) -> NSCollectionLayoutSection {

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(Metrics.itemWidth), heightDimension: .fractionalHeight(itemHeight))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 5, bottom: 20, trailing: 5)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(Metrics.groupWidth), heightDimension: .fractionalWidth(groupHeight))

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
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 20, bottom: 10, trailing: 0)

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
        dataSource = UICollectionViewDiffableDataSource<AlbumsSectionModel, AlbumsItemModel>(collectionView: collectionView, cellProvider: {
            (collectionView, indexPath, item) -> UICollectionViewCell? in

            let item = self.sections[indexPath.section].items[indexPath.item]

            switch self.sections[indexPath.section].type {

            case .myAlbums, .commonAlbums:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumCollectionViewCell.identifier, for: indexPath)
                    as? AlbumCollectionViewCell
                cell?.configureCell(with: item)
                return cell

            case .peopleAndPlaces:
                if self.sections[indexPath.section].items[indexPath.item].peoplePhotos != nil {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PeopleCollectionViewCell.identifierPeopleCell, for: indexPath)
                        as? PeopleCollectionViewCell
                    cell?.backgroundColor = .systemTeal
                    return cell
                } else {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlacesCollectionViewCell.identifierPlacesCell, for: indexPath)
                        as? PlacesCollectionViewCell
                    cell?.configureCell(with: item)
                    return cell
                }

            case .mediafilesTypes, .another:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.identifier, for: indexPath)
                    as? ListCollectionViewCell
                return cell
                
            case .unknown:
                fatalError("Unknown section type!")
            }
        })

        self.createHeaderSupplementary(cellType: AlbumsSectionHeader.self, reuseIdentifier: AlbumsSectionHeader.identifier)
    }

    private func createHeaderSupplementary<T: AlbumsSectionHeader>(cellType: T.Type, reuseIdentifier: String) {
        dataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in

            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                      withReuseIdentifier: reuseIdentifier,
                                                                                      for: indexPath) as? T
            else { return nil }

            guard let firstItem = self?.dataSource?.itemIdentifier(for: indexPath) else { return nil }
            guard let section = self?.dataSource?.snapshot().sectionIdentifier(containingItem: firstItem) else { return nil }

            if section.title.isEmpty {
                return nil
            } else {
                switch self?.sections[indexPath.section].type {
                case .myAlbums, .commonAlbums:
                    sectionHeader.configureHeader(with: section, button: true)
                default:
                    sectionHeader.configureHeader(with: section, button: false)
                }
            }

            return sectionHeader
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
        static let itemWidth: CGFloat = 1.0
        static let itemHeight: CGFloat = 1.0
        static let myAlbumsItemHeight: CGFloat = 0.5

        static let groupWidth: CGFloat = 0.47
        static let groupHeight: CGFloat = 0.6
        static let myAlbumsGroupHeight: CGFloat = groupHeight * 2
    }
}
