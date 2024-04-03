//
//  SubjectModel.swift
//  AbsenceTracker
//
//  Created by Paulina Lopez Holguin on 26/03/24.
//

import Foundation
import SwiftData

/*struct SubjectModel: Identifiable {
    var id: Int
    var image: String
    var name : String
    var offset: CGFloat
    var place : Int
    
}*/


@Model
final class SubjectModel {
    let id = UUID()
    var name: String
    //For card animation
    var image: String
    var offset: CGFloat
    var scale: CGFloat
    var place : Int
    //Subject details
    var startDate: Date
    var endDate: Date
    var frequency: Int // Frequency in days of the week
    var initialHour: Date
    var finalHour: Date
    var attendanceMethod : Int
    var maxAbsences : Int
    var currentAbsences : Int
    var classDays : [Int]
    
    init( name: String, image: String, scale:CGFloat, offset: CGFloat, place: Int, startDate: Date, endDate: Date, frequency: Int, initialHour: Date, finalHour: Date, attendanceMethod: Int, maxAbsences: Int, currentAbsences : Int,  classDays : [Int] ) {
        //self.id = id
        self.name = name
        self.image = image
        self.scale = scale
        self.offset = offset
        self.place = place
        self.startDate = startDate
        self.endDate = endDate
        self.frequency = frequency
        self.initialHour = initialHour
        self.finalHour = finalHour
        self.attendanceMethod = attendanceMethod
        self.maxAbsences = maxAbsences
        self.currentAbsences = currentAbsences
        self.classDays = classDays
    }
}



