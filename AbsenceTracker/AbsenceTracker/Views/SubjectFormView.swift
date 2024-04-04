//
//  FormNewSubjectView.swift
//  AbsenceTracker
//
//  Created by Paulina Lopez Holguin on 31/03/24.
//

import SwiftUI
import SwiftData

struct SubjectFormView: View {
    // Existing @State and @Environment variables...
    @Environment(\.modelContext) private var modelContext
    @Query private var subject_arr: [SubjectModel]
    
    @State private var name = ""
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var frequency = 0
    @State private var initialHour = Date()
    @State private var finalHour = Date()
    @State private var attendanceMethod = 0
    @State private var maxAbsences: Int = 0
    @State private var classDays: [Int] = []

    @State private var image = "pencil"
    @State private var offset = 0
    @State private var place = 0
    @Binding var isPresented: Bool
    
    enum Weekday: String, CaseIterable {
        case M, T, W, Th, F, Sa, S
    }
    
    @State private var selectedDays: Set<Weekday> = [] // For frequency selection

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Subject Information")) {
                    
                    TextField("Subject Name", text: $name)

                    
                    Picker("Subject Icon", selection: $image) {
                                        ForEach(schoolSymbols, id: \.self) {icon in
                                            Image(systemName: icon)
                                                .foregroundColor(.black)
                                                .font(.caption)
                                        }
                                    }
                                    .pickerStyle(.navigationLink)
                    DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                    DatePicker("End Date", selection: $endDate, displayedComponents: .date)
                    // Replace Stepper with an HStack of circular buttons
                    HStack {
                        ForEach(Weekday.allCases, id: \.self) { day in
                                   Text(day.rawValue)
                                       .frame(width: 35, height: 35)
                                       .foregroundColor(selectedDays.contains(day) ? .white : Color("DarkBlue"))
                                       .background(selectedDays.contains(day) ? Color("DarkBlue") : .clear)
                                       .clipShape(Circle())
                                       .onTapGesture {
                                           if selectedDays.contains(day) {
                                               selectedDays.remove(day)
                                               frequency = frequency - 1
                                               if let index = Weekday.allCases.firstIndex(of: day) {
                                                   classDays.removeAll { $0 == index }
                                                   }
                                           } else {
                                               selectedDays.insert(day)
                                               frequency = frequency + 1
                                               if let index = Weekday.allCases.firstIndex(of: day) {
                                                   classDays.append(index)
                                                }
                                           }
                                       }
                               }
                           }
                    DatePicker("Initial Hour", selection: $initialHour, displayedComponents: .hourAndMinute)
                    DatePicker("Final Hour", selection: $finalHour, displayedComponents: .hourAndMinute)
                }

                Section(header: Text("Attendance Method")) {
                    
                    HStack{
                        
                        Picker(selection: $attendanceMethod, label: Text("Attendance Method")) {
                            Text("Percentage").tag(0)
                            Text("Max Absences").tag(1)
                        }.pickerStyle(SegmentedPickerStyle())
                        
                        Spacer()
                        
                        TextField("Enter a number", value: $maxAbsences, formatter: NumberFormatter(), onEditingChanged: { editing in
                                           // Handle editing changed event if needed
                                       })
                                       .keyboardType(.numberPad)
                                       .frame(width: 50)
                                       .padding(.leading, 8)
                        if attendanceMethod == 0{
                            Text("%")
                        }
                    }
                    
                }

                // Conditional Save Button based on form completion
                if isFormComplete {
                    HStack{
                        Spacer()
                        Button(action: saveSubject) {
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
            .navigationBarTitle("New Subject")
            .navigationBarItems(trailing:
                                    Button("Cancel") {
                                        isPresented = false
                                    }
            )
        }
    }

    // Check if all form fields are filled out
    var isFormComplete: Bool {
        !name.isEmpty && !selectedDays.isEmpty && maxAbsences != 0 && !image.isEmpty
    }

    func saveSubject() {
            //let attendanceMethod: Subject.AttendanceMethod = attendanceMethod == 0 ? .percentage(0.8) : .maxAbsences(5)
            //let newSubject = Subject(name: name, startDate: startDate, endDate: endDate, frequency: frequency, initialHour: initialHour, finalHour: finalHour, attendanceMethod: attendanceMethod)
            
        let newModel = SubjectModel(name: name, image: image,scale: 1.0,  offset: 0, place: subject_arr.count , startDate: startDate, endDate: endDate, frequency: frequency, initialHour: initialHour, finalHour: finalHour, attendanceMethod: attendanceMethod, maxAbsences: (attendanceMethod == 0 ? calculateClassDuration(startDate: startDate, endDate: endDate, classDays: classDays, startTime: initialHour, finishTime: finalHour)!.days * maxAbsences / 100 :  maxAbsences), currentAbsences: 0, classDays : classDays)
            
            //subjects.append(newSubject)
            
            modelContext.insert(newModel)
            
            // Optionally, you can reset the form fields here
            name = ""
            image = ""
            startDate = Date()
            endDate = Date()
            frequency = 0
            initialHour = Date()
            finalHour = Date()
            attendanceMethod = 0
            
            isPresented = false
        
    }

}
/*#Preview {
    SubjectFormView( isPresented: .constant(true))
        .modelContainer(for: SubjectModel.self, inMemory: true)


}*/
