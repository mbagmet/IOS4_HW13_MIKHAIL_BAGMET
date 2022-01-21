//
//  AlbumsCollectionViewCell.swift
//  IOS4_HW13_MIKHAIL_BAGMET
//
//  Created by Михаил on 19.01.2022.
//

import UIKit

class AlbumCollectionViewCell: UICollectionViewCell {
    static let identifier = "AlbumCollectionViewCell"

    private lazy var albumImage: UIImageView = {
        let albumImage = UIImageView()
        albumImage.contentMode = .scaleAspectFill
        albumImage.tintColor = .systemGray3
        return albumImage
    }()

    private lazy var albumTitle: UILabel = {
        let title = UILabel()
        title.textColor = .label
        title.font = .systemFont(ofSize: 16, weight: .regular)

        return title
    }()

    private lazy var photosQty: UILabel = {
        let title = UILabel()
        title.textColor = .systemGray
        title.font = .systemFont(ofSize: 15, weight: .regular)

        return title
    }()

    private lazy var parentStackView: UIStackView = {
        let stackView = UIStackView()

        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing

        return stackView
    }()

    private lazy var imageStackView: UIStackView = {
        let stackView = UIStackView()

        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing

        stackView.backgroundColor = .systemGray6
        stackView.layer.masksToBounds = true
        stackView.layer.cornerRadius = 5

        return stackView
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
        addSubview(parentStackView)

        parentStackView.addArrangedSubview(imageStackView)
        parentStackView.addArrangedSubview(albumTitle)
        parentStackView.addArrangedSubview(photosQty)

        imageStackView.addArrangedSubview(albumImage)
    }

    private func setupLayout() {

        parentStackView.translatesAutoresizingMaskIntoConstraints = false
        parentStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        parentStackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        parentStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        parentStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        imageStackView.translatesAutoresizingMaskIntoConstraints = false
        imageStackView.heightAnchor.constraint(equalTo: parentStackView.widthAnchor, multiplier: 1.0).isActive = true

        albumImage.translatesAutoresizingMaskIntoConstraints = false
        albumImage.heightAnchor.constraint(equalTo: imageStackView.widthAnchor, multiplier: 1.0).isActive = true
    }

    // MARK: - Private func

    private func setNoImageIcon() {
        let config = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 60, weight: .thin))
        albumImage.image = UIImage(systemName: "rectangle.on.rectangle", withConfiguration: config)
        albumImage.contentMode = .center
    }

    // MARK: - Configuration

    public func configureCell(with model: AlbumsItemModel) {
        if let albumPicture = model.albumPicture {
            albumImage.image = UIImage(named: albumPicture)
            albumImage.contentMode = .scaleAspectFill
        } else {
            setNoImageIcon()
        }

        albumTitle.text = model.albumTitle
        photosQty.text = model.picturesQty
    }
}
