//
//  TodosView.swift
//  EffectiveMobileNotes
//
//  Created by Вадим Мартыненко on 28.01.2025.
//

import UIKit
import SnapKit

protocol TodosViewOutput: AnyObject {
    
}

protocol TodosViewInput: AnyObject {
    var output: TodosViewOutput? { get set }
    
    func display(todos: [TODO])
}

final class TodosView: UIView, TodosViewInput {
    weak var output: TodosViewOutput?
    
    private var todos: [TODO] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private lazy var tableView = UITableView() &> {
        $0.dataSource = self
        $0.delegate = self
        $0.register(TODOCell.self, forCellReuseIdentifier: TODOCell.reuseID)
        $0.isHidden = true
    }
    
    private lazy var progressView = UIActivityIndicatorView(style: .medium) &> {
        $0.startAnimating()
    }
    
    init() {
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func display(todos: [TODO]) {
        self.todos = todos
        hideProgress()
        tableView.isHidden = false
    }
}

// MARK: - Private Methods

private extension TodosView {
    func setupViews() {
        backgroundColor = .systemBackground
        addSubviews(tableView, progressView)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
        
        progressView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(50)
        }
    }
    
    func hideProgress() {
        progressView.stopAnimating()
        progressView.isHidden = true
    }
}

// MARK: - UITableViewDataSource

extension TodosView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TODOCell.reuseID, for: indexPath) as? TODOCell else { fatalError() }
        
        let todo = todos[indexPath.row]
        cell.configure(with: todo)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? TODOCell else { fatalError() }
        cell.toggleChecked()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension TodosView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
}

#Preview {
    TodosView()
}
