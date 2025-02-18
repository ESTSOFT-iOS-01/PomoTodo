
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

        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    ContentView()
}
