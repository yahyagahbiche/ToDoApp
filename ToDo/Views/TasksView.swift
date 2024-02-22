import SwiftUI

struct TasksView: View {
    @EnvironmentObject var realmManager: RealmManager
   
    var body: some View {
        VStack {
            Text("My tasks")
                .font(.title3).bold()
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            List {
                ForEach(realmManager.tasks, id: \.id) { task in
                    if !task.isInvalidated {
                        TaskRow(task: task.title, completed: task.completed)
                            .onTapGesture {
                                realmManager.updateTask(id: task.id, completed: !task.completed)
                            }
                    }
                }
                .onDelete { indexSet in
                    indexSet.forEach { index in
                        let taskToDelete = realmManager.tasks[index]
                        realmManager.deleteTask(id: taskToDelete.id)
                    }
                }
            }
            .listRowSeparator(.hidden)
        }
        .onAppear{
            UITableView.appearance().backgroundColor = UIColor.clear
            UITableViewCell.appearance().backgroundColor = UIColor.clear
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hue: 0.086, saturation: 0.141, brightness: 0.972))
    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView()
            .environmentObject(RealmManager())
    }
}

