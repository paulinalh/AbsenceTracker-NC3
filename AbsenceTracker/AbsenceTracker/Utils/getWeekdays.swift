//
//  getWeekdays.swift
//  AbsenceTracker
//
//  Created by Paulina Lopez Holguin on 03/04/24.
//

import Foundation
enum Weekday: String {
    case M, T, W, Th, F, Sa, S
}

func getWeekdays(from numbers: [Int]) -> [Weekday] {
    let weekdays: [Weekday] = [.M, .T, .W, .Th, .F, .Sa, .S]
    return numbers.map { weekdays[$0 - 1] }
}

func getWeekdaysString(from numbers: [Int]) -> String {
    let weekdays: [Weekday] = [.M, .T, .W, .Th, .F, .Sa, .S]
    let weekdayStrings = numbers.map { weekdays[$0 - 1].rawValue }
    return weekdayStrings.joined(separator: ", ")
}
