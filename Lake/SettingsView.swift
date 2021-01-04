//
//  SettingsView.swift
//  Lake
//
//  Created by Boran Seckin on 2021-01-02.
//

import SwiftUI
import Foundation

struct SettingsView: View {
    @EnvironmentObject var courseData: CourseData
    
    @State var showAddCourse = false
    @State var showAddAssignment = false
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Edit Content")) {
                    Button(action: {
                        self.showAddCourse.toggle()
                    }) {
                        Text("Add Course")
                    }.sheet(isPresented: $showAddCourse) {
                        AddCourseView(isPresented: self.$showAddCourse)
                    }
                    
                    NavigationLink(destination: RemoveCourseView()) {
                        Text("Remove Course")
                    }.disabled(courseData.courses.isEmpty)
                    
                    Button(action: {
                        self.showAddAssignment.toggle()
                    }) {
                        Text("Add Assignment")
                    }.sheet(isPresented: $showAddAssignment) {
                        AddAssignmentView(isPresented: self.$showAddAssignment)
                    }.disabled(courseData.courses.isEmpty)
                }
                
                Section(header: Text("Debug")) {
                    Button("Print", action: {
                        courseData.printc()
                    })
                    
                    Button("Save", action: {
                        if !courseData.save() {
                            fatalError("Failed to save")
                        }
                    })
                    
                    Button("Load", action: {
                        courseData.load()
                    })
                    
                    Button("Load Legacy", action: {
                        courseData.courses = Bundle.main.decodeOld([Course].self, from: "courses.json")
                    })
                    
                    Button("Delete", action: {
                        do {
                            try Data.deleteFM(atPath: "course_data")
                        } catch {
                            fatalError(error.localizedDescription)
                        }
                    })
                    
                    Button("Check", action: {
                        let path = Data.checkFM(atPath: "course_data")
                        print(path)
                    })
                }
            }
            .navigationTitle("Settings")
            .listStyle(InsetGroupedListStyle())
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static let courseData = CourseData()
    
    static var previews: some View {
        SettingsView().environmentObject(courseData)
    }
}
