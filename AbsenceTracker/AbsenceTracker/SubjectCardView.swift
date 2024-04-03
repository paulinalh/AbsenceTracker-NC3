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
                            
                            Text("#\(swiped)")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                        }
                        
                        

                    }.padding(50)
                    
                }
                .frame(width:  reader.frame(in: .global).width - 100 - (subject.place - swiped == 0 ? 0 : ((CGFloat(subject.place - swiped) * 10))), height: subject.place - swiped <= 2 ? reader.frame(in: .global).height - 180 + CGFloat(subject.place - swiped) * 15: reader.frame(in: .global).height - 180)
                /*.frame(
                    width: reader.frame(in: .global).width - 100,
                    height: {
                        // Calculate the adjusted place considering how many times the user has swiped.
                        let adjustedPlace = subject.place - swiped

                        // Height for the first card (shortest).
                        let firstCardHeight = reader.frame(in: .global).height - 180

                        // Height increment for each subsequent visible card.
                        let heightIncrement = 25.0

                        switch adjustedPlace {
                        case 0:
                            // The card at the top of the stack (after considering swipes), so it's the shortest.
                            return firstCardHeight
                        case 1:
                            // The second card, make it medium length by adding one increment.
                            return firstCardHeight + heightIncrement
                        case 2:
                            // The third card, make it the longest by adding two increments.
                            return firstCardHeight + (2 * heightIncrement)
                        default:
                            // Any card beyond the third is made shorter than the third to ensure it doesn't show.
                            // You can adjust this value to make them even shorter if necessary.
                            return firstCardHeight - 10 // Or any value that keeps it out of view.
                        }
                    }()
                )*/
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
    
    
}

#Preview {
    
    GeometryReader{
        reader in
        
        SubjectCardView(subject:  SubjectModel( name: "Math", image: "pencil", scale: 1.0, offset: 0, place: 0, startDate: Date(), endDate: Date(), frequency: 1, initialHour: Date(), finalHour: Date()), reader: reader, swiped: .constant(0), show: .constant(true), selected: .constant(nil), isDeleting: .constant(true) )
            .modelContainer(for: SubjectModel.self, inMemory: true)
    }
    
}
