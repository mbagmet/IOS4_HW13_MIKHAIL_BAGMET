//
//  MediaLibruaryViewController.swift
//  IOS4_HW13_MIKHAIL_BAGMET
//
//  Created by Михаил on 28.12.2021.
//

import UIKit

class MediaLibruaryViewController: UIViewController {

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupNavigation()
    }

    // MARK: - Initializers
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Settings

    private func setupView() {
        view.backgroundColor = .systemBackground
    }

    // MARK: - Private functions

    private func setupNavigation() {
        navigationItem.title = Strings.navigationTitle
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}

// MARK: - Constants

extension MediaLibruaryViewController {
    enum Strings {
        static let navigationTitle = "Медиатека"
    }
}
