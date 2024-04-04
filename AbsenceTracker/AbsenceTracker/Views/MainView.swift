//
//  MainView.swift
//  AbsenceTracker
//
//  Created by Paulina Lopez Holguin on 26/03/24.
//

import SwiftUI
import SwiftData

struct MainView: View {
    
    @State private var isDeleting = false
    @State private var deletionIndex: Int?
    
    @Environment(\.modelContext) private var modelContext
    @Query private var subject_arr: [SubjectModel]
    @State private var cards: [SubjectModel] = []


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
                        ForEach(cards.reversed(), id:\.id){subject in
                            SubjectCardView(subject: subject , reader: reader, swiped: $swiped, show: $show, selected: $selected, isDeleting: $isDeleting )
                                .offset(x: subject.offset)
                                .rotationEffect(.init(degrees: getRotation(offset: subject.offset)))
                                .gesture(DragGesture().onChanged({(value) in
                                    
                                    let index = cards.firstIndex(where: {$0.id == subject.id})
                                    withAnimation{
                                            if value.translation.width != 0 {
                                                cards[index!].offset = value.translation.width
                                            }
                                            
                                        }
                                    
                                }).onEnded({ (value) in
                                    let index = cards.firstIndex(where: {$0.id == subject.id})

                                    withAnimation{
                                        if value.translation.width > 150 {
                                            cards[index!].offset = 1000
                                            if swiped == cards.count - 1 {
                                                swiped = 0
                                            }else{
                                                swiped = subject.place + 1
                                            }
                                            
                                            
                                            restoreCard(id: index!)
                                        }else if value.translation.width < -150 {
                                            cards[index!].offset = -1000
                                            if swiped == cards.count - 1 {
                                                swiped = 0
                                            }else{
                                                swiped = subject.place + 1
                                            }
                                            
                                            
                                            restoreCard(id: index!)
                                        }else{
                                            cards[index!].offset = 0
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
        .onAppear{
            self.cards = subject_arr
        }
        .onChange(of: subject_arr) { newValue in
            self.cards = newValue
        }
    }
    
    func restoreCard(id: Int){
        

        //var currentCard = cards[id]
        
        //currentCard.place = cards.count
        //cards.append(currentCard)
        
        let subject = cards.remove(at: id)
        //subject.place = cards.count + 1
        cards.append(subject)
        
        //modelContext.insert(currentCard)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
            
            withAnimation{
                cards[cards.count - 1].offset = 0
            }
        }
        
        
        
    }
    
    /*func restoreCard(id: Int){
        guard id >= 0 && id < cards.count else { return }
        
        let currentCard = cards.remove(at: id)
        cards.append(currentCard)
        
        // This assumes you've fixed the ID uniqueness issue elsewhere or using stable IDs
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation {
                cards[cards.count - 1].offset = 0
            }
        }
    }*/
    
    func getRotation(offset: CGFloat)-> Double{
        let value = offset / 150
        
        let angle : CGFloat = 10
        
        let degree = Double(value * angle)
        
        return degree
        
    }
}



#Preview {
    MainView()
        .modelContainer(for: SubjectModel.self, inMemory: true)
}
