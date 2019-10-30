//
//  Settings.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 28.10.2019.
//  Copyright © 2019 Marcus Ziadé. All rights reserved.
//

import SwiftUI

struct About: View {
    
    let impact = UIImpactFeedbackGenerator()
    
    @Environment(\.presentationMode) var presentationMode
    
    struct HeadingStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(.primary)
                .padding(.top, 6)
                .padding(.bottom, 20)
                .font(Font.custom("Arial Rounded MT Bold", size: 30))
        }
    }
    
    struct TextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(.white)
                .padding(.leading, 30)
                .padding(.trailing, 30)
                .padding(.bottom, 20)
                .font(Font.custom("Arial Rounded MT Bold", size: 16))
        }
    }
    
    let backgroundColor = Color(red: 255.0 / 255.0, green: 214.0 / 255.0, blue: 255.0 / 255.0)
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.green, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            Group {
                VStack {
                    Text("🏳️ Master of Flags 🏴").modifier(HeadingStyle())
                    Text("This is Master of Flags, the game where you gather experience points (XP) and level up as you become familiar with the world's flags. There are 196 different flags in this game! Your objective is to learn them all.🤓").modifier(TextStyle())
                    Text("You gain 15 XP from a correct answer and lose 10 XP from a wrong answer. The correct answer is indicated by the spinning flag!🌀").modifier(TextStyle())
                    Text("You need 450 points to level up.☄️").modifier(TextStyle())
                    
                    
                    
                    Button("Got it 👍") {
                        self.impact.impactOccurred()
                        self.presentationMode.wrappedValue.dismiss()
                    }
                .padding(20)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .font(.subheadline)
                .cornerRadius(10)
                    
                }
            .navigationBarTitle("About Flagger")
            }
        }
    }
}

struct About_Previews: PreviewProvider {
    static var previews: some View {
        About()
    }
}
