// DescriptionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с описанием фильма
final class DescriptionViewCell: UITableViewCell {
    // MARK: - Types

    private enum Constants {
        static let buttonText = "Смотреть"
        static let personsTitleText = "Актеры и съемочная группа"
        static let languageTitleText = "Язык"
        static let watchTitleText = "Смотрите также"
    }

    // MARK: - Visual Components

    private let descriptionLabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 5
        label.font = .inter(ofSize: 14)
        return label
    }()

    private let filmInfoLabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .appDarkGray
        label.font = .inter(ofSize: 14)
        return label
    }()

    private let languageInfoLabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .appDarkGray
        label.font = .inter(ofSize: 14)
        return label
    }()

    private lazy var personsCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0.1
        layout.minimumInteritemSpacing = 10
        layout.itemSize = .init(
            width: 60,
            height: 97
        )
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(
            PersonViewCell.self,
            forCellWithReuseIdentifier: String(describing: PersonViewCell.self)
        )
        collectionView.alwaysBounceHorizontal = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        return collectionView
    }()

    private lazy var personsTitleLabel = makeTitleLabelWithText(Constants.personsTitleText)
    private lazy var languageTitleLabel = makeTitleLabelWithText(Constants.languageTitleText)
    private lazy var watchTitleLabel = makeTitleLabelWithText(Constants.watchTitleText)

    // MARK: - Public Properties

    var updateTable: VoidHandler?

    // MARK: - Private Properties

    private var persons: [PersonDTO] = []

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }

    // MARK: - Public Methods

    func configure(film: FilmDetail) {
        persons = film.persons
        descriptionLabel.text = film.description
        var infoText = ""
        if let year = film.year {
            infoText += "\(year) /"
        }

        if let country = film.country {
            infoText += " \(country) /"
        }
        infoText += " \(film.type.rawValue)"

        filmInfoLabel.text = infoText
        languageInfoLabel.text = film.spokenLanguage
    }

    // MARK: - Private Methods

    private func configureUI() {
        backgroundColor = .clear
        configureDescription()
        configurePersonsUI()
        configureLanguageInfo()
        configureWatchInfo()
    }

    private func configureDescription() {
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(filmInfoLabel)

        descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -44).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: filmInfoLabel.topAnchor, constant: -10).isActive = true

        filmInfoLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10).isActive = true
        filmInfoLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        filmInfoLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        filmInfoLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }

    private func configurePersonsUI() {
        contentView.addSubview(personsTitleLabel)
        contentView.addSubview(personsCollectionView)

        personsTitleLabel.topAnchor.constraint(equalTo: filmInfoLabel.bottomAnchor, constant: 16).isActive = true
        personsTitleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        personsTitleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        personsTitleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true

        personsCollectionView.topAnchor.constraint(equalTo: personsTitleLabel.bottomAnchor, constant: 10)
            .isActive = true
        personsCollectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        personsCollectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        personsCollectionView.heightAnchor.constraint(equalToConstant: 97).isActive = true
    }

    private func configureLanguageInfo() {
        contentView.addSubview(languageTitleLabel)
        contentView.addSubview(languageInfoLabel)

        languageTitleLabel.topAnchor.constraint(equalTo: personsCollectionView.bottomAnchor, constant: 14)
            .isActive = true
        languageTitleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        languageTitleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        languageTitleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true

        languageInfoLabel.topAnchor.constraint(equalTo: languageTitleLabel.bottomAnchor, constant: 4).isActive = true
        languageInfoLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        languageInfoLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        languageInfoLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }

    private func configureWatchInfo() {
        contentView.addSubview(watchTitleLabel)

        watchTitleLabel.topAnchor.constraint(equalTo: languageInfoLabel.bottomAnchor, constant: 10).isActive = true
        watchTitleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        watchTitleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        watchTitleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        watchTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }

    private func makeTitleLabelWithText(_ text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.textColor = .white
        label.font = .interBold(ofSize: 14)
        return label
    }

    @objc private func openFullText(button: UIButton) {
        if button.isSelected {
            descriptionLabel.numberOfLines = 5
        } else {
            descriptionLabel.numberOfLines = 0
        }
        button.isSelected.toggle()
        updateTable?()
    }
}

// MARK: - DescriptionViewCell + UICollectionViewDataSource

extension DescriptionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        persons.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: PersonViewCell.self),
            for: indexPath
        ) as? PersonViewCell else { return UICollectionViewCell() }
        cell.configureCell(personName: persons[indexPath.item].name, personImageUrl: persons[indexPath.item].photo)
        return cell
    }
}
