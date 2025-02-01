//
//  UIView.swift
//  EffectiveMobileNotes
//
//  Created by Вадим Мартыненко on 28.01.2025.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
