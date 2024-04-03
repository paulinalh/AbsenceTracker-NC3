//
//  ContentView.swift
//  AbsenceTracker
//
//  Created by Paulina Lopez Holguin on 26/03/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var isModalPresented = false
    @State private var username = ""
    @State private var password = ""
    
    var body: some View {
        NavigationView {
            MainView()
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        
                        HStack{
                            
                            Spacer()
                            Text("New Subject")
                                .font(.title2)
                                .foregroundColor(Color("DarkBlue"))
                            
                            Button(action: {
                                isModalPresented = true
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(Color("DarkBlue"))

                            }
                        }
                        
                    }
                }
        }
        .sheet(isPresented: $isModalPresented) {
            SubjectFormView( isPresented: $isModalPresented)
        }
    }
}

#Preview {
    ContentView()
}
