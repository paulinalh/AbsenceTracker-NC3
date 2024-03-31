//
//  FormNewSubjectView.swift
//  AbsenceTracker
//
//  Created by Paulina Lopez Holguin on 31/03/24.
//

import SwiftUI

struct Subject: Identifiable {
    var id = UUID()
    var name: String
    var startDate: Date
    var endDate: Date
    var frequency: Int // Frequency in days of the week
    var initialHour: Date
    var finalHour: Date
    var attendanceMethod: AttendanceMethod
    
    enum AttendanceMethod {
        case percentage(Double) // Percentage of attendance required
        case maxAbsences(Int) // Maximum number of allowed absences
    }
}

struct SubjectFormView: View {
    @State private var name = ""
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var frequency = 1
    @State private var initialHour = Date()
    @State private var finalHour = Date()
    @State private var attendanceMethod = 0
    
    @State private var image = "pencil"
    @State private var offset = 0.0
    @State private var place = 1
    @Binding var isPresented: Bool
    
    @State private var subjects: [Subject] = []

    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Subject Information")) {
                                    TextField("Subject Name", text: $name)
                                    DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                                    DatePicker("End Date", selection: $endDate, displayedComponents: .date)
                                    Stepper("Frequency: \(frequency)", value: $frequency, in: 1...7)
                                    DatePicker("Initial Hour", selection: $initialHour, displayedComponents: .hourAndMinute)
                                    DatePicker("Final Hour", selection: $finalHour, displayedComponents: .hourAndMinute)
                                }
                                
                                Section(header: Text("Attendance Method")) {
                                    Picker(selection: $attendanceMethod, label: Text("Attendance Method")) {
                                        Text("Percentage").tag(0)
                                        Text("Max Absences").tag(1)
                                    }.pickerStyle(SegmentedPickerStyle())
                                }
                                
                                Button(action: saveSubject) {
                                    Text("Save")
                                }
            }
            .navigationBarTitle("New Subject")
            .navigationBarItems(trailing:
                Button("Cancel") {
                    isPresented = false
                }
            )
        }
    }
    
    func saveSubject() {
        let attendanceMethod: Subject.AttendanceMethod = attendanceMethod == 0 ? .percentage(0.8) : .maxAbsences(5)
        let newSubject = Subject(name: name, startDate: startDate, endDate: endDate, frequency: frequency, initialHour: initialHour, finalHour: finalHour, attendanceMethod: attendanceMethod)
        
        subjects.append(newSubject)
        
        // Optionally, you can reset the form fields here
        // name = ""
        // startDate = Date()
        // endDate = Date()
        // frequency = 1
        // initialHour = Date()
        // finalHour = Date()
        // attendanceMethod = 0
    }
}

#Preview {
    SubjectFormView( isPresented: .constant(true))

}
