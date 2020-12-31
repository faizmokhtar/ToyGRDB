//
//  EditTaskView.swift
//  ToyGRDB
//
//  Created by Faiz Mokhtar AD0502 on 31/12/2020.
//

import SwiftUI
import Combine

struct EditTaskView: View {
    
    @ObservedObject var viewModel: EditTaskViewModel
        
    @Environment(\.presentationMode) var presentationMode

    @State var title: String = ""
    @State var isCompleted: Bool = false

    init(viewModel: EditTaskViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        Form {
            TextField("Title", text: $title)
            Toggle("Completed", isOn: $isCompleted)
            
            VStack(spacing: 10.0) {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                    viewModel.save(title: title, isCompleted: isCompleted)
                }, label: {
                    HStack {
                        Text("Save")
                            .bold()
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                    }
                    .padding()
                    .background(Color.accentColor)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                })
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                    viewModel.delete()
                }, label: {
                    HStack {
                        Text("Delete")
                            .bold()
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                    }
                    .padding()
                    .background(Color.red)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                })
            }
            .padding(.top, 20)
            .padding(.bottom, 10)
        }
        .onAppear(perform: {
            viewModel.$title
                .sink { self.title = $0 }
            viewModel.$isCompleted
                .sink { self.isCompleted = $0 }
        })
        .buttonStyle(PlainButtonStyle())
        .navigationBarTitle("Edit Task")
    }
}

struct EditTaskView_Previews: PreviewProvider {
    
    static var previews: some View {
        EditTaskView(viewModel: EditTaskViewModel(task: Task(id: nil, title: "Test Todo", isComplete: true, createdAt: Date(), updatedAt: nil)))
    }
}
