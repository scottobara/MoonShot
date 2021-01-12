//
//  ContentView.swift
//  MoonShot
//
//  Created by Scott Obara on 13/1/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            
            GeometryReader { geo in
                VStack {Spacer()
                    Image("Example")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geo.size.width)
                    Spacer()
                }
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
