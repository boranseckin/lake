//
//  AddAssignmentView.swift
//  Lake
//
//  Created by Boran Seckin on 2021-01-03.
//

import SwiftUI

struct AddAssignmentView: View {
    @EnvironmentObject var courseData: CourseData
    
    @Binding var isPresented: Bool

    @State private var assignmentName = ""
    @State private var assignmentDesc = ""
    @State private var assingmentDate = Date()
    @State private var selectedCourse = 0
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Course", selection: $selectedCourse) {
                        ForEach(0 ..< courseData.courses.count) {
                            Text("\(courseData.courses[$0].name) - \(courseData.courses[$0].code)")
                        }
                    }
                }
                
                Section {
                    TextField("Assignment name", text: $assignmentName)
                    
                    DatePicker("Due Date", selection: $assingmentDate)
                        .datePickerStyle(DefaultDatePickerStyle())
                }
                
                Section {
                    ZStack(alignment: .leading) {
                        if assignmentDesc.isEmpty {
                            Text("Assignment description")
                                .foregroundColor(Color(UIColor.placeholderText))
                        }
                        
                        TextEditor(text: $assignmentDesc)
                    }
                }
                
                Section {
                    HStack {
                        Spacer()
                        Button("Add", action: {
                            courseData.addAssignment(course: courseData.courses[selectedCourse], name: assignmentName, dueDate: assingmentDate, description: assignmentDesc)
                            isPresented.toggle()
                        })
                        Spacer()
                    }
                    
                }
            }
            .navigationTitle("Add Assignment")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button(action: {
                isPresented.toggle()
            }) {
                Text("Cancel").bold()
            })
        }
    }}

struct AddAssignmentView_Previews: PreviewProvider {
    @State static var isPresented = true
    
    static let courseData = CourseData()
    
    static var previews: some View {
        AddAssignmentView(isPresented: $isPresented).environmentObject(courseData)
    }
}
