//
//  TODOCell.swift
//  EffectiveMobileNotes
//
//  Created by Вадим Мартыненко on 28.01.2025.
//

import UIKit
import SnapKit

final class TODOCell: UITableViewCell {
    static let reuseID = "\(TODOCell.self)"
    
    private lazy var titleLabel = UILabel() &> {
        $0.textColor = .label
        $0.font = .preferredFont(forTextStyle: .title1)
    }
    
    private lazy var descriptionLabel = UILabel() &> {
        $0.textColor = .label
        $0.font = .preferredFont(forTextStyle: .body)
        $0.numberOfLines = 2
        $0.lineBreakMode = .byWordWrapping
    }
    
    private lazy var dateLabel = UILabel() &> {
        $0.textColor = .secondaryLabel
        $0.font = .preferredFont(forTextStyle: .headline)
    }
    
    private lazy var verticalStack = UIStackView() &> {
        $0.axis = .vertical
        $0.spacing = 2
        $0.distribution = .fillProportionally
        $0.isLayoutMarginsRelativeArrangement = true
        $0.layoutMargins = .init(top: 0, left: 0, bottom: 10, right: 0)
    }
    
    private lazy var checkmarkView = CheckmarkView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstaints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubviews(verticalStack, checkmarkView)
        verticalStack.addArrangedSubviews(titleLabel, descriptionLabel, dateLabel)
        
        let interaction = UIContextMenuInteraction(delegate: self)
        addInteraction(interaction)
    }
    
    private func setupConstaints() {
        checkmarkView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(10)
            make.size.equalTo(25)
        }
        
        verticalStack.snp.makeConstraints { make in
            make.leading.equalTo(checkmarkView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(10)
            make.verticalEdges.equalToSuperview()
        }
    }
}

extension TODOCell {
    func configure(with todo: TODO) {
        titleLabel.text = todo.title
        descriptionLabel.text = todo.todo
        dateLabel.text = DateFormatters.dayMonthYearFormatter.string(from: todo.createdAt)
        checkmarkView.isChecked = todo.completed
    }
    
    func toggleChecked() {
        checkmarkView.isChecked.toggle()
    }
}

extension TODOCell: UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        let menuItems = [
            UIAction(title: "Редактировать", image: UIImage(systemName: "square.and.pencil"), handler: { action in
                
            }),
            UIAction(title: "Поделиться", image: UIImage(systemName: "square.and.arrow.up"), handler: { action in
                
            }),
            UIAction(title: "Удалить", image: UIImage(systemName: "trash"), attributes: .destructive, handler: { action in
            }),
        ]
        
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            return UIMenu(title: "", children: menuItems)
        }
    }
}
