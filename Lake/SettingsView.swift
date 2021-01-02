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
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Edit Courses")) {
                    Button("Add Course", action: {
                        courseData.addClass(name: "Foo", code: "1BAR0")
                    })
                    
                    Button("Add Assignment", action: {
                        courseData.addAssignment(courseId: "560DB265-D647-4906-B152-687E1F63CAC9", name: "Test", description: "FooBar")
                    })
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
                }
            }
            .navigationBarTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static let courseData = CourseData()
    
    static var previews: some View {
        SettingsView().environmentObject(courseData)
    }
}
