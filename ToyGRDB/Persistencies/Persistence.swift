//
//  Persistence.swift
//  ToyGRDB
//
//  Created by Faiz Mokhtar AD0502 on 31/12/2020.
//

import Foundation
import GRDB

extension AppDatabase {
    static let shared = makeShared()
    
    private static func makeShared() -> AppDatabase {
        do {
            let url: URL = try FileManager.default
                .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent("db.sqlite")
            print(url.absoluteString)
            let dbPool = try DatabasePool(path: url.path)
            let appDatabase = try AppDatabase(dbPool)
            return appDatabase
        } catch {
            fatalError("error creating sqlite db: \(error.localizedDescription)")
        }
    }
}
