//
//  ContentView.swift
//  Lake
//
//  Created by Boran Seckin on 2021-01-01.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var courseData: CourseData
    
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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static let courseData = CourseData()
    
    static var previews: some View {
        ContentView().environmentObject(courseData)
    }
}
