// PersonViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка для коллекции с актерами фильма
final class PersonViewCell: UICollectionViewCell {
    // MARK: - Visual Components

    private let personImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let nameLabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = .inter(ofSize: 8)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Private Properties

    private var imageRequest: ImageRequest?

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(frame: .zero)
        configureUI()
    }

    // MARK: - Public Methods

    func configureCell(personName: String?, personImageUrl: URL?) {
        nameLabel.text = personName
        if let url = personImageUrl {
            imageRequest = ImageRequest(url: url)
            imageRequest?.execute(withCompletion: { [weak self] image in
                self?.personImageView.image = image
            })
        }
    }

    // MARK: - Private Methods

    private func configureUI() {
        contentView.addSubview(personImageView)
        contentView.addSubview(nameLabel)
        setupConstraints()
    }

    private func setupConstraints() {
        personImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        personImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 11).isActive = true
        personImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -11).isActive = true
        personImageView.widthAnchor.constraint(equalToConstant: 46).isActive = true

        nameLabel.topAnchor.constraint(equalTo: personImageView.bottomAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: personImageView.leftAnchor).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: personImageView.rightAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}
