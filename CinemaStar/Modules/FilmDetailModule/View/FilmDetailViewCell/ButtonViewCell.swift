// ButtonViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с кнопкой "смотреть"
final class ButtonViewCell: UITableViewCell {
    // MARK: - Types

    private enum Constants {
        static let buttonText = "Смотреть"
    }

    // MARK: - Visual Components

    private lazy var watchButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(watchPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Constants.buttonText, for: .normal)
        button.backgroundColor = .appDarkGreen
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .inter(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        return button
    }()

    // MARK: - Public Properties

    var watchButtonPressed: VoidHandler?

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
        contentView.addSubview(watchButton)

        watchButton.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        watchButton.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        watchButton.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        watchButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        watchButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }

    @objc private func watchPressed() {
        watchButtonPressed?()
    }
}
