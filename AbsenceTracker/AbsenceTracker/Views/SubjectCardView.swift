//
//  SubjectCardView.swift
//  AbsenceTracker
//
//  Created by Paulina Lopez Holguin on 26/03/24.
//

import SwiftUI
import SwiftData

struct SubjectCardView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var subject_arr: [SubjectModel]
    
    var subject: SubjectModel
    var reader : GeometryProxy
    @Binding var swiped : Int
    @Binding var show : Bool
    @Binding var selected : SubjectModel!
    @Binding var isDeleting : Bool
    @State private var cardOffset: CGSize = .zero
    
    var body: some View {
        
        
        VStack{
            Spacer(minLength: 0)
            
        HStack{
                
                Spacer()
                
                VStack{
                    HStack (){
                        
                        Text(subject.name)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        
                        Image(systemName: subject.image)
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .font(.largeTitle)
                        
                        
                    }.padding(50)
                    
                    HStack(){
                        
                        VStack(alignment: .leading){
                            
                            Text("\(subject.currentAbsences)")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            
                            Text("absences")
                                .font(.caption)
                                
                                .foregroundColor(.white)
                            
                            Text("out of \(getMaxAbsences())")
                                .font(.caption)
                                
                                .foregroundColor(.white)
                            
                        }
                        
                        Spacer()
                        
                        
                        
                        VStack(alignment: .leading){
                            
                            Text("\(calculateClassDuration(startDate: Date(), endDate: subject.endDate, classDays: subject.classDays, startTime: subject.initialHour, finishTime: subject.finalHour)!.days)")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            
                            Text("remaining days")
                                .font(.caption)
                                .foregroundColor(.white)
                            Text("of classes")
                                .font(.caption)
                                .foregroundColor(.white)
                            
                        }
                        
                        

                    }.padding(50)
                    
                }
                .frame(width:  reader.frame(in: .global).width - 100 - (subject.place - swiped == 0 ? 0 : ((CGFloat(subject.place - swiped) * 10))), height: subject.place - swiped <= 2 ? reader.frame(in: .global).height - 180 + CGFloat(subject.place - swiped) * 15: reader.frame(in: .global).height - 180)
                .padding(.vertical)
                .background( subject.place - swiped == 0 ? Color("DarkBlue") : Color.gray.opacity(0.8))
                .cornerRadius(25)
                .padding(.horizontal, 30 + (CGFloat(subject.place - swiped) * 10))
                .shadow(color: Color.black.opacity(0.12), radius: 5, x: 0, y:5)
            
                Spacer()
            }
            Spacer(minLength: 0)
            
        }.contentShape(Rectangle())
    }
    
    func getMaxAbsences()-> Int{
        let duration = calculateClassDuration(startDate: subject.startDate, endDate: subject.endDate, classDays: subject.classDays, startTime: subject.initialHour, finishTime: subject.finalHour)
        
        var maxDays : Int
        
        if subject.attendanceMethod == 0{
            maxDays = subject.maxAbsences * duration!.days
        }else{
            maxDays = subject.maxAbsences
        }
        
        return maxDays
        
    }
    
    
    
    
}

#Preview {
    
    GeometryReader{
        reader in
        
        SubjectCardView(subject:  SubjectModel( name: "Math", image: "pencil", scale: 1.0, offset: 0, place: 0, startDate: Date(), endDate: Date(), frequency: 1, initialHour: Date(), finalHour: Date() ,attendanceMethod: 0, maxAbsences: 10, currentAbsences: 0, classDays: [1,2]), reader: reader, swiped: .constant(0), show: .constant(true), selected: .constant(nil), isDeleting: .constant(true) )
            .modelContainer(for: SubjectModel.self, inMemory: true)
    }
    
}
