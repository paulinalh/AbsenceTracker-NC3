//
//  ProgressBar.swift
//  AbsenceTracker
//
//  Created by Paulina Lopez Holguin on 04/04/24.
//

import SwiftUI

struct ProgressBar: View {
    var progress: Double // Progress value between 0 and 1
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 20) // Background
                    .foregroundColor(Color.gray.opacity(0.3))
                    .frame(width: geometry.size.width, height: 30)
                
                RoundedRectangle(cornerRadius: 20) // Progress indicator
                    .foregroundColor(.white)
                    .frame(width: CGFloat(self.progress) * geometry.size.width, height: 30)
            }
        }
    }
}

#Preview {
    ProgressBar(progress: 0.6)
}
