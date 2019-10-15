//
//  EuropeFlags.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 15.10.2019.
//  Copyright © 2019 Marcus Ziadé. All rights reserved.
//

import SwiftUI

struct EuropeFlags: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var countries = ["Albania", "Andorra", "Austria", "Belarus", "Belgium", "Bosnia & Herzegovina", "bulgaria", "croatia", "Czech Republic", "Denmark", "Finland", "France", "Georgia", "Germany", "Greece", "Hungary", "Iceland", "Ireland", "Italy", "Kosovo", "Latvia", "Liechtenstein", "Lithuania", "Luxembourg", "Macedonia", "Malta", "Moldova", "Monaco", "Montenegro", "Netherlands", "Norway", "Poland", "Portugal", "Romania", "San Marino", "Serbia", "Slovakia", "Slovenia", "Spain", "Sweden", "Switzerland", "Ukraine", "United Kingdom", "Vatican City"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var score = 0
    
    var body: some View {
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                VStack(spacing: 30) {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                        
                    Text(countries[correctAnswer])
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .foregroundColor(.white)
                    
                }.padding(.top, 30)
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        Image(self.countries[number])
                        .renderingMode(.original)
                        .clipShape(Rectangle())
                        .overlay(Rectangle().stroke(Color.black, lineWidth: 2))
                        .shadow(color: .black, radius: 2)
                        .padding()
                    }
                }
                
                Text("Your score: \(score)").padding(.top, 20)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                
                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Score \(self.score)"), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            })
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct ✅"
            score += 1
        } else {
            scoreTitle = "Wrong 🚫"
            score -= 1
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct EuropeFlags_Previews: PreviewProvider {
    static var previews: some View {
        EuropeFlags()
    }
}
