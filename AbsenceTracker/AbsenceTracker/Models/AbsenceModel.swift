//
//  AbsenceModel.swift
//  AbsenceTracker
//
//  Created by Paulina Lopez Holguin on 04/04/24.
//

import Foundation
import SwiftData

@Model
final class AbsenceModel {
    let id = UUID()
    var subjectID: UUID
    var date: Date
    var hoursSkipped: Int
    var reason : String
    
    init(subjectID: UUID, date: Date, hoursSkipped: Int, reason : String) {
        self.subjectID = subjectID
        self.date = date
        self.hoursSkipped = hoursSkipped
        self.reason = reason
    }
}
