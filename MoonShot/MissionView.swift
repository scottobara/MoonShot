//
//  MissionView.swift
//  MoonShot
//
//  Created by Scott Obara on 24/1/21.
//

import SwiftUI

struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    @State private var pilotExpanded = ""
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
                    
                    Text(self.mission.description)
                        .padding()
                    Divider()
                        .padding([.leading, .bottom, .trailing])
                    ForEach(self.astronauts, id: \.role) { crewMember in
                        Button(action: {
                            if pilotExpanded == crewMember.role {
                                pilotExpanded = ""
                            } else {
                            pilotExpanded = crewMember.role
                            }
                        })
                        {
                            HStack {
                                Image(crewMember.astronaut.id)
                                    .resizable()
                                    .zIndex((pilotExpanded == crewMember.role) ? 1 : 0)
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: (pilotExpanded == crewMember.role) ? 200 : 60, height: (pilotExpanded == crewMember.role) ? 200 : 60)
                                    .clipShape(RoundedRectangle(cornerRadius: (pilotExpanded == crewMember.role) ? 20 : 30))
                                    .overlay(RoundedRectangle(cornerRadius: (pilotExpanded == crewMember.role) ? 20 : 30).stroke(Color.primary, lineWidth: 1))
                                
                                VStack(alignment: .leading) {
                                    Text(crewMember.astronaut.name)
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                        
                                    Text(crewMember.role)
                                        .foregroundColor(.secondary)
                                        
                                }
                                .padding(.leading, 10.0)
                                
                                Spacer()
                            }
                            .animation(.easeInOut)
                        }
                        .padding(.horizontal)
                    }
                    
                    Spacer(minLength: 25)
                }
            }
        }
        .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
    }
    
    init(mission: Mission, astronauts: [Astronaut]) {
        self.mission = mission

        var matches = [CrewMember]()

        for member in mission.crew {
            if let match = astronauts.first(where: { $0.id == member.name }) {
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
