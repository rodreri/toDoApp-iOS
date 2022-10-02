//
//  TaskDetailViewController.swift
//  ToDo
//
//  Created by Rafael González on 17/09/22.
//

import UIKit

class TaskDetailViewController: UITableViewController {

    @IBOutlet var taskNotes: UITextView!
    @IBOutlet var taskDate: UIDatePicker!
    @IBOutlet var taskTitle: UITextField!
    @IBOutlet var taskSaveButton: UIBarButtonItem!
    @IBOutlet var taskCancelButton: UIBarButtonItem!
    var toDoDetailTask : Task?
    let context = (UIApplication.shared.delegate! as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if toDoDetailTask != nil {
            taskTitle.text = toDoDetailTask?.title
            taskDate.date = (toDoDetailTask?.date)!
            taskNotes.text = toDoDetailTask?.notes
        }else{
            toDoDetailTask = Task(context: self.context)
            toDoDetailTask!.id_task = UUID()
            taskTitle.text = ""
        }
        setupTextFields()
        
    }
    
    @IBAction func taskCancelButtonPressed(_ sender: UIBarButtonItem) {
        let isModal = presentingViewController is UINavigationController

        if isModal  {
            self.dismiss(animated: true)
        }
        else{
            navigationController?.popViewController(animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! ToDoListViewController
        toDoDetailTask?.notes = taskNotes.text
        toDoDetailTask?.title = taskTitle.text
        toDoDetailTask?.date = taskDate.date
            if ((toDoDetailTask?.id_task?.uuidString.isEmpty) != nil) {
                toDoDetailTask?.id_task = UUID()
            }
        destination.currentTask = toDoDetailTask
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        var perform = false
        if validateText(text: taskTitle.text!) {
            perform = true
        }
        else{
            userMessage(alertTitle: "Atención", message: "Escribe un título para la actividad", actionTitle: "Ok", vc: self)
        }
        return perform
    }
    
    //Este Método agrega un botón al teclado para mostrar el botón
    // "Listo" para realizar el "dismiss" del teclado para que
    // no se mantenga en pantalla, la llamamos en viewDidLoad
    func setupTextFields() {
        let toolbar = UIToolbar()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Listo", style: .done, target: self, action: #selector(doneButtonTapped) )
        
        toolbar.setItems([flexSpace, doneButton], animated: true)
        toolbar.sizeToFit()
        
        taskTitle.inputAccessoryView = toolbar
        taskNotes.inputAccessoryView = toolbar
    }
    
    @objc func doneButtonTapped() {
        view.endEditing(true)
    }
    
}
