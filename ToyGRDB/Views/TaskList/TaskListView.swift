//
//  ContentView.swift
//  ToyGRDB
//
//  Created by Faiz Mokhtar AD0502 on 30/12/2020.
//

import SwiftUI

struct TaskListView: View {
    
    @ObservedObject var viewModel: TaskListViewModel
    
    @State var showAddTaskView: Bool = false

    init(viewModel: TaskListViewModel = TaskListViewModel()) {
        self.viewModel = viewModel
    }
    
    static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
    
    static var timeFormatter: DateFormatter = {
       let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.tasks) { task in
                    NavigationLink(
                        destination: EditTaskView(viewModel: EditTaskViewModel(task: task)),
                        label: {
                            TaskRowView(task, viewModel: viewModel)
                        })
                }
            }
            .animation(.easeIn)
            .listStyle(PlainListStyle())
            .buttonStyle(PlainButtonStyle())
            .sheet(isPresented: $showAddTaskView, content: {
                AddTaskView(isPresented: $showAddTaskView)
            })
            .onAppear(perform: viewModel.fetchTasks)
            .navigationBarTitle(viewModel.title)
            .navigationBarItems(trailing:
                Button(action: {
                    self.showAddTaskView.toggle()
                }, label: {
                    HStack(spacing: 8) {
                        Text("Add Task")
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 25, height: 25)
                    }
                })
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView(viewModel: TaskListViewModel())
    }
}

struct TaskRowView: View {
    
    var task: Task
    var viewModel: TaskListViewModel
    
    init(_ task: Task, viewModel: TaskListViewModel) {
        self.task = task
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text(task.title)
                    .font(.title3)
                    .fontWeight(.bold)
                HStack {
                    Text(TaskListView.timeFormatter.string(from: task.createdAt))
                    Text(TaskListView.dateFormatter.string(from: task.createdAt))
                }
                .font(.caption)
                .foregroundColor(.secondary)
                
            }
            Spacer()
            Button(action: {
                viewModel.complete(task: task)
            }, label: {
                Image(systemName: task.isComplete ? "checkmark.circle.fill" : "circle")
                    .resizable()
                    .frame(width: 35, height: 35)
            })
            .frame(width: 44, height: 44)
        }
        .padding(.vertical)
    }
}
