// ShimmerDetailViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Шиммер для экрана с детальным описанием фильма
final class ShimmerDetailViewCell: UITableViewCell {
    // MARK: - Visual Components

    private let photoFilmView = ShimmerView()
    private let filmTitleView = ShimmerView()
    private let watchButtonView = ShimmerView()
    private let descriptionView = ShimmerView()
    private let filmInfoView = ShimmerView()
    private let personsTitleView = ShimmerView()
    private let languageTitleView = ShimmerView()
    private let languageInfoView = ShimmerView()
    private let recommendTitleView = ShimmerView()
    private let recommendInfoView = ShimmerView()

    private lazy var personsCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 10
        layout.itemSize = .init(
            width: 60,
            height: 97
        )
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(
            ShimmerPersonCollectionCell.self,
            forCellWithReuseIdentifier: String(describing: ShimmerPersonCollectionCell.self)
        )
        collectionView.alwaysBounceHorizontal = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        return collectionView
    }()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }

    // MARK: - Private Methods

    private func configureUI() {
        backgroundColor = .clear
        configureHeader()
        configureWatchButton()
        configureInfo()
        configurePersons()
        configureLanguage()
        configureRecommendInfo()
    }

    private func configureHeader() {
        contentView.addSubview(photoFilmView)
        contentView.addSubview(filmTitleView)

        photoFilmView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        photoFilmView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        photoFilmView.widthAnchor.constraint(equalToConstant: 170).isActive = true
        photoFilmView.heightAnchor.constraint(equalToConstant: 200).isActive = true

        filmTitleView.centerYAnchor.constraint(equalTo: photoFilmView.centerYAnchor).isActive = true
        filmTitleView.leftAnchor.constraint(equalTo: photoFilmView.rightAnchor, constant: 16).isActive = true
        filmTitleView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        filmTitleView.heightAnchor.constraint(equalToConstant: 110).isActive = true
    }

    private func configureWatchButton() {
        contentView.addSubview(watchButtonView)

        watchButtonView.topAnchor.constraint(equalTo: photoFilmView.bottomAnchor, constant: 16).isActive = true
        watchButtonView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        watchButtonView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        watchButtonView.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }

    private func configureInfo() {
        contentView.addSubview(descriptionView)
        contentView.addSubview(filmInfoView)

        descriptionView.topAnchor.constraint(equalTo: watchButtonView.bottomAnchor, constant: 16).isActive = true
        descriptionView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        descriptionView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -44).isActive = true
        descriptionView.heightAnchor.constraint(equalToConstant: 100).isActive = true

        filmInfoView.topAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: 10).isActive = true
        filmInfoView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        filmInfoView.widthAnchor.constraint(equalToConstant: 202).isActive = true
        filmInfoView.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }

    private func configurePersons() {
        contentView.addSubview(personsTitleView)
        contentView.addSubview(personsCollectionView)

        personsTitleView.topAnchor.constraint(equalTo: filmInfoView.bottomAnchor, constant: 16).isActive = true
        personsTitleView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        personsTitleView.widthAnchor.constraint(equalToConstant: 202).isActive = true
        personsTitleView.heightAnchor.constraint(equalToConstant: 20).isActive = true

        personsCollectionView.topAnchor.constraint(equalTo: personsTitleView.bottomAnchor, constant: 10)
            .isActive = true
        personsCollectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        personsCollectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        personsCollectionView.heightAnchor.constraint(equalToConstant: 97).isActive = true
    }

    private func configureLanguage() {
        contentView.addSubview(languageTitleView)
        contentView.addSubview(languageInfoView)

        languageTitleView.topAnchor.constraint(equalTo: personsCollectionView.bottomAnchor, constant: 14)
            .isActive = true
        languageTitleView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        languageTitleView.widthAnchor.constraint(equalToConstant: 202).isActive = true
        languageTitleView.heightAnchor.constraint(equalToConstant: 20).isActive = true

        languageInfoView.topAnchor.constraint(equalTo: languageTitleView.bottomAnchor, constant: 4).isActive = true
        languageInfoView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        languageInfoView.widthAnchor.constraint(equalToConstant: 202).isActive = true
        languageInfoView.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }

    private func configureRecommendInfo() {
        contentView.addSubview(recommendTitleView)
        contentView.addSubview(recommendInfoView)

        recommendTitleView.topAnchor.constraint(equalTo: languageInfoView.bottomAnchor, constant: 8).isActive = true
        recommendTitleView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        recommendTitleView.widthAnchor.constraint(equalToConstant: 170).isActive = true
        recommendTitleView.heightAnchor.constraint(equalToConstant: 200).isActive = true

        recommendInfoView.topAnchor.constraint(equalTo: recommendTitleView.bottomAnchor, constant: 8).isActive = true
        recommendInfoView.leftAnchor.constraint(equalTo: recommendTitleView.leftAnchor).isActive = true
        recommendInfoView.widthAnchor.constraint(equalToConstant: 202).isActive = true
        recommendInfoView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        recommendInfoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}

// MARK: - ShimmerDetailViewCell + UICollectionViewDataSource

extension ShimmerDetailViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        6
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: ShimmerPersonCollectionCell.self),
            for: indexPath
        ) as? ShimmerPersonCollectionCell else { return UICollectionViewCell() }
        return cell
    }
}
