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
            List {
                Section(header: Text("Edit")) {
                    NavigationLink(destination: EditCourseView()) {
                        Text("Edit Courses")
                    }
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
                            print(error.localizedDescription)
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
