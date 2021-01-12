//
//  ContentView.swift
//  MoonShot
//
//  Created by Scott Obara on 13/1/21.
//

import SwiftUI

struct CustomText: View {
    static var printCount: Int = 0
    var text: String

    var body: some View {
        Text(text)
    }
    
    init(_ text: String) {
        print("Creating a new CustomText: \(CustomText.printCount)")
        CustomText.printCount += 1
        self.text = text
    }
}

struct ContentView: View {
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 10) {
                ForEach(0..<100) {
                    CustomText("Item \($0)")
                        .font(.title)
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
