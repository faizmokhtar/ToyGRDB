//
//  AddTaskViewModel.swift
//  ToyGRDB
//
//  Created by Faiz Mokhtar AD0502 on 31/12/2020.
//

import Foundation

class AddTaskViewModel {
    
    private let repository: TaskRepository

    init(repository: TaskRepository = TaskRepository()) {
        self.repository = repository
    }
    
    func save(title: String, isCompleted: Bool) {
        var task = Task(id: nil, title: title, isComplete: isCompleted, createdAt: Date(), updatedAt: nil)
        do {
            try repository.save(task: &task)
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
