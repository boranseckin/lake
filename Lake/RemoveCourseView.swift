//
//  RemoveCourseView.swift
//  Lake
//
//  Created by Boran Seckin on 2021-01-03.
//

import SwiftUI

struct RemoveCourseView: View {
    @EnvironmentObject var courseData: CourseData
    
    @State private var showDeleteAlert = false
    @State private var toBeDeleted: IndexSet?
    
    func deleteCourse() {
        courseData.removeClass(at: self.toBeDeleted!)
    }
    
    var body: some View {
        List {
            ForEach(courseData.courses) { course in
                Text("\(course.name) - \(course.code)")
            }
            .onDelete(perform: { index in
                toBeDeleted = index
                showDeleteAlert.toggle()
            })
            .alert(isPresented: $showDeleteAlert, content: {
                Alert(title: Text("Are you sure you want to delete this course?"), message: Text("\(courseData.courses[(toBeDeleted?.first)!].name) - \(courseData.courses[(toBeDeleted?.first)!].code)"), primaryButton: .destructive(Text("Delete")) { deleteCourse() }, secondaryButton: .cancel())
            })
        }
        .navigationBarTitle(Text("Remove Course"), displayMode: .inline)
        .listStyle(GroupedListStyle())
        .navigationBarItems(trailing: EditButton())
    }
}

struct RemoveCourseView_Previews: PreviewProvider {
    static let courseData = CourseData()
    
    static var previews: some View {
        RemoveCourseView().environmentObject(courseData)
    }
}
