//
//  FlagGameView.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 15.10.2019.
//  Copyright © 2019 Marcus Ziadé. All rights reserved.
//

import SwiftUI

struct FlagGameView: View {
    
    @StateObject var manager: FlagGameManager
    
    var body: some View {
        VStack {
            Picker(selection: $manager.activePickerValue, label: Text("Pick region")) {
                ForEach(0 ..< manager.regions.count) {
                    Text(manager.regions[$0].title)
                }
            }
            .pickerStyle(.segmented)
            
            FlagGameHeaderView(
                answer: manager.countries[manager.correctAnswer],
                score: manager.score,
                level: manager.playerLevel,
                streak: manager.streak
            )
            
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
        }
        .padding(.horizontal, 8)
        .padding(.bottom, 4)
        .actionSheet(isPresented: $manager.showingScore) {
            ActionSheet(
                title: Text(manager.scoreTitle),
                message: Text(manager.alertMessage),
                buttons: [.default(Text("Next ⏭"), action: { manager.askQuestion() })]
            )
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FlagGameView(manager: FlagGameManager())
            FlagGameView(manager: FlagGameManager())
                .preferredColorScheme(.dark)
                .previewDevice("iPhone SE (1st generation)")
        }
    }
}
