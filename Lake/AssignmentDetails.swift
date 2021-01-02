//
//  AssignmentDetails.swift
//  Lake
//
//  Created by Boran Seckin on 2021-01-02.
//

import SwiftUI

struct AssignmentDetails: View {
    var assignment: Assignment
    
    var body: some View {
        VStack {
            Text(assignment.description)
                .padding()
            Text("Due by \(Date().formatShort(assignment.dueDate))")
            
            Spacer()
        }
        .navigationBarTitle(Text(assignment.name), displayMode: .inline)
    }
}

struct AssignmentDetails_Previews: PreviewProvider {
    static var previews: some View {
        AssignmentDetails(assignment: Assignment.example)
    }
}
