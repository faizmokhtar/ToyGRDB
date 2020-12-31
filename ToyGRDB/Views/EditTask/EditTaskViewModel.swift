//
//  EditTaskViewModel.swift
//  ToyGRDB
//
//  Created by Faiz Mokhtar AD0502 on 31/12/2020.
//

import Foundation
import Combine

class EditTaskViewModel: ObservableObject {
    private let repository: TaskRepository

    @Published var title: String
    @Published var isCompleted: Bool

    var task: Task

    init(repository: TaskRepository = TaskRepository(), task: Task) {
        self.repository = repository
        self.task = task
        self.title = task.title
        self.isCompleted = task.isComplete
    }
    
    func save(title: String, isCompleted: Bool) {
        task.title = title
        task.isComplete = isCompleted
        task.updatedAt = Date()
        do {
            try repository.save(task: &task)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func delete() {
        do {
            try repository.delete(task: &task)
        } catch let error {
            print("error deleting task: \(error.localizedDescription)")
        }
    }
}
