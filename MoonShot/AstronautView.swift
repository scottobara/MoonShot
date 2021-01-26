//
//  AstronautView.swift
//  MoonShot
//
//  Created by Scott Obara on 25/1/21.
//

import SwiftUI

struct AstronautView: View {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    struct MissionsCrewed {
        let mission: Mission
        let role: String
    }

//    let missions: [Mission]
    let missionRole: [MissionsCrewed]

    let astronaut: Astronaut
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)

                    Text("Summary")
                        .padding([.top, .leading, .trailing])
                        //.multilineTextAlignment(.leading)
                        .frame(width: geometry.size.width, alignment: .leading)
                        .font(.headline)
                    
                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)
                    
                    Text("Missions")
                        .padding()
                        //.multilineTextAlignment(.leading)
                        .frame(width: geometry.size.width, alignment: .leading)
                        .font(.headline)
                
                    ForEach(self.missionRole, id: \.mission.id) { crewMember in
                        Text("\(crewMember.mission.displayName): \(crewMember.role)")
                            .padding([.leading, .trailing])
                            .frame(width: geometry.size.width, alignment: .leading)
                    }
                    
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
    
    // get the current astronaut instance and [Mission] array
    init(astronaut: Astronaut, missions: [Mission]) {
        // set astronaut in context to astronaut variable
        self.astronaut = astronaut
        // create a new [MissionsCrewed]() array to load matched crew member info into
        var matches = [MissionsCrewed]()
        // loop over all the missions
        for mission in missions {
            // in each mission, check the crew
            for member in mission.crew {
                // a match is found when
                print("Does \(member.name) == \(astronaut.id)")
                if (member.name == astronaut.id) {
                    print("ping")
                    //if found add role and mission.displayName to the [MissionsCrewed]() Array
                    matches.append(MissionsCrewed(mission: mission, role: member.role))
                }
                print("\(matches)")
            }
        }

        self.missionRole = matches
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static let missions: [Mission] = Bundle.main.decode("missions.json")

    static var previews: some View {
        AstronautView(astronaut: astronauts[0], missions: missions)
    }
}
