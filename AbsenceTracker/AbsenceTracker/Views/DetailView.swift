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
                        .offset(y: -150)
                    
                    HStack( spacing: 12){
                        
                        RoundedTextRectangle(text: getWeekdaysString(from: subject.classDays))
                        
                        RoundedTextRectangle(text: formatDates(initialDate: subject.startDate, finalDate: subject.endDate))
                        
                        RoundedTextRectangle(text: formatHours(initialDate: subject.initialHour, finalDate: subject.finalHour))
                        
                    }
                    .padding(.horizontal, 20)
                    .offset(y: -150)
                    
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
                        .offset(y: -150)
                    
                    
                    //ProgressBar(progress: 0.6) // 60% progress

                    
                }
                
                
            }
            
            
            ScrollView(.vertical, showsIndicators: false){
                
                Text("blabla")
            }.offset(y: -150)
            
        }.background(Color.white)
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

#Preview {

    DetailView(subject:  SubjectModel(name: "Math", image: "pencil", scale: 1.0, offset: 0, place: 1, startDate: Date(), endDate: Date(), frequency: 1, initialHour: Date(), finalHour: Date(), attendanceMethod: 0, maxAbsences: 10, currentAbsences: 0, classDays: [1, 2]), show: .constant(true), name: Namespace().wrappedValue)

}
