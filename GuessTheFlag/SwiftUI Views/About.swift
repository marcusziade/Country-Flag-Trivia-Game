//
//  Settings.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 28.10.2019.
//  Copyright © 2019 Marcus Ziadé. All rights reserved.
//

import SwiftUI

struct About: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    struct HeadingStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(.black)
                .padding(.bottom, 20)
                .font(Font.custom("Arial Rounded MT Bold", size: 30))
        }
    }
    
    struct TextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(.black)
                .padding(.bottom, 20)
                .font(Font.custom("Arial Rounded MT Bold", size: 18))
        }
    }
        
    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            VStack {
                VStack() {
                    Spacer()
                    
                    Text("Master of Flags").modifier(HeadingStyle())
                    Text("This is Master of Flags, the game where you gather experience points (XP) and level up as you become familiar with the world's flags. There are 196 different flags in this game! Your objective is to learn them all.🤓").multilineTextAlignment(.center).modifier(TextStyle())
                    Text("You gain 15 XP from a correct answer and lose 10 XP from a wrong answer. The correct answer is indicated by the spinning flag!🌀").multilineTextAlignment(.center).modifier(TextStyle())
                    Text("You need 450 points to level up.☄️").multilineTextAlignment(.center).modifier(TextStyle())
                }
            }
        })
    }
}

struct About_Previews: PreviewProvider {
    static var previews: some View {
        About()
            .preferredColorScheme(.dark)
            .previewDevice("iPhone SE (1st generation)")
    }
}
