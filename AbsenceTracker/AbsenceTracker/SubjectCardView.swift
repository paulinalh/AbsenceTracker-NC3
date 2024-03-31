//
//  SubjectCardView.swift
//  AbsenceTracker
//
//  Created by Paulina Lopez Holguin on 26/03/24.
//

import SwiftUI

struct SubjectCardView: View {
    var subject: SubjectModel
    var reader : GeometryProxy
    @Binding var swiped : Int
    @Binding var show : Bool
    @Binding var selected : SubjectModel!
    
    
    var body: some View {
        
        VStack{
            Spacer(minLength: 0)
            
            HStack{
                
                Spacer()
                
                VStack{
                    HStack (){
                        
                        Text(subject.name)
                            .font(.system(size: 40))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        
                        Image(systemName: subject.image)
                            .font(.system(size: 60))
                            .foregroundColor(.white)
                            .font(.largeTitle)
                        
                        
                    }.padding(50)
                    
                    HStack(){
                        
                        VStack{
                            
                            Text("\(subject.place)")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            
                            Text("#")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                        }
                        
                        Spacer()
                        
                        
                        
                        VStack{
                            
                            Text("\(subject.place)")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            Text("#")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                        }
                        
                        

                    }.padding(50)
                    
                }
                .frame(width:  reader.frame(in: .global).width - 100 - (subject.id - swiped == 0 ? 0 : ((CGFloat(subject.id - swiped) * 20)))  ,  height: subject.id - swiped <= 2 ? reader.frame(in: .global).height - 180 + CGFloat(subject.id - swiped) * 25: reader.frame(in: .global).height - 180)
                .padding(.vertical)
                .background(subject.id - swiped == 0 ? Color("DarkBlue") : Color.gray.opacity(0.8))
                .cornerRadius(25)
                .padding(.horizontal, 30 + (CGFloat(subject.id - swiped) * 10))
                .shadow(color: Color.black.opacity(0.12), radius: 5, x: 0, y:5)
                
                Spacer()
            }
            Spacer(minLength: 0)
            
        }.contentShape(Rectangle())
    }
}

#Preview {
    
    GeometryReader{reader in
        SubjectCardView(subject: SubjectModel(id: 0, image: "pencil", name: "Math", offset: 0, place: 1), reader: reader, swiped: .constant(0), show: .constant(true), selected: .constant(nil))
    }
    
}
