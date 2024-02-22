//
//  TaskRow.swift
//  ToDo
//
//  Created by Yahya Gahbiche on 2/10/24.
//

import SwiftUI

struct TaskRow: View {
    
    var task: String
    var completed: Bool
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: completed ?
                  "checkmark.circle" : "circle")
            
            Text(task)
        }
        
        
    }
    
}

struct TaskRow_Previews: PreviewProvider {
    static var previews: some View {
        TaskRow(task: "Do laundry", completed: true)
    }
}
