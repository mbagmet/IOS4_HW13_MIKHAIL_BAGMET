//
//  AlbumsCollectionViewController.swift
//  IOS4_HW13_MIKHAIL_BAGMET
//
//  Created by Михаил on 28.12.2021.
//

import UIKit

class AlbumsViewController: UIViewController {

    let sections = Bundle.main.decode([AlbumsSectionModel].self, from: "Model.json")

    lazy var collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())

    var dataSource: UICollectionViewDiffableDataSource<AlbumsSectionModel, AlbumsItemModel>?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupHierarchy()
        setupView()
        setupNavigation()

        setupCollectionView()
        createData()
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
}
