//
//  ToDoListViewController.swift
//  ToDo
//
//  Created by Rafael González on 17/09/22.
//

import UIKit
import CoreData

class ToDoListViewController: UIViewController {
    @IBOutlet var addTaskButton: UIBarButtonItem!
    @IBOutlet var toDoListTableView: UITableView!
    @IBOutlet var editButton: UIBarButtonItem!
    
    var tasks : [Task] = []
    var currentTask : Task?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        toDoListTableView.delegate = self
        toDoListTableView.dataSource = self
        
        let dataManager = TaskDataManager(context: context)
        tasks = dataManager.fetch()
    }
}

extension ToDoListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let toDoTaskCell = tableView.dequeueReusableCell(withIdentifier: "ToDoTaskCell", for: indexPath) as! ToDoTaskTableViewCell
        toDoTaskCell.taskTitleLabel.text = tasks[indexPath.row].title
        toDoTaskCell.taskTitle = tasks[indexPath.row].title
        toDoTaskCell.taskDate = tasks[indexPath.row].date
        toDoTaskCell.tasknotes = tasks[indexPath.row].notes
        toDoTaskCell.taskUUID = tasks[indexPath.row].id_task?.description
        return toDoTaskCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "taskDetailSegue", sender: Self.self)
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "taskDetailSegue" {
            let destination = segue.destination as! TaskDetailViewController
            let selectedIndexPath = toDoListTableView.indexPathForSelectedRow!
            destination.toDoDetailTask = tasks[selectedIndexPath.row]
        }
    }
    
    @IBAction  func unWindFromDetail(segue: UIStoryboardSegue ){
        let source = segue.source as! TaskDetailViewController
        currentTask = source.toDoDetailTask
        do{
            try context.save()
        }
        catch{
            print("error al salvar",error)
        }
        
        let dataManager = TaskDataManager(context: context)
        tasks = dataManager.fetch()
        self.toDoListTableView.reloadData()
    }
    
    @IBAction func editTaskButton(_ sender: UIBarButtonItem) {
        if toDoListTableView.isEditing{
            toDoListTableView.setEditing(false, animated: true)
            sender.title = "Editar"
            addTaskButton.isEnabled = true
        }else{
            toDoListTableView.setEditing(true, animated: true)
            sender.title = "Editar"
            addTaskButton.isEnabled = true
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //si el renglon seleccinado esta en modo de eliminacion
        if editingStyle == .delete{
            //guardamo la tarea seleccionada en la variable "currentTask"
            currentTask = self.tasks[indexPath.row] //eliminamos la tarea
            self.context.delete(currentTask!)
            //actualizamos el contexto utilizando el método save
            do{
                try self.context.save()
            } catch{
                print("Error: ", error) }
            
            let dataManager = TaskDataManager(context: context)
            tasks = dataManager.fetch()
            self.toDoListTableView.reloadData()
        }
    }
}
