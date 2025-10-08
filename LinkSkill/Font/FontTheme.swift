//
//  FontTheme.swift
//  LinkSkill
//
//  Created by Rohit Singh Dhakad  [C] on 03/10/25.
//

import Foundation
import UIKit

enum AppFontStyle {
    case regular(size: CGFloat)
    case bold(size: CGFloat)
    case italic(size: CGFloat)
    case custom(weight: UIFont.Weight, size: CGFloat)
}

extension UIFont {
    static func appFont(_ style: AppFontStyle) -> UIFont {
        switch style {
        case .regular(let size):
            return UIFont(name: "ABeeZee-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
            
        case .italic(let size):
            return UIFont(name: "ABeeZee-Italic", size: size) ?? UIFont.italicSystemFont(ofSize: size)
            
        case .bold(let size):
            if let baseFont = UIFont(name: "ABeeZee-Regular", size: size),
               let descriptor = baseFont.fontDescriptor.withSymbolicTraits(.traitBold) {
                return UIFont(descriptor: descriptor, size: size)
            }
            return UIFont.systemFont(ofSize: size, weight: .bold)

        case .custom(let weight, let size):
            // fallback with system weight
            return UIFont.systemFont(ofSize: size, weight: weight)
        }
    }
}

// MARK: - UILabel
extension UILabel {
    func applyStyle(_ style: AppFontStyle, color: UIColor? = nil, alignment: NSTextAlignment? = nil) {
        self.font = UIFont.appFont(style)
        if let color = color { self.textColor = color }
        if let alignment = alignment { self.textAlignment = alignment }
    }
}

// MARK: - UIButton
extension UIButton {
    func applyStyle(_ style: AppFontStyle, color: UIColor? = nil, alignment: NSTextAlignment? = nil) {
        self.titleLabel?.font = UIFont.appFont(style)
        if let color = color { self.setTitleColor(color, for: .normal) }
        if let alignment = alignment { self.titleLabel?.textAlignment = alignment }
    }
}

// MARK: - UITextField
extension UITextField {
    func applyStyle(_ style: AppFontStyle, color: UIColor? = nil, alignment: NSTextAlignment? = nil) {
        self.font = UIFont.appFont(style)
        if let color = color { self.textColor = color }
        if let alignment = alignment { self.textAlignment = alignment }
    }
}

// MARK: - UITextView
extension UITextView {
    func applyStyle(_ style: AppFontStyle, color: UIColor? = nil, alignment: NSTextAlignment? = nil) {
        self.font = UIFont.appFont(style)
        if let color = color { self.textColor = color }
        if let alignment = alignment { self.textAlignment = alignment }
    }
}


struct AppFonts {
    static let title      = AppFontStyle.bold(size: 20)
    static let title_regular      = AppFontStyle.regular(size: 18)
    static let subtitle   = AppFontStyle.regular(size: 14)
    static let body       = AppFontStyle.italic(size: 12)
    static let price12      = AppFontStyle.bold(size: 12)
    static let price18      = AppFontStyle.bold(size: 18)
}
