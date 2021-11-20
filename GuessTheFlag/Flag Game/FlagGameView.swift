//
//  FlagGameView.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 20.11.2021.
//  Copyright © 2021 Marcus Ziadé. All rights reserved.
//

import SwiftUI

struct FlagGameView: View {
    
    @ObservedObject var manager: FlagGameManager
    
    var body: some View {
        ZStack {
            VStack {
                VStack {
                    Text("Tap the flag of")
                    
                    Text(manager.countries[manager.correctAnswer])
                        .font(.headline)
                        .fontWeight(.black)
                }
                
                HStack(alignment: .bottom) {
                    Text("Level: \(manager.playerLevel)").modifier(LevelPill())
                    Spacer()
                    Text("XP: \(manager.score)").modifier(ExperiencePill())
                }
                .padding(.horizontal)
                
                ForEach(0..<3) { number in
                    Button {
                        manager.flagTapped(number)
                    } label: {
                        Image(manager.countries[number]) .flagImageMofifier()
                    }
                    .rotation3DEffect(
                        .degrees(number == manager.correctAnswer ? manager.rotation : 0),
                        axis: (x: 1, y: 0, z: 0)
                    )
                }
                .padding(.horizontal)
            }
        }
        .alert(isPresented: $manager.showingScore) {
            Alert(
                title: Text(manager.scoreTitle),
                message: Text(manager.alertMessage),
                dismissButton: .default(Text("👏 NEXT 👏"))
                { manager.askQuestion() }
            )
        }
    }
}

struct FlagGameView_Previews: PreviewProvider {
    static var previews: some View {
        FlagGameView(manager: FlagGameManager())
    }
}
