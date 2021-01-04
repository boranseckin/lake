//
//  AddCourseView.swift
//  Lake
//
//  Created by Boran Seckin on 2021-01-03.
//

import SwiftUI

struct AddCourseView: View {
    @EnvironmentObject var courseData: CourseData
    
    @Binding var isPresented: Bool

    @State private var courseName = ""
    @State private var courseCode = ""
    @State private var done = false
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Course name", text: $courseName)
                    TextField("Course code", text: $courseCode)
                }
                
                Section {
                    HStack {
                        Spacer()
                        Button("Add", action: {
                            courseData.addClass(name: courseName, code: courseCode)
                            isPresented.toggle()
                        })
                        Spacer()
                    }
                    
                }
            }
            .navigationTitle("Add Course")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button(action: {
                isPresented.toggle()
            }) {
                Text("Cancel").bold()
            })
        }
    }
}

struct AddCourseView_Previews: PreviewProvider {
    @State static var isPresented = true
    
    static let courseData = CourseData()
    
    static var previews: some View {
        AddCourseView(isPresented: $isPresented).environmentObject(courseData)
    }
}
