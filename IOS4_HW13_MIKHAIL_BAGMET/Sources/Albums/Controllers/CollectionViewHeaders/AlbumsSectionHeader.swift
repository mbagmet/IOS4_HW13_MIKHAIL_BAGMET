//
//  AlbumsSectionHeader.swift
//  IOS4_HW13_MIKHAIL_BAGMET
//
//  Created by Михаил on 19.01.2022.
//

import UIKit

class AlbumsSectionHeader: UICollectionReusableView {

    static let identifier = "AlbumsSectionHeader"

    private lazy var sectionTitle: UILabel = {
        let title = UILabel()
        title.textColor = .label
        title.font = .systemFont(ofSize: 21, weight: .bold)

        return title
    }()

    private lazy var toAllButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Все", for: .normal)
        button.setTitleColor(.link, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)

        return button
    }()

    private lazy var parentStackView: UIStackView = {
        let stackView = UIStackView()

        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing

        return stackView
    }()

    private lazy var separator: UIView = {
        let line = UIView(frame: CGRect(x: 0, y: 0, width: 1100, height: 1.0))
        line.backgroundColor = .systemGray5

        return line
    }()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupHierarchy()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Settings

    private func setupHierarchy() {
        addSubview(separator)
        addSubview(parentStackView)
        parentStackView.addArrangedSubview(sectionTitle)
        parentStackView.addArrangedSubview(toAllButton)
    }

    private func setupLayout() {
        parentStackView.translatesAutoresizingMaskIntoConstraints = false
        parentStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        parentStackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        parentStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        parentStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    // MARK: - Configuration

    public func configureHeader(with model: AlbumsSectionModel, button: Bool) {
        sectionTitle.text = model.title

        if !button {
            toAllButton.isHidden = true
        } else {
            toAllButton.isHidden = false
        }
    }
}
