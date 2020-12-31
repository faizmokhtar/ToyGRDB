//
//  Task.swift
//  ToyGRDB
//
//  Created by Faiz Mokhtar AD0502 on 31/12/2020.
//

import Foundation
import GRDB

struct Task: Identifiable {
    var id: Int64?
    var title: String
    var isComplete: Bool
    var createdAt: Date
    var updatedAt: Date?
}

extension Task: Codable, FetchableRecord, MutablePersistableRecord {
    
    fileprivate enum Columns {
        static let isComplete = Column(CodingKeys.isComplete)
    }

    mutating func didInsert(with rowID: Int64, for column: String?) {
        id = rowID
    }
}

extension DerivableRequest where RowDecoder == Task {
    
    func orderedByIsComplete() -> Self {
        order(Task.Columns.isComplete.desc)
    }

}
