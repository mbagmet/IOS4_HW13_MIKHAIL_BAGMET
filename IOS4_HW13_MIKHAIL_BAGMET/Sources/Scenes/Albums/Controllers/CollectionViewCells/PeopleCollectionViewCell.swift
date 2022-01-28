//
//  PeopleCollectionViewCell.swift
//  IOS4_HW13_MIKHAIL_BAGMET
//
//  Created by Михаил on 19.01.2022.
//

import UIKit

class PeopleCollectionViewCell: AlbumCollectionViewCell {
    static let identifierPeopleCell = "PeopleCollectionViewCell"

    private lazy var firstHorizontalStackView = createHorizontalStackView()
    private lazy var secondHorizontalStackView = createHorizontalStackView()

    private lazy var firstHumanImage = createHumanImage()
    private lazy var secondHumanImage = createHumanImage()
    private lazy var thirdHumanImage = createHumanImage()
    private lazy var fourthHumanImage = createHumanImage()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: - Lifecycle

    override func layoutSubviews() {
        super.layoutSubviews()

        createRoundedImages(images: [firstHumanImage, secondHumanImage, thirdHumanImage, fourthHumanImage])
    }

    override func willTransition(from oldLayout: UICollectionViewLayout, to newLayout: UICollectionViewLayout) {
        super.willTransition(from: oldLayout, to: newLayout)

        createRoundedImages(images: [firstHumanImage, secondHumanImage, thirdHumanImage, fourthHumanImage])
    }

    // MARK: - Settings

    override func setupHierarchy() {
        super.setupHierarchy()

        imageStackView.removeArrangedSubview(albumImage)

        imageStackView.addArrangedSubview(firstHorizontalStackView)
        imageStackView.addArrangedSubview(secondHorizontalStackView)

        firstHorizontalStackView.addArrangedSubview(firstHumanImage)
        firstHorizontalStackView.addArrangedSubview(secondHumanImage)

        secondHorizontalStackView.addArrangedSubview(thirdHumanImage)
        secondHorizontalStackView.addArrangedSubview(fourthHumanImage)
    }

    override func setupLayout() {
        super.setupLayout()

        firstHorizontalStackView.addConstraints(left: imageStackView.leadingAnchor, paddingLeft: Metric.rowHorizontalPaddings,
                                                right: imageStackView.trailingAnchor, paddingRight: Metric.rowHorizontalPaddings)
        firstHorizontalStackView.heightAnchor.constraint(equalTo: imageStackView.widthAnchor, multiplier: Metric.rowRatio).isActive = true

        secondHorizontalStackView.addConstraints(left: imageStackView.leadingAnchor, paddingLeft: Metric.rowHorizontalPaddings,
                                                right: imageStackView.trailingAnchor, paddingRight: Metric.rowHorizontalPaddings)
        secondHorizontalStackView.heightAnchor.constraint(equalTo: imageStackView.widthAnchor, multiplier: Metric.rowRatio).isActive = true

        setImagesSizes(images: [firstHumanImage, secondHumanImage], equalTo: firstHorizontalStackView)
        setImagesSizes(images: [thirdHumanImage, fourthHumanImage], equalTo: secondHorizontalStackView)
    }

    func setupView() {
        imageStackView.backgroundColor = .none
    }

    // MARK: - Private func

    private func createHorizontalStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing

        return stackView
    }

    private func createHumanImage() -> UIImageView {
        let humanImage = UIImageView()
        humanImage.contentMode = .scaleAspectFill
        humanImage.layer.masksToBounds = true

        return humanImage
    }

    private func createRoundedImages(images: [UIImageView]) {
        for image in images {
            image.layer.cornerRadius = image.bounds.size.width / 2
        }
    }

    private func setImagesSizes(images: [UIImageView], equalTo stackView: UIStackView) {
        for image in images {
            image.translatesAutoresizingMaskIntoConstraints = false
            image.heightAnchor.constraint(equalTo: stackView.heightAnchor).isActive = true
            image.widthAnchor.constraint(equalTo: image.heightAnchor).isActive = true
        }
    }

    private func fillImages(with model: AlbumsItemModel, images: [UIImageView]) {
        var counter = 0
        let elementsQty = model.peoplePhotos?.count ?? 0

        for imageView in images {
            if elementsQty > counter {
                guard let imageName = model.peoplePhotos?[counter] else { return }
                imageView.image = UIImage(named: imageName)

                counter += 1
            } else {
                break
            }
        }
    }

    // MARK: - Configuration

    override func configureCell(with model: AlbumsItemModel) {
        super.configureCell(with: model)

        fillImages(with: model, images: [firstHumanImage, secondHumanImage, thirdHumanImage, fourthHumanImage])
    }
}

extension PeopleCollectionViewCell {
    enum Metric {
        static let rowRatio: CGFloat = 0.49
        static let rowHorizontalPaddings: CGFloat = 0
    }
}
