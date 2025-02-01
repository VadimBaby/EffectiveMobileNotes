//
//  CheckmarkButton.swift
//  EffectiveMobileNotes
//
//  Created by Вадим Мартыненко on 30.01.2025.
//

import UIKit
import SnapKit

final class CheckmarkView: UIView {
    private let checkmark = UIImageView(image: UIImage(systemName: "checkmark")) &> {
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .yellow
        $0.isHidden = true
    }
    
    var isChecked: Bool = false {
        didSet {
            if isChecked {
                checkmark.isHidden = false
                layer.borderColor = UIColor.yellow.cgColor
            } else {
                checkmark.isHidden = true
                layer.borderColor = UIColor.systemGray.cgColor
            }
        }
    }
    
    init() {
        super.init(frame: .zero)
        setupViews()
        setupConstaints()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstaints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.width / 2
    }
}

private extension CheckmarkView {
    func setupViews() {
        addSubview(checkmark)
        
        self.layer.masksToBounds = true
        
        self.layer.borderColor = UIColor.systemGray.cgColor
        self.layer.borderWidth = 1
    }
    
    func setupConstaints() {
        checkmark.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalToSuperview().inset(3)
        }
    }
}
