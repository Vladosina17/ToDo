//
//  NotesViewController.swift
//  ToDo
//
//  Created by Влад Барченков on 02.11.2020.
//

import UIKit
import CoreData

class NotesViewController: UIViewController {
    
    var tableView: UITableView!
    var fetchedResultsController = CoreDataStack.shared.fetchedResultsController(entityName: "Task", keyForSort: "headline")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        navigationItem.largeTitleDisplayMode = .always
        setupTableView()
        setupNavigationBar()
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: view.bounds)
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        
        tableView.register(NoteCell.self, forCellReuseIdentifier: NoteCell.reuseId)
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.title = "Задачи"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(tapAddButton))
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.3450980392, green: 0.3450980392, blue: 0.9137254902, alpha: 1) 
    }
    
    @objc private func tapAddButton() {
        let createNoteVC = CreateNoteViewController()
        createNoteVC.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(createNoteVC, animated: true)
    }
}


//MARK: -  UITableViewDataSource, UITableViewDelegate

extension NotesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultsController.sections {
            return sections[section].numberOfObjects
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let task = fetchedResultsController.object(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: NoteCell.reuseId, for: indexPath) as! NoteCell
        
        cell.headlineLabel.text = task.headline
        cell.mainTextLabel.text = task.mainText
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = fetchedResultsController.object(at: indexPath)
        let dest = CreateNoteViewController()
        dest.task = task
        navigationController?.pushViewController(dest, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = fetchedResultsController.object(at: indexPath)
            CoreDataStack.shared.persistentContainer.viewContext.delete(task)
            CoreDataStack.shared.saveContext()
        }
    }
}


//MARK: -  NSFetchedResultsControllerDelegate

extension NotesViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        case .move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        case .update:
            if let indexPath = indexPath {
                let task = fetchedResultsController.object(at: indexPath)
                let cell = tableView.cellForRow(at: indexPath) as? NoteCell
                cell?.headlineLabel.text = task.headline
                cell?.mainTextLabel.text = task.mainText
            }
        @unknown default:
            fatalError()
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}
