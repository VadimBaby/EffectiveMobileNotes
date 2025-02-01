//
//  TodosPresenter.swift
//  EffectiveMobileNotes
//
//  Created by Вадим Мартыненко on 28.01.2025.
//

import UIKit

protocol TodosPresenterOutput: AnyObject {
    
}

protocol TodosPresenterInput: AnyObject {
    var output: TodosPresenterOutput? { get set }
}

final class TodosPresenter: UIViewController, TodosPresenterInput {
    weak var output: TodosPresenterOutput?
    
    private let interactor: TodosInteractorInput
    private let mainView: UIView & TodosViewInput
    
    init(
        interactor: TodosInteractorInput,
        createTodosViewClosure: @escaping () -> UIView & TodosViewInput
    ) {
        self.interactor = interactor
        self.mainView = createTodosViewClosure()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = Strings.Todos.title
        navigationController?.navigationBar.prefersLargeTitles = true
        viewLoaded()
    }
    
    override func loadView() {
        mainView.output = self
        view = mainView
    }
}

extension TodosPresenter: TodosViewOutput {
    func viewLoaded() {
        interactor.fetchTodos()
    }
}

extension TodosPresenter: TodosInteractorOutput {
    func didFetch(todos: [TODO]) {
        mainView.display(todos: todos)
    }
}
