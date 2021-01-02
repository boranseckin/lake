//
//  AssignmentRow.swift
//  Lake
//
//  Created by Boran Seckin on 2021-01-02.
//

import SwiftUI

struct AssignmentRow: View {
    var assignment: Assignment
    
    func calcDaysLeft(date: Date) -> String {
        let days = Int(Date().distance(to: date) / 86400)
                    
        if days > 99 {
            return "99+"
        } else if days == 0{
            return "Today"
        } else if days < 0 {
            return "Late"
        } else {
            return String(days)
        }
    }
        
    var body: some View {
        NavigationLink(destination: AssignmentDetails(assignment: assignment)) {
            HStack {
                VStack(alignment: .leading) {
                    Text(assignment.name)
                        .font(.headline)
                    Text(Date().formatShort(assignment.dueDate))
                        .fontWeight(.light)
                }
                
                Spacer()
                
                Text(calcDaysLeft(date: assignment.dueDate))
                    .padding(5)
            }
        }
    }
}

struct AssignmentRow_Previews: PreviewProvider {
    static var previews: some View {
        AssignmentRow(assignment: Assignment.example)
    }
}
