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

        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: AlbumCollectionViewCell.identifier)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: PeopleCollectionViewCell.identifier)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ListCollectionViewCell.identifier)
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
            case .commonAlbums:
                return self.createAlbumsSection(direction: .vertical, itemHeight: Metrics.itemHeight, groupHeight: Metrics.groupHeight)
            case .peopleAndPlaces:
                return self.createAlbumsSection(direction: .vertical, itemHeight: Metrics.itemHeight, groupHeight: Metrics.groupHeight)
            case .mediafilesTypes:
                return self.createListSection(layoutEnvironment: layoutEnvironment)
            case .another:
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
        item.contentInsets = NSDirectionalEdgeInsets.init(top: 5, leading: 5, bottom: 5, trailing: 5)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(Metrics.groupWidth), heightDimension: .fractionalWidth(groupHeight))

        var group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        if direction == .horizontal {
            group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        }

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 10, bottom: 0, trailing: 14)

        return section
    }

    private func createListSection(layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {

        let section = NSCollectionLayoutSection.list(using: .init(appearance: .insetGrouped), layoutEnvironment: layoutEnvironment)
        return section
    }

}

// MARK: - CollectionView DiffableDataSource

extension AlbumsViewController {
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<AlbumsSectionModel, AlbumsItemModel>(collectionView: collectionView, cellProvider: {
            collectionView, indexPath, item in

            switch self.sections[indexPath.section].type {

            case .myAlbums:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumCollectionViewCell.identifier, for: indexPath)
                cell.backgroundColor = .systemGreen
                return cell
            case .commonAlbums:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumCollectionViewCell.identifier, for: indexPath)
                cell.backgroundColor = .systemYellow
                return cell
            case .peopleAndPlaces:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PeopleCollectionViewCell.identifier, for: indexPath)
                cell.backgroundColor = .systemTeal
                return cell
            case .mediafilesTypes:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.identifier, for: indexPath)
                return cell
            case .another:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.identifier, for: indexPath)
                return cell
            case .unknown:
                fatalError("Unknown section type!")
            }
        })
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
        static let groupHeight: CGFloat = 0.55
        static let myAlbumsGroupHeight: CGFloat = groupHeight * 2
    }
}
