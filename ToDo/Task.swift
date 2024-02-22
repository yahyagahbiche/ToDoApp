//
//  Task.swift
//  ToDo
//
//  Created by Yahya Gahbiche on 2/12/24.
//

import Foundation
import RealmSwift


class Task: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title = ""
    @Persisted var completed = false
    
}
