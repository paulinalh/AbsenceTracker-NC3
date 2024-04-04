//
//  DetailView.swift
//  AbsenceTracker
//
//  Created by Paulina Lopez Holguin on 31/03/24.
//

import SwiftUI

struct DetailView: View{
    
    var subject : SubjectModel
    @Binding var show : Bool
    var name : Namespace.ID

    
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
                                        .font(.title)
                                    
                                    
                                    Text(subject.name)
                                        .foregroundColor(.black)
                                        .font(.title)
                                        .fontWeight(.bold)
                                    
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                Text("absences")
                                    .foregroundColor(.black)
                                    .font(.title)
                                    .italic()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                            }
                            Spacer()
                            
                            
                        }.padding(.horizontal, 20)
                        
                        
                        ProgressBar(progress: getAbsencesPercentage())
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
                
                
                ScrollView(.vertical, showsIndicators: false){
                    
                    HStack{
                        StatisticsCard(bigStat : "\(subject.currentAbsences)", description: "days of total absences" )
                        
                        Spacer()
                        
                        StatisticsCard(bigStat : "\(calculateClassDuration(startDate: Date(), endDate: subject.endDate, classDays: subject.classDays, startTime: subject.initialHour, finishTime: subject.finalHour)!.days)", description: "remaining days of required assistance" )
                        
                    }
                    
                    HStack{
                        StatisticsCard(bigStat : "\(subject.currentAbsences * calculateHoursBetween(startDate: subject.initialHour, endDate: subject.finalHour))", description: "hours of total absences" )
                        
                        Spacer()
                        
                        StatisticsCard(bigStat : "\(calculateClassDuration(startDate: Date(), endDate: subject.endDate, classDays: subject.classDays, startTime: subject.initialHour, finishTime: subject.finalHour)!.hours)", description: "remaining hours of required assistance" )
                        
                    }
                }.offset(y: -150)
                    .frame(width: reader.size.width, height: reader.size.height * 4) // Adjust height as needed

                
            }.background(Color.white)
        }
    }
    
    func getAbsencesPercentage()-> Double{
        let duration = calculateClassDuration(startDate: subject.startDate, endDate: subject.endDate, classDays: subject.classDays, startTime: subject.initialHour, finishTime: subject.finalHour)
        
        var percentage : Double
        
        percentage = Double(( subject.currentAbsences * 100 ) / duration!.days)
        let roundedValue = (percentage * 100).rounded() / 100

        
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


struct StatisticsCard: View {
    let bigStat: String
    let description: String
    
    var body: some View {
        ZStack (alignment: .top){
            RoundedRectangle(cornerRadius: 10)
                .fill(Color("DarkBlue"))
                .frame(maxWidth: .infinity, maxHeight: 300)
                .padding()
            VStack(alignment: .leading){
                
                Text(bigStat)
                    .foregroundColor(.white)
                    .font(.title)
                    .bold()
                    .padding()
                
                Text(description)
                    .foregroundColor(.white)
                    .font(.caption)
                    .padding()
                
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
