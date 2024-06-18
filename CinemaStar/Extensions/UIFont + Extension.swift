// UIFont + Extension.swift

import UIKit

/// Расширение для использования новых шрифтов
extension UIFont {
    /// Шрифт Inter
    /// - Parameter ofSize: Размер необходимого шрифта
    /// - Returns: Шрифт Inter
    static func inter(ofSize: CGFloat) -> UIFont {
        UIFont(name: "Inter-Medium", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize)
    }

    /// Шрифт InterBold
    /// - Parameter ofSize: Размер необходимого шрифта
    /// - Returns: Шрифт InterBold
    static func interBold(ofSize: CGFloat) -> UIFont {
        UIFont(name: "Inter-Bold", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize)
    }

    /// Словарь для шрифтов
    static var fontStoreMap: [String: UIFont] = [:]
    /// Функция проверки цвета в словаре
    /// - Parameter name: Название необходимого шрифта
    /// - Parameter size: Размер необходимого шрифта
    /// - Returns: Шрифт
    static func font(name: String, size: CGFloat) -> UIFont? {
        let keyFont = "\(name)\(size)"
        if let font = fontStoreMap[keyFont] {
            return font
        }
        let newFont = UIFont(name: name, size: size)
        fontStoreMap[keyFont] = newFont
        return newFont
    }
}
