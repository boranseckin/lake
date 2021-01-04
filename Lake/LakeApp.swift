//
//  LakeApp.swift
//  Lake
//
//  Created by Boran Seckin on 2021-01-01.
//

import SwiftUI

@main
struct LakeApp: App {
    var courseData = CourseData()
    
    var body: some Scene {
        WindowGroup {
            AppView().environmentObject(courseData)
        }
    }
}
