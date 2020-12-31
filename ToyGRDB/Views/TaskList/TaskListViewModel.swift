//
//  TaskListViewModel.swift
//  ToyGRDB
//
//  Created by Faiz Mokhtar AD0502 on 31/12/2020.
//

import Foundation
import Combine

class TaskListViewModel: ObservableObject {

    @Published var tasks: [Task] = []

    private let repository: TaskRepository
    private var cancellables: Set<AnyCancellable> = []

    init(repository: TaskRepository = TaskRepository()) {
        self.repository = repository
    }
    
    var title: String {
        tasks.count == 0 ? "Tasks" : "\(tasks.count) Tasks"
    }
    
    func fetchTasks() {
        repository.fetchAllTasks()
            .sink(receiveCompletion: { completion in
                print(completion)
            },
            receiveValue: { [weak self] tasks in
                self?.tasks = tasks
            })
            .store(in: &cancellables)
    }
    
    func complete(task: Task) {
        var task = task
        task.isComplete.toggle()
        do {
            try repository.save(task: &task)
        } catch let error {
            print("error updating isCompleted state: ", error.localizedDescription)
        }
    }
}
