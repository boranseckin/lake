//
//  Course.swift
//  Lake
//
//  Created by Boran Seckin on 2021-01-01.
//

import Foundation

struct Course: Codable, Identifiable {
    var id: UUID
    var name: String
    var code: String
    var assignments: [Assignment]
}

struct Assignment: Codable, Identifiable {
    var id: UUID
    var name: String
    var dueDate: Date
    var description: String
    
    #if DEBUG
    static let example = Assignment(id: UUID(), name: "LonCAPA 11", dueDate: Date(), description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce a ultrices leo. Cras vel laoreet orci. Quisque mollis feugiat feugiat. Sed aliquam egestas nibh at.")
    #endif
}

class CourseData: ObservableObject {
    @Published var courses = [Course]()
    
    func printc() {
        print(courses)
    }
    
    func addClass(name: String, code: String) {
        courses.append(Course(id: UUID(), name: name, code: code, assignments: []))
    }
    
    func addAssignment(courseId: String, name: String, description: String) {
        if let index = courses.firstIndex(where: { $0.id.uuidString == courseId }) {
            let new = Assignment(id: UUID(), name: name, dueDate: Date(), description: description)
            courses[index].assignments.append(new)
        }
    }
    
    func save() -> Bool {
        let json = Bundle.main.encode([Course].self, data: courses)

        do {
            let res = try Data.saveFM(jsonObject: json, toFilename: "course_data")
            return res
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func load() {
        do {
            guard let data = try Data.loadFM(withFilename: "course_data") else {
                fatalError()
            }
            let json = Bundle.main.decode([Course].self, from: data)
            courses = json
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}