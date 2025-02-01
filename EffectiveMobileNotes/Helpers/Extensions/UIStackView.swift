//
//  UIStackView.swift
//  EffectiveMobileNotes
//
//  Created by Вадим Мартыненко on 01.02.2025.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        for view in views {
            addArrangedSubview(view)
        }
    }
}
