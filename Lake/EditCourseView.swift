//
//  RemoveCourseView.swift
//  Lake
//
//  Created by Boran Seckin on 2021-01-03.
//

import SwiftUI

struct EditCourseView: View {
    @EnvironmentObject var courseData: CourseData
    
    @State var showAddCourse = false
    @State private var showDeleteAlert = false
    @State private var toBeDeleted: IndexSet?
    
    private func deleteCourse() {
        courseData.removeCourse(at: self.toBeDeleted!)
    }
    
    private func moveCourse(source: IndexSet, destination: Int) {
        courseData.moveCourse(source: source, destination: destination)
    }
    
    var body: some View {
        List {
            Section {
                ForEach(courseData.courses) { course in
                    Text("\(course.name) - \(course.code)")
                }
                .onDelete(perform: { index in
                    toBeDeleted = index
                    showDeleteAlert.toggle()
                })
                .onMove(perform: moveCourse)
                .alert(isPresented: $showDeleteAlert, content: {
                    Alert(title: Text("Are you sure you want to delete this course?"), message: Text("\(courseData.courses[(toBeDeleted?.first)!].name) - \(courseData.courses[(toBeDeleted?.first)!].code)"), primaryButton: .destructive(Text("Delete")) { deleteCourse() }, secondaryButton: .cancel())
                })
            }
            
            Section {
                Button("Add New Course", action: {
                    showAddCourse.toggle()
                }).sheet(isPresented: $showAddCourse, content: {
                    AddCourseView(isPresented: $showAddCourse)
                })
            }
        }
        .navigationBarTitle(Text("Edit Courses"), displayMode: .inline)
        .listStyle(GroupedListStyle())
        .navigationBarItems(trailing: EditButton())
    }
}

struct RemoveCourseView_Previews: PreviewProvider {
    static let courseData = CourseData()
    
    static var previews: some View {
        EditCourseView().environmentObject(courseData)
    }
}
