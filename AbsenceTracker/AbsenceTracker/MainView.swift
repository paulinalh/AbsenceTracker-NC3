//
//  MainView.swift
//  AbsenceTracker
//
//  Created by Paulina Lopez Holguin on 26/03/24.
//

import SwiftUI

struct MainView: View {
    
    @State var subject_arr = [
        SubjectModel(id: 0, image: "pencil", name: "Math", offset: 0, place: 1),
        SubjectModel(id: 1, image: "pencil", name: "Math", offset: 0, place: 2),
        SubjectModel(id: 2, image: "pencil", name: "Math", offset: 0, place: 3),
        SubjectModel(id: 3, image: "pencil", name: "Math", offset: 0, place: 4),
        SubjectModel(id: 4, image: "pencil", name: "Math", offset: 0, place: 5),
    ]
    
    /*@State var subject_arr = [
        SubjectModel(id: 1, name: "Math", image: "math_image", offset: 0.0, place: 1, startDate: Date(), endDate: Date(), frequency: 1, initialHour: Date(), finalHour: Date(), attendanceMethod: .percentage(0.8)),
        SubjectModel(id: 1, name: "Math", image: "math_image", offset: 0.0, place: 1, startDate: Date(), endDate: Date(), frequency: 1, initialHour: Date(), finalHour: Date(), attendanceMethod: .percentage(0.8))

    ]*/
    
    @State var swiped = 0
    @Namespace var name
    @State var selected : SubjectModel!
    @State var show = false
    
    var body: some View {
        ZStack {
            
            VStack {
                
                HStack{
                    Text("Overview your absences")
                        .frame(alignment: .center)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                        .padding()
                        .padding(.top, 50)
                    
                    Spacer()
                }
                
                GeometryReader{reader in
                    ZStack{
                        ForEach(subject_arr.reversed()){subject in
                            
                
                            SubjectCardView(subject: subject , reader: reader, swiped: $swiped, show: $show, selected: $selected )
                                .offset(x: subject.offset)
                                .rotationEffect(.init(degrees: getRotation(offset: subject.offset)))
                                .gesture(DragGesture().onChanged({(value) in
                                    
                                    
                                        withAnimation{
                                            if value.translation.width > 0 {
                                                subject_arr[subject.id].offset = value.translation.width
                                            }
                                            
                                        }
                                    
                                }).onEnded({ (value) in
                                    
                                    withAnimation{
                                        if value.translation.width > 150 {
                                            subject_arr[subject.id].offset = 1000
                                            swiped = subject.id + 1
                                            
                                            restoreCard(id: subject.id)
                                        }else{
                                            subject_arr[subject.id].offset = 0
                                        }
                                    }
                                }))
                                .onTapGesture {
                                    withAnimation(.spring()){
                                        selected = subject
                                        show.toggle()
                                    }
                                }
                            
                        }.offset(y: -25)
                        
                        
                    }
                }
               
            }
            
            if show{
                DetailView(subject: selected, show: $show, name: name)
                    .scaleEffect(1)
            }
        }.background(
        
            Color.white.opacity(show ? 0 : 1)
        )
    }
    
    func restoreCard(id: Int){
        
        var currentCard = subject_arr[id]
        
        currentCard.id = subject_arr.count
        subject_arr.append(currentCard)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
            
            withAnimation{
                subject_arr[subject_arr.count - 1].offset = 0
            }
        }
        
    }
    
    func getRotation(offset: CGFloat)-> Double{
        let value = offset / 150
        
        let angle : CGFloat = 10
        
        let degree = Double(value * angle)
        
        return degree
        
    }
}



#Preview {
    MainView()
}
