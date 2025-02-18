//
//  ContentView.swift
//  PomoTodo
//
//  Created by 신승재 on 2/17/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.indigoDark) // colorchip
            // pretendard
            Text("Hello, world!")
                .font(.pretendard(.black, size: 16))
            // SFPro
            Text("Hello, world!")
                .font(.system(size: 16, weight: .black))
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
