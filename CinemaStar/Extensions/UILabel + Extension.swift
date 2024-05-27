// UILabel + Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Расширение для текста
extension UILabel {
    func countLabelLines() -> Int {
        layoutIfNeeded()
        if let myText = text as? NSString {
            let attributes = [NSAttributedString.Key.font: font]

            let labelSize = myText.boundingRect(
                with: CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude),
                options: NSStringDrawingOptions.usesLineFragmentOrigin,
                attributes: attributes as [NSAttributedString.Key: Any],
                context: nil
            )
            let lines = Int(ceil(CGFloat(labelSize.height) / font.lineHeight))
            return myText.contains("\n") && lines == 1 ? lines + 1 : lines
        } else {
            return 0
        }
    }

    var isTruncated: Bool {
        guard numberOfLines > 0 else { return false }
        return countLabelLines() > numberOfLines
    }
}
