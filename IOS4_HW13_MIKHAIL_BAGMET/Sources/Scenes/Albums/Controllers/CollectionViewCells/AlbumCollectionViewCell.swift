//
//  AlbumsCollectionViewCell.swift
//  IOS4_HW13_MIKHAIL_BAGMET
//
//  Created by Михаил on 19.01.2022.
//

import UIKit

class AlbumCollectionViewCell: UICollectionViewCell {
    static let identifier = "AlbumCollectionViewCell"

    lazy var albumImage: UIImageView = {
        let albumImage = UIImageView()
        albumImage.contentMode = .scaleAspectFill
        albumImage.tintColor = .systemGray3
        return albumImage
    }()

    private lazy var albumTitle: UILabel = {
        let title = UILabel()
        title.textColor = .label
        title.font = .systemFont(ofSize: Metric.albumTitleFontSize, weight: .regular)

        return title
    }()

    private lazy var photosQty: UILabel = {
        let title = UILabel()
        title.textColor = .systemGray
        title.font = .systemFont(ofSize: Metric.photosQtyFontSize, weight: .regular)

        return title
    }()

    private lazy var parentStackView: UIStackView = {
        let stackView = UIStackView()

        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing

        return stackView
    }()

    lazy var imageStackView: UIStackView = {
        let stackView = UIStackView()

        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing

        stackView.backgroundColor = .systemGray6
        stackView.layer.masksToBounds = true
        stackView.layer.cornerRadius = Metric.imageCornerRadius

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

    func setupHierarchy() {
        addSubview(parentStackView)

        parentStackView.addArrangedSubview(imageStackView)
        parentStackView.addArrangedSubview(albumTitle)
        parentStackView.addArrangedSubview(photosQty)

        imageStackView.addArrangedSubview(albumImage)
    }

    func setupLayout() {

        parentStackView.addConstraints(top: self.topAnchor, paddingTop: Metric.parentStackViewPaddings,
                                       left: self.leadingAnchor, paddingLeft: Metric.parentStackViewPaddings,
                                       right: self.trailingAnchor, paddingRight: Metric.parentStackViewPaddings,
                                       bottom: self.bottomAnchor, paddingBottom: Metric.parentStackViewPaddings)

        imageStackView.translatesAutoresizingMaskIntoConstraints = false
        imageStackView.heightAnchor.constraint(equalTo: parentStackView.widthAnchor, multiplier: Metric.imageRatio).isActive = true
    }

    // MARK: - Private func

    private func setNoImageIcon() {
        let config = UIImage.SymbolConfiguration(font: .systemFont(ofSize: Metric.noImageIconSize, weight: .thin))
        albumImage.image = UIImage(systemName: "rectangle.on.rectangle", withConfiguration: config)
        albumImage.contentMode = .center
    }

    // MARK: - Configuration

    public func configureCell(with model: AlbumsItemModel) {
        if let albumPicture = model.albumPicture {
            albumImage.image = UIImage(named: albumPicture)
            albumImage.contentMode = .scaleAspectFill
        } else if model.peoplePhotos == nil {
            setNoImageIcon()
        }

        albumTitle.text = model.albumTitle
        photosQty.text = model.picturesQty
    }
}

// MARK: - Constants

extension AlbumCollectionViewCell {
    enum Metric {
        static let albumTitleFontSize: CGFloat = 16
        static let photosQtyFontSize: CGFloat = 15
        static let noImageIconSize: CGFloat = 60

        static let imageCornerRadius: CGFloat = 5
        static let imageRatio: CGFloat = 1.0
        static let parentStackViewPaddings: CGFloat = 0
    }
}
