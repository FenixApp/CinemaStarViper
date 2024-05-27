// ShimmerView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Представление шиммера
class ShimmerView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        startShimmerAnimate()
    }

    override func willRemoveSubview(_ subview: UIView) {
        super.willRemoveSubview(subview)
        stopShimmerAnimate()
    }

    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.masksToBounds = true
        layer.cornerRadius = 8
    }
}
