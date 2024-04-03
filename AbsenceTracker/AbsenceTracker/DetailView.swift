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
                    
                
                HStack(alignment: .top, spacing: 12){
                    
                    Button(action: {
                        
                        withAnimation(.spring()){
                            
                            show.toggle()
                        }
                    }){
                        Image(systemName: "chevron.left")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundColor(.white)
                        
                    }
                    
                    Spacer(minLength: 0)
                    
                    Image(systemName: subject.image)
                        .matchedGeometryEffect(id: subject.image, in: name)
                }
                .padding(.leading, 20)
                .padding([.top, .bottom, .trailing ])
                .offset(y: -200)
                
            }
            
            
            ScrollView(.vertical, showsIndicators: false){
                
                Text("blabla")
            }.offset(y: -150)
            
        }.background(Color.white)
    }
    
}

#Preview {

    DetailView(subject:  SubjectModel(name: "Math", image: "pencil", scale: 1.0, offset: 0, place: 1, startDate: Date(), endDate: Date(), frequency: 1, initialHour: Date(), finalHour: Date()), show: .constant(true), name: Namespace().wrappedValue)

}
