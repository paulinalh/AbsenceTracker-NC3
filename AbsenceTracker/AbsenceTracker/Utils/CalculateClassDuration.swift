//
//  File.swift
//  AbsenceTracker
//
//  Created by Paulina Lopez Holguin on 03/04/24.
//

import Foundation

// Function to calculate the duration of classes based on specific days of the week
func calculateClassDuration(startDate: Date, endDate: Date, classDays: [Int], startTime: Date, finishTime: Date) -> (hours: Int, days: Int)? {
    let calendar = Calendar.current
    
    // Calculate the total number of days between start date and end date
    let totalDays = calendar.dateComponents([.day], from: startDate, to: endDate).day ?? 0
    
    // Get the day component of the start date
    let startDayOfWeek = calendar.component(.weekday, from: startDate)
    
    // Initialize variables to track class days within the date range
    var classDayCount = 0
    var currentDate = startDate
    
    // Iterate through each day within the date range
    for _ in 0..<totalDays {
        // Check if the current day matches any of the class days
        if classDays.contains(calendar.component(.weekday, from: currentDate)) {
            classDayCount += 1
        }
        // Move to the next day
        currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
    }
    
    // Calculate the total number of hours per class session
    let totalHoursPerSession = calendar.dateComponents([.hour, .minute], from: startTime, to: finishTime).hour ?? 0
    
    // Calculate the total number of hours for entire class duration
    let totalHours = classDayCount * totalHoursPerSession
    
    // Return the result
    return (totalHours, classDayCount)
}

func calculateHoursBetween(startDate: Date, endDate: Date) -> Int {
    let calendar = Calendar.current
    let components = calendar.dateComponents([.hour], from: startDate, to: endDate)
    return components.hour ?? 0
}
