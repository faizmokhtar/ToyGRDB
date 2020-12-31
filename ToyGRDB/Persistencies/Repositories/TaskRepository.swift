//
//  TaskRepository.swift
//  ToyGRDB
//
//  Created by Faiz Mokhtar AD0502 on 31/12/2020.
//

import Foundation
import Combine
import GRDB

class TaskRepository {
    let database: AppDatabase
    
    init(database: AppDatabase = AppDatabase.shared) {
        self.database = database
    }
    
    func fetchAllTasks() -> AnyPublisher<[Task], Error> {
        ValueObservation
            .tracking(Task.all().orderedByIsComplete().fetchAll)
            .publisher(in: database.dbWriter)
            .eraseToAnyPublisher()
    }
    
    func save(task: inout Task) throws {
        try database.dbWriter.write { db in
            try task.save(db)
        }
    }
    
    func delete(task: inout Task) throws {
        try database.dbWriter.write({ db in
            _ = try task.delete(db)
        })
    }
}
