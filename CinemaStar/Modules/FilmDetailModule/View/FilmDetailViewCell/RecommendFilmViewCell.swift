// RecommendFilmViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка для коллекции с рекомендациями
final class RecommendFilmViewCell: UICollectionViewCell {
    // MARK: - Visual Components

    private let filmImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let nameLabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .inter(ofSize: 16)
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

    func configureCell(recommendFilm: SimilarMoviesDTO) {
        imageRequest = ImageRequest(url: recommendFilm.poster.url)
        imageRequest?.execute(withCompletion: { [weak self] image in
            self?.filmImageView.image = image
        })
        nameLabel.text = recommendFilm.name
    }

    // MARK: - Private Methods

    private func configureUI() {
        contentView.addSubview(filmImageView)
        contentView.addSubview(nameLabel)
        setupConstraints()
    }

    private func setupConstraints() {
        filmImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        filmImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        filmImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -11).isActive = true
        filmImageView.widthAnchor.constraint(equalToConstant: 170).isActive = true
        filmImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true

        nameLabel.topAnchor.constraint(equalTo: filmImageView.bottomAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: filmImageView.leftAnchor).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: filmImageView.rightAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}
