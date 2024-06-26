//
//  DetailView.swift
//  AbsenceTracker
//
//  Created by Paulina Lopez Holguin on 31/03/24.
//

import SwiftUI
import SwiftData

struct DetailView: View{
    
    var subject : SubjectModel
    @Binding var show : Bool
    var name : Namespace.ID
    
    @Query private var absencesArray: [AbsenceModel]
    @State private var absencesForSubject : [AbsenceModel] = []

    var body : some View{
        GeometryReader{ reader in
            VStack{
                
                ZStack{
                    
                    Rectangle()
                        .fill(Color("DarkBlue"))
                        .cornerRadius(50)
                        .frame(width: .infinity, height: 500)
                        .offset(y: -150)
                    
                    
                    VStack{
                        
                        HStack{
                            
                            Button(action: {
                                withAnimation(.spring()){
                                    
                                    show.toggle()
                                }
                            }){
                                Image(systemName: "chevron.left")
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                                
                            }
                            
                            Spacer()
                        }.padding( 20)
                        //.padding([.top, .bottom, .trailing ])
                        
                        
                        HStack( spacing: 12){
                            
                            RoundedTextRectangle(text: getWeekdaysString(from: subject.classDays))
                            
                            RoundedTextRectangle(text: formatDates(initialDate: subject.startDate, finalDate: subject.endDate))
                            
                            RoundedTextRectangle(text: formatHours(initialDate: subject.initialHour, finalDate: subject.finalHour))
                            
                        }
                        .padding(.horizontal, 20)
                        
                        
                        /*Image(systemName: subject.image)
                         .matchedGeometryEffect(id: subject.image, in: name)*/
                        
                        HStack{
                            VStack{
                                
                                HStack(){
                                    Text("Detailed ")
                                        .foregroundColor(.black)
                                        .font(.title2)
                                    
                                    
                                    Text(subject.name)
                                        .foregroundColor(.black)
                                        .font(.title2)
                                        .fontWeight(.bold)
                                    
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                Text("absences")
                                    .foregroundColor(.black)
                                    .font(.title2)
                                    .italic()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                            }
                            Spacer()
                            
                            
                        }.padding(.horizontal, 20)
                        
                        
                        ProgressBar(progress: getAbsencesPercentage()/100)
                            .padding(.horizontal, 50)
                        
                        Text("you've used \(getAbsencesPercentage())% of your total absences")
                            .foregroundColor(.white)
                            .font(.caption)
                            .italic()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .offset(y: -200)
                            .padding(.horizontal, 50)
                        
                        
                    }
                    
                    
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                           // Utilizes a standard HStack for horizontal layout, spacing elements 10 points apart.
                    HStack(alignment: .center, spacing: 10.0) {
                               // Iterates over the colors array to generate a Rectangle view for each color.
                               ForEach(0..<absencesForSubject.count, id: \.self) { index in
                                   AbsencesCard(absence: absencesForSubject[index], index: index)
                                       .scrollTransition { content, phase in
                                           content
                                               .opacity(phase.isIdentity ? 1 : 0.3) // Adjusts the opacity during transitions.
                                               .scaleEffect(phase.isIdentity ? 1 : 0.3) // Scales the Rectangle based on its scroll phase.
                                               .offset(x: phase.isIdentity ? 0 : 20, // Moves the Rectangle horizontally
                                                       y: phase.isIdentity ? 0 : 20) // and vertically during transition.
                                           
                                       }
                               }
                           }
                           .scrollTargetLayout() // Marks the parent layout as a target for scroll behaviors, aiding alignment.
                       }
                       .scrollTargetBehavior(.viewAligned) // Aligns scrolled content based on the geometries of the views.
                       .safeAreaPadding(.horizontal, 20)
                       .offset(y: -150)
                
                
                HStack{
                    StatisticsCard(bigStat : "\(subject.currentAbsences * calculateHoursBetween(startDate: subject.initialHour, endDate: subject.finalHour))", description: "hours of total absences" )
                    
                    Spacer()
                    
                    StatisticsCard(bigStat : "\(calculateClassDuration(startDate: Date(), endDate: subject.endDate, classDays: subject.classDays, startTime: subject.initialHour, finishTime: subject.finalHour)!.hours)", description: "remaining hours of required assistance" )
                    
                }.offset(y: -150)
                

                
            }
            .background(Color("LightGray"))
            
        }
        .onAppear{
            self.absencesForSubject = absencesArray.filter { $0.subjectID == subject.id }

        }
    }
    
    func getAbsencesPercentage()-> Double{
        let duration = calculateClassDuration(startDate: subject.startDate, endDate: subject.endDate, classDays: subject.classDays, startTime: subject.initialHour, finishTime: subject.finalHour)
        
        var percentage : Double
        
        percentage = Double(( subject.currentAbsences * 100 ) / duration!.days)
        let roundedValue = (percentage * 100).rounded() / 100

        print(roundedValue)
        return roundedValue
        
    }
        
}



struct RoundedTextRectangle: View {
    let text: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(.black)
                .frame(maxWidth: .infinity, maxHeight: 30)
            Text(text)
                .foregroundColor(.white)
                .font(.system(size: 10))
        }
    }
    
    init(text: String) {
        self.text = text
    }
}
struct AbsencesCard: View {
    let absence: AbsenceModel
    let index: Int
    
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 10.0)
                .fill(Color.clear)
            .frame(width: .infinity, height: 150)
                        
                
            VStack(alignment: .leading){
                
                HStack{
                    Text("Absence #\(index)")
                        .bold()
                        .foregroundColor(Color("DarkBlue"))
                        .font(.subheadline)
                    
                    Spacer()
                    
                }.padding(.horizontal, 20)
                
                HStack{
                    
                    Text("\(absence.hoursSkipped) hours on ")
                        
                        .foregroundColor(.gray)
                        .font(.caption)
                    
                    Text(formatDate(date: absence.date))
                        .foregroundColor(Color("DarkBlue").opacity(0.6))
                        .font(.caption)
                    
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
                
                HStack{
                    Text("Reason: ")
                        .bold()
                        .foregroundColor(.black)
                        .font(.caption)
                    
                    Text(absence.reason)
                        .foregroundColor(.black)
                        .font(.caption)
                    
                }.padding(.horizontal, 20)
                
                
                
            }
            
        }
    }
    
    init(absence: AbsenceModel, index:Int) {
        self.absence = absence
        self.index = index
    }
}

struct StatisticsCard: View {
    let bigStat: String
    let description: String
    
    var body: some View {
        ZStack (alignment: .top){
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .frame(maxWidth: .infinity, maxHeight: 150)
                .padding()
            VStack(alignment: .leading){
                
                Text(bigStat)
                    .foregroundColor(.black)
                    .font(.title)
                    .bold()
                    .padding(.horizontal)
                    .padding( .top)
                
                Text(description)
                    .foregroundColor(.black)
                    .font(.caption2)
                    .padding(.horizontal)
                    .padding(.bottom)

                
            }
            .padding()
            
        }
    }
    
    init(bigStat: String, description: String) {
        self.bigStat = bigStat
        self.description = description
    }
}

#Preview {

    DetailView(subject:  SubjectModel(name: "Math", image: "pencil", scale: 1.0, offset: 0, place: 1, startDate: Date(), endDate: Date(), frequency: 1, initialHour: Date(), finalHour: Date(), attendanceMethod: 0, maxAbsences: 10, currentAbsences: 0, classDays: [1, 2]), show: .constant(true), name: Namespace().wrappedValue)

}
