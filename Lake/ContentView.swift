//
//  ContentView.swift
//  Lake
//
//  Created by Boran Seckin on 2021-01-01.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var courseData: CourseData
    
    @State var showAddAssignment = false
    
    private var addButton: some View {
        AnyView(Button(action: {
            showAddAssignment.toggle()
        }) {
            Image(systemName: "plus")
        }).sheet(isPresented: $showAddAssignment, content: {
            AddAssignmentView(isPresented: $showAddAssignment)
        })
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(courseData.courses) { course in
                    Section(header: Text("\(course.name) - \(course.code)")) {
                        ForEach(course.assignments) { assignment in
                            AssignmentRow(assignment: assignment)
                        }
                    }
                }
            }
            .navigationTitle("Courses")
            .listStyle(SidebarListStyle())
            .navigationBarItems(trailing: addButton)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static let courseData = CourseData()
    
    static var previews: some View {
        ContentView().environmentObject(courseData)
    }
}
