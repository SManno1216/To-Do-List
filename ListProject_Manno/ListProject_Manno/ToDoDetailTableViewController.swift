//
//  ToDoDetailTableViewController.swift
//  ListProject_Manno
//
//  Created by Steven  Manno on 11/20/21.
//

import Foundation
import UIKit

class ToDoDetailTableViewController: UITableViewController {
    
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var dueDatePickerView: UIDatePicker!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var isDatePickerHidden = true
    let dateLabelIndexPath = IndexPath(row: 0, section: 1)
    let datePickerIndexPath = IndexPath(row: 1, section: 1)
    let notesIndexPath = IndexPath(row: 0, section: 2)
    
    var todo: ToDo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let todo = todo {
            navigationItem.title = "To-Do"
            titleTextField.text = todo.title
            isCompleteButton.isSelected = todo.isComplete
            dueDatePickerView.date = todo.dueDate
            notesTextView.text = todo.notes
        }else{
            dueDatePickerView.date = Date().addingTimeInterval(24*60*60)
        }

        updateDueDateLabel(date: dueDatePickerView.date)
        updateSavedButtonState()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "saveUnwind" else {return}
        
        let title = titleTextField.text!
        let isComplete = isCompleteButton.isSelected
        let dueDate = dueDatePickerView.date
        let notes = notesTextView.text
        
        todo = ToDo(title: title, isComplete: isComplete, dueDate: dueDate, notes: notes)
    }
    
    func updateDueDateLabel(date: Date) {
        dueDateLabel.text = ToDo.dueDateFormatter.string(from: date)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath {
        case datePickerIndexPath where isDatePickerHidden == true:
            return 0.01
        case notesIndexPath:
            return 200
        default: return UITableView.automaticDimension
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath == dateLabelIndexPath {
            isDatePickerHidden.toggle()
            dueDateLabel.textColor = .black
            updateDueDateLabel(date: dueDatePickerView.date)
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        updateDueDateLabel(date: sender.date)
    }
    
    func updateSavedButtonState() {
        let shouldEnableSaveButton = titleTextField.text?.isEmpty == false
        saveButton.isEnabled = shouldEnableSaveButton
    }
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSavedButtonState()
    }
    
    @IBAction func returnPressed(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func isCompleteButtonTapped(_ sender: UIButton) {
        isCompleteButton.isSelected.toggle()
    }
}
