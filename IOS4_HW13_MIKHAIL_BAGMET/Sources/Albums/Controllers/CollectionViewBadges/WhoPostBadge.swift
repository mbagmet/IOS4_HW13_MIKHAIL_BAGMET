//
//  WhoPostBadge.swift
//  IOS4_HW13_MIKHAIL_BAGMET
//
//  Created by Михаил on 28.01.2022.
//

import UIKit

class WhoPostBadge: UICollectionReusableView {
    static let identifier = "WhoPostBadge"

    private lazy var badge: UILabel = {
        let badge = UILabel()
        badge.textColor = .white
        badge.font = UIFont.systemFont(ofSize: 16)
        return badge
    }()

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupHierarchy()
        setupLayout()
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override var frame: CGRect {
        didSet {
            configureBorder()
        }
    }
    override var bounds: CGRect {
        didSet {
            configureBorder()
        }
    }

    // MARK: - Settings
    func setupHierarchy() {
        addSubview(badge)
    }

    func setupLayout() {
        badge.translatesAutoresizingMaskIntoConstraints = false
        badge.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        badge.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }

    func setupView() {
        backgroundColor = .systemGray
        configureBorder()
    }

    private func configureBorder() {
        let radius = bounds.width / 2.0
        layer.cornerRadius = radius
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1.0
    }

    // MARK: - Configuration
    public func configureBadge(with model: AlbumsItemModel) {
        badge.text = model.whoPost
    }
}
