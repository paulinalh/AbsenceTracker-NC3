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
    
    @State private var selectedSortingOption = SortingOption.moreInRiskToLessRisky

    enum SortingOption: String, CaseIterable {
        case lessAbsencesToMost = "Less absences to Most absences"
        case mostAbsencesToLess = "Most absences to Least absences"
        case moreInRiskToLessRisky = "More in risk to Less in risk"
        case lessRiskyToMoreInRisk = "Less in risk to More in risk"
    }
    
    var body: some View {
        ZStack {
            
            VStack {
                
                HStack{
                    Spacer()
                    Picker("", selection: $selectedSortingOption) {
                                    ForEach(SortingOption.allCases, id: \.self) { option in
                                        Text(option.rawValue)
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                            .bold()
                                            .tag(option)
                                    }
                                }
                            .pickerStyle(.navigationLink)
                               
                }
                .padding(.top, 20)
                .padding(.trailing, 20)
                
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
                        if subject_arr.count > 0{
                            ForEach(cards.reversed(), id:\.id){ subject in
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
                        else{
                            VStack{
                                                            Spacer()
                                                            HStack{
                                                                Spacer()
                                                                VStack(alignment: .center){
                                                                    Image(systemName: "folder.fill")
                                                                        .foregroundColor(.gray)
                                                                        .font(.largeTitle)
                                                                        
                                                                    
                                                                    Text("No subjects for the moment")
                                                                        .font(.title2)
                                                                        .foregroundColor(.gray)
                                                                        .padding(.vertical, 20)
                                                                        
                                                                        
                                                                }
                                                                Spacer()
                                                                
                                                            }
                                                            Spacer()
                                                            
                                                        }
                                                        .padding(.horizontal, 50)
                                                        
                        }
                            
                            
                        
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
            sortSubjectModels()
        }
        .onChange(of: subject_arr) { newValue in
            self.cards = newValue
        }.onChange(of: selectedSortingOption) { _ in
            sortSubjectModels()
        }
    }
    
    func restoreCard(id: Int){
        
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
    
    func sortSubjectModels() {

        switch selectedSortingOption {
        case .lessAbsencesToMost:
            cards.sort { $0.currentAbsences < $1.currentAbsences }
        case .mostAbsencesToLess:
            cards.sort { $0.currentAbsences > $1.currentAbsences }
        case .moreInRiskToLessRisky:
            cards.sort { ((calculateClassDuration(startDate: Date(), endDate: $0.endDate, classDays: $0.classDays, startTime: $0.initialHour, finishTime: $0.finalHour)!.days) - $0.currentAbsences) > (((calculateClassDuration(startDate: Date(), endDate: $1.endDate, classDays: $1.classDays, startTime: $1.initialHour, finishTime: $1.finalHour)!.days) - $1.currentAbsences) )}
        case .lessRiskyToMoreInRisk:
            cards.sort { (((calculateClassDuration(startDate: Date(), endDate: $0.endDate, classDays: $0.classDays, startTime: $0.initialHour, finishTime: $0.finalHour)!.days) - $0.currentAbsences) < (((calculateClassDuration(startDate: Date(), endDate: $1.endDate, classDays: $1.classDays, startTime: $1.initialHour, finishTime: $1.finalHour)!.days) - $1.currentAbsences) ))}
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
        .modelContainer(for: SubjectModel.self, inMemory: true)
}
