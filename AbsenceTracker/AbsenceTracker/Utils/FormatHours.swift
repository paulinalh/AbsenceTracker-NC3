//
//  FormatHours.swift
//  AbsenceTracker
//
//  Created by Paulina Lopez Holguin on 03/04/24.
//

import Foundation
func formatHours(initialDate: Date, finalDate: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    
    let initialTimeString = dateFormatter.string(from: initialDate)
    let finalTimeString = dateFormatter.string(from: finalDate)
    
    return "\(initialTimeString) - \(finalTimeString)"
}
