// UIView + Extension.swift

import UIKit

/// Расширение для шиммера
extension UIView {
    func startShimmerAnimate() {
        stopShimmerAnimate()
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.startPoint = .init(x: 0, y: 0.5)
        gradient.endPoint = .init(x: 1, y: 0.5)
        gradient.colors = [
            UIColor.appLightGray.cgColor,
            UIColor.appLightBrown.cgColor,
            UIColor.clear.cgColor
        ]
        gradient.locations = [0, 0.5, 1]
        let basicAnimation = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.locations))
        basicAnimation.fromValue = [-1.0, -0.5, 0]
        basicAnimation.toValue = [1, 1.5, 2]
        basicAnimation.duration = CFTimeInterval(1)
        basicAnimation.beginTime = 0.0
        basicAnimation.repeatCount = .infinity

        layer.masksToBounds = true
        layer.addSublayer(gradient)
        gradient.add(basicAnimation, forKey: "shimmerKey")
    }

    func stopShimmerAnimate() {
        layer.sublayers?.forEach { layer in
            layer.removeFromSuperlayer()
        }
    }

    func setupAppGradientBackground() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.appBrown.cgColor, UIColor.appGreen.cgColor]
        gradient.frame = bounds
        layer.insertSublayer(gradient, at: 0)
    }
}
