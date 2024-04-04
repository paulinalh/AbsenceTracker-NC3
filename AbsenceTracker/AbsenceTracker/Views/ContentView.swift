//
//  ContentView.swift
//  AbsenceTracker
//
//  Created by Paulina Lopez Holguin on 26/03/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var subject_arr: [SubjectModel]
    
    @State private var isModalSubjectFormPresented = false
    @State private var isModalAbsenceFormPresented = false

    @State private var username = ""
    @State private var password = ""
    
    var body: some View {
        NavigationView {
            MainView()
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        
                        HStack{
                            
                            if subject_arr.count > 0{
                                Button(action: {
                                    isModalAbsenceFormPresented = true
                                }) {
                                    HStack{
                                        
                                        Image(systemName: "plus.circle.fill")
                                            .foregroundColor(Color("DarkBlue"))
                                        
                                        Text("Add Absence")
                                            .font(.subheadline)
                                            .foregroundColor(Color("DarkBlue"))
                                    }
                                    

                                }
                            }
                            
                            
                            Spacer()
                            
                            
                            Button(action: {
                                isModalSubjectFormPresented = true
                            }) {
                                Text("Add Subject")
                                    .font(.subheadline)
                                    .foregroundColor(Color("DarkBlue"))

                            }
                        }
                        
                    }
                }
        }
        .sheet(isPresented: $isModalSubjectFormPresented) {
            SubjectFormView( isPresented: $isModalSubjectFormPresented)
        }
        .sheet(isPresented: $isModalAbsenceFormPresented) {
            AbsenceFormView( firstSubject: subject_arr.first!  , isPresented: $isModalAbsenceFormPresented)
        }
    }
}

#Preview {
    ContentView()
}
