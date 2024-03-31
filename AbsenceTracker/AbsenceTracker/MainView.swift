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
    
    @State var swiped = 0
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.white, Color("DarkPurple")]),
                           startPoint: .top,
                           endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                HStack{
                    Text("Overview your absences")
                        .frame(alignment: .center)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                        .padding()
                    
                    Spacer()
                }
                
                GeometryReader{reader in
                    ZStack{
                        ForEach(subject_arr.reversed()){subject in
                            
                            CardView(subject: subject , reader: reader, swiped: $swiped )
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
                            
                        }.offset(y: -25)
                        
                        
                    }
                }
               
            }
        }
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


struct CardView: View {
    var subject: SubjectModel
    var reader : GeometryProxy
    @Binding var swiped : Int
    
    var body: some View {
        VStack{
            Spacer(minLength: 0)
            
            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom), content: {
                VStack{
                    
                    
                    Image(systemName: subject.image)
                        .foregroundColor(.gray)
                        .font(.largeTitle)
                    
                    Text(subject.name)
                    
                    
                }
                
                HStack{
                    
                    Text("#")
                        .font(.system(size: 60))
                        .fontWeight(.bold)
                        .foregroundColor(Color.gray.opacity(0.6))
                    
                    Text("\(subject.place)")
                        .font(.system(size: 120))
                        .fontWeight(.bold)
                        .foregroundColor(Color.gray.opacity(0.6))

                }.offset(x: -15, y: 25)
            })
            
            .frame(width: reader.frame(in: .global).width - 100, height: reader.frame(in: .global).height-120)
            .padding(.vertical)
            .background(Color.white)
            .cornerRadius(25)
            .padding(.horizontal, 30 + (CGFloat(subject.id - swiped) * 10))
            .offset(y: subject.id - swiped <= 2 ? CGFloat(subject.id - swiped) * 25 : 50)
            .shadow(color: Color.black.opacity(0.12), radius: 5, x: 0, y:5)
            
            Spacer(minLength: 0)
            
        }.contentShape(Rectangle())
    }
}

#Preview {
    MainView()
}
