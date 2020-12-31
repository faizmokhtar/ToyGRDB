//
//  AppDatabase.swift
//  ToyGRDB
//
//  Created by Faiz Mokhtar AD0502 on 31/12/2020.
//

import Foundation
import GRDB

struct AppDatabase {
    let dbWriter: DatabaseWriter
    
    init(_ dbWriter: DatabaseWriter) throws {
        self.dbWriter = dbWriter
        try migrator.migrate(dbWriter)
    }
    
    private var migrator: DatabaseMigrator {
        var migrator = DatabaseMigrator()
        
        #if DEBUG
        migrator.eraseDatabaseOnSchemaChange = true
        #endif
        
        migrator.registerMigration("createTask") { db in
            try db.create(table: "task") { t in
                t.autoIncrementedPrimaryKey("id")
                t.column("title", .text).notNull()
                    .collate(.localizedCaseInsensitiveCompare)
                t.column("isComplete", .boolean).notNull()
                    .defaults(to: false)
                t.column("updatedAt", .datetime)
                t.column("createdAt", .datetime)
            }
        }
        
        return migrator
    }
}
