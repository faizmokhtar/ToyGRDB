//
//  AddTaskView.swift
//  ToyGRDB
//
//  Created by Faiz Mokhtar AD0502 on 31/12/2020.
//

import SwiftUI

struct AddTaskView: View {

    private let viewModel: AddTaskViewModel
    
    @Binding var isPresented: Bool

    @State private var title: String = ""
    @State private var isCompleted: Bool = false
    
    init(viewModel: AddTaskViewModel = AddTaskViewModel(), isPresented: Binding<Bool>) {
        self.viewModel = viewModel
        self._isPresented = isPresented
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                Toggle("Completed", isOn: $isCompleted)
                
                Button(action: {
                    viewModel.save(title: title, isCompleted: isCompleted)
                    isPresented.toggle()
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
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                })
            }
            .buttonStyle(PlainButtonStyle())
            .navigationBarTitle("Add Task")
        }
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView( viewModel: AddTaskViewModel(), isPresented: .constant(false))
    }
}
