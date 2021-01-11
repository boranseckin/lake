//
//  AppView.swift
//  Lake
//
//  Created by Boran Seckin on 2021-01-02.
//

import SwiftUI

extension View {
    func printView(_ vars: Any...) -> some View {
        for v in vars { print(v) }
        return EmptyView()
    }
}

struct AppView: View {
    @State private var tabSelection = 1
    
    var body: some View {
        TabView(selection: $tabSelection) {
            ContentView()
                .tabItem {
                    Image(systemName: "books.vertical.fill")
                    Text("Courses")
                }
                .tag(1)
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
                .tag(2)
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static let courseData = CourseData()
    
    static var previews: some View {
        AppView().environmentObject(courseData)
    }
}
