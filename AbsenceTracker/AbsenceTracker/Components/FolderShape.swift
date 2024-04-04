//
//  FolderShape.swift
//  AbsenceTracker
//
//  Created by Paulina Lopez Holguin on 04/04/24.
//

import SwiftUI

struct FolderShape: View {
    let hours : String
    let date : String
    let reason : String
    
    var body: some View {
        
        ZStack{
            
            VStack(alignment: .center, spacing: 0) {
                
                HStack{
                    
                    RoundedRectangle(cornerRadius: 15.0 )
                        .fill(Color("BrightYellow"))
                        .frame(width: 120, height: 70)
                    Spacer()
                    RoundedRectangle(cornerRadius: 15.0 )
                        .fill(Color("BrightYellow"))
                        .frame(width: 120, height: 70)
                    
                }
                
                
                
                RoundedRectangle(cornerRadius: 20.0 )
                    .fill(Color("BrightYellow"))
                    .frame(width: 350, height: 120)
                    .offset(y:-35)
                
            }
            
            VStack{
            
                            HStack{
            
                                Text(reason)
                                    .foregroundColor(.black)
                                    .font(.system(size: 10))
                                
                                Spacer()
                                Text(reason)
                                    .foregroundColor(.black)
                                    .font(.system(size: 10))
            
                            }
                            .padding(.horizontal, 20)
            
                            Text(reason)
                                .foregroundColor(.black)
                                .font(.system(size: 10))
            
                        }
        }
        
    }
}



