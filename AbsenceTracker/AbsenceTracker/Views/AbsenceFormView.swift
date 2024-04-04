//
//  AbsenceFormView.swift
//  AbsenceTracker
//
//  Created by Paulina Lopez Holguin on 04/04/24.
//

import SwiftUI
import SwiftData

struct AbsenceFormView: View {
    var firstSubject: SubjectModel

    @State private var selectedSubject: SubjectModel?
    @State private var isSubjectSelected: Bool = false

    @State private var selectedDate = Date()
    @State private var hoursMissed = 0
    @State private var isWholeDayMissed = false
    @State private var reason = ""
    
    @Binding var isPresented: Bool
    
    @Environment(\.modelContext) private var modelContext
    @Query private var subject_arr: [SubjectModel]
    
    var body: some View {
                
        NavigationView {
            Form {
                Section(header: Text("Subject")) {
                    Picker("Subject", selection: ( $selectedSubject)) {
                        ForEach(subject_arr) { subject in
                            Text(subject.name).tag(Optional(subject))
                        }
                    }
                    
                }
                
                Section(header: Text("Details")) {
                    DatePicker("Date", selection: $selectedDate, displayedComponents: .date)
                    
                    /*Toggle(isOn: $isWholeDayMissed) {
                        Text("Whole Day Missed")
                    }*/
                    
                    Stepper(value: $hoursMissed, in: 0...24) {
                        
                        Text("\(hoursMissed) hours")
                    
                    }
                    
                    
                    
                    TextField("Reason", text: $reason)
                }
                
            
                
                
                // Conditional Save Button based on form completion
                if isFormComplete {
                    HStack{
                        Spacer()
                        Button(action: saveAbsence) {
                            Text("Save")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        .padding()
                        .frame(width: 200)
                        Spacer()
                    }
                    
                }
            }
            .navigationBarTitle("Register Absence")
            .navigationBarItems(trailing:
                Button("Cancel") {
                    isPresented = false
                }
                            
            )
        }
        .onAppear{
            guard selectedSubject == nil else { return }
               selectedSubject = subject_arr.first
        }
    }
    
    // Check if all form fields are filled out
    var isFormComplete: Bool {
        selectedSubject != nil && hoursMissed != 0 && !reason.isEmpty
    }

    func saveAbsence() {
            //let attendanceMethod: Subject.AttendanceMethod = attendanceMethod == 0 ? .percentage(0.8) : .maxAbsences(5)
            //let newSubject = Subject(name: name, startDate: startDate, endDate: endDate, frequency: frequency, initialHour: initialHour, finalHour: finalHour, attendanceMethod: attendanceMethod)
            
        let newAbsence = AbsenceModel(subjectID: selectedSubject!.id, date: selectedDate, hoursSkipped: hoursMissed, reason: reason)
                        
            modelContext.insert(newAbsence)
            
            selectedSubject?.currentAbsences = hoursMissed
            //selectedSubject = SubjectModel?
            selectedDate = Date()
            hoursMissed = 0
            isWholeDayMissed = false
            reason = ""
            
            isPresented = false
        
    }
}

