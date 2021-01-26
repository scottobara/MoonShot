//
//  MissionView.swift
//  MoonShot
//
//  Created by Scott Obara on 24/1/21.
//

import SwiftUI

struct MissionView: View {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }

    let mission: Mission
    let astronauts: [CrewMember]

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.7)
                        .padding(.top)
                    
                    Text(self.mission.formattedLaunchDate)
                        .font(.subheadline)
                        .textCase(.uppercase)
                        .foregroundColor(.secondary)
                    
                    Text(self.mission.description)
                        .padding()
                        .layoutPriority(1)
                    Divider()
                        .padding([.leading, .bottom, .trailing])
                    ForEach(self.astronauts, id: \.role) { crewMember in
                        
                        NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut, missions: missions)) {
                            HStack {
                                Image(crewMember.astronaut.id)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 60, height: 60)
                                    .clipShape(RoundedRectangle(cornerRadius: 30))
                                    .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.primary, lineWidth: 1))
                                
                                VStack(alignment: .leading) {
                                    Text(crewMember.astronaut.name)
                                        .font(.headline)
                                        //.foregroundColor(.primary)
                                    
                                    Text(crewMember.role)
                                        .foregroundColor(.secondary)
                                    
                                }
                                .padding(.leading, 10.0)
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    Spacer(minLength: 25)
                }
            }
        }
        .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
    }
    
    // get the current mission and [Astronaut] array
    init(mission: Mission, astronauts: [Astronaut]) {
        //set mission in context to mission variable
        self.mission = mission
        //create a new [CrewMember]() array to load matched crew member info into
        var matches = [CrewMember]()
        //loop over the crew array (contains name and role) within the current mission
        for member in mission.crew {
            //set match to the first instance in Astronauts array where an Astronaut[$0].id == mission.crew.name
            if let match = astronauts.first(where: { $0.id == member.name }) {
                //if found add role and astronaut to the [CrewMember]() Array
                matches.append(CrewMember(role: member.role, astronaut: match))
            } else {
                fatalError("Missing \(member)")
            }
        }

        self.astronauts = matches
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
    }
}
