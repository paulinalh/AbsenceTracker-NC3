//
//  SubjectCardView.swift
//  AbsenceTracker
//
//  Created by Paulina Lopez Holguin on 26/03/24.
//

import SwiftUI

struct SubjectCardView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.white)
            .frame(height: 100)
            .shadow(radius: 5)
    }
}

#Preview {
    SubjectCardView()
}
