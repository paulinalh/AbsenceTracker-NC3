//
//  FormatDate.swift
//  AbsenceTracker
//
//  Created by Paulina Lopez Holguin on 03/04/24.
//

import Foundation

func formatDates(initialDate: Date, finalDate: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd MMM"
    
    let initialDateString = dateFormatter.string(from: initialDate)
    let finalDateString = dateFormatter.string(from: finalDate)
    
    return "\(initialDateString) - \(finalDateString)"
}
