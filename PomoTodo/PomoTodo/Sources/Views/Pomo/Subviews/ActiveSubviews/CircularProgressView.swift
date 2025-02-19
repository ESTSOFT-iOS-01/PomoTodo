//
//  CircularProgressView.swift
//  PomoTodo
//
//  Created by 김도연 on 2/19/25.
//

import SwiftUI

struct CircularProgressView: View {
    @EnvironmentObject var pomoVM: PomoViewModel

    var body: some View {
        ZStack(alignment: .bottom) {
            // progress bar
            CircularProgressBar()
            
            // Texts
            TimerDisplayView()
        }
    }
}
