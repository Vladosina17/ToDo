//
//  CreateNoteViewController.swift
//  ToDo
//
//  Created by Влад Барченков on 03.11.2020.
//

import UIKit
import CoreData

class CreateNoteViewController: UIViewController {
    
    var task: Task?
    
    let headlineTextField = HeadlineTextField(plaseholder: "Заголовок")
    let mainTextView = MainTextView()
    
    var containerView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let task = task {
            headlineTextField.text = task.headline
            mainTextView.text = task.mainText
        }
        
        setupConstraint()
        setupNavigationBar()
        targetForText()
        
        headlineTextField.delegate = self
        mainTextView.delegate = self
        
        view.backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9764705882, alpha: 1)
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingFromParent {
            saveTask()
        }
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Готово", style: .plain, target: self, action: #selector(tapDoneButton))
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.3450980392, green: 0.3450980392, blue: 0.9137254902, alpha: 1)
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = #colorLiteral(red: 0.2470588235, green: 0.3333333333, blue: 0.9137254902, alpha: 1)
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    @objc private func tapDoneButton() {
        mainTextView.resignFirstResponder()
    }
    
    private func targetForText() {
        navigationItem.rightBarButtonItem?.isEnabled = false
        headlineTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
    }
    
    @objc private func editingChanged() {
        guard let text = headlineTextField.text, !text.isEmpty,
              let mainText = mainTextView.text, !mainText.isEmpty else {
            navigationItem.rightBarButtonItem?.isEnabled = false
            return
        }
        navigationItem.rightBarButtonItem?.isEnabled = true
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        self.containerView.endEditing(true)
    }
    
    private func saveTask() {
        guard !headlineTextField.text!.isEmpty && !mainTextView.text!.isEmpty else { return }
        
        if task == nil { task = Task() }
        
        if let task = task {
            task.headline = headlineTextField.text
            task.mainText = mainTextView.text
            CoreDataStack.shared.saveContext()
        }
    }
   
    //MARK: - setup Constraints
    
    private func setupConstraint() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        headlineTextField.translatesAutoresizingMaskIntoConstraints = false
        mainTextView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(containerView)
        containerView.addSubview(headlineTextField)
        containerView.addSubview(mainTextView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            headlineTextField.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            headlineTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            headlineTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            headlineTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            mainTextView.topAnchor.constraint(equalTo: headlineTextField.bottomAnchor, constant: 20),
            mainTextView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            mainTextView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            mainTextView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
        ])
    }
}

// MARK: - UITextFieldDelegate
extension CreateNoteViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

//MARK: -  UITextViewDelegate
extension CreateNoteViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        editingChanged()
    }
}
