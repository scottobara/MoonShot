//
//  ContentView.swift
//  MoonShot
//
//  Created by Scott Obara on 13/1/21.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    @State private var showDate = true
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit() //.aspectRatio(contentMode: .fit)
                        .frame(width: 44, height: 44)

                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        Text(showDate ? mission.formattedLaunchDate : "Crew list goes here")
                            .font(.subheadline)
                            //.textCase(.uppercase)
                            .foregroundColor(.secondary)
                    }
                }
//                .navigationBarItems(trailing:
//                                        Button(showDate ? "Crew" : "Date") {
//                        showDate.toggle()
//                    }
//                )
                .navigationBarItems(trailing:
                                        Button(action: { showDate.toggle()}) {
                                                        Image(systemName: "arrow.triangle.2.circlepath")
                                                            .padding([.leading, .top, .bottom])
                                                    }
                )
            }
            .navigationBarTitle("Moonshot")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
