// FilmsViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка для фильма
final class FilmsViewCell: UICollectionViewCell {
    // MARK: - Constants

    private enum Constants {
        static let star = "⭐️ "
    }

    // MARK: - Visual Components

    private let filmImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8
        return imageView
    }()

    private let filmTitleLabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.text = "Земля\n" + Constants.star + "8,3"
        label.font = .inter(ofSize: 16)
        label.textAlignment = .left
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Public Properties

    var filmId: Int?

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

    func configureCell(info: Film) {
        imageRequest = ImageRequest(url: info.posterURL)
        imageRequest?.execute(withCompletion: { [weak self] image in
            self?.filmImageView.image = image
        })
        filmId = info.id
        filmTitleLabel.text = info.name
        filmTitleLabel.text = "\(info.name)\n\(Constants.star) \(info.rating)"
    }

    // MARK: - Private Methods

    private func configureUI() {
        contentView.addSubview(filmImageView)
        contentView.addSubview(filmTitleLabel)
        setupConstraints()
    }

    private func setupConstraints() {
        filmImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        filmImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        filmImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        filmImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true

        filmTitleLabel.topAnchor.constraint(equalTo: filmImageView.bottomAnchor, constant: 8).isActive = true
        filmTitleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        filmTitleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        filmTitleLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
