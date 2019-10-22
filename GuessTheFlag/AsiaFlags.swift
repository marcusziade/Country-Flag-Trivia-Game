//
//  AsiaFlags.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 15.10.2019.
//  Copyright © 2019 Marcus Ziadé. All rights reserved.
//

import SwiftUI

struct AsiaFlags: View {
    
    let impact = UIImpactFeedbackGenerator()
    let notification = UINotificationFeedbackGenerator()
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var alertMessage = ""
    @State private var countries = ["Afghanistan", "Armenia", "Azerbaijan", "Bahrain", "Bangladesh", "Bhutan", "Brunei", "Cambodia", "China", "Cyprus", "India", "Indonesia", "Iran", "Iraq", "Israel", "Japan", "Jordan", "Kazakhstan", "Kuwait", "Kyrgyzstan", "Laos", "Lebanon", "Malaysia", "Maldives", "Mongolia", "Myanmar", "Nepal", "North Korea", "Oman", "Pakistan", "Philippines", "Qatar", "Russia", "Saudi Arabia", "Singapore", "South Korea", "Sri Lanka", "Syria", "Taiwan", "Tajikistan", "Thailand", "Turkey", "Turkmenistan", "United Arab Emirates", "Uzbekistan", "Vietnam", "Yemen"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var score = 0
    
    var body: some View {
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [.yellow, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                        .padding(.top)
                    
                    Text(countries[correctAnswer])
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .foregroundColor(.white)
                    
                }
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.impact.impactOccurred()
                        self.flagTapped(number)
                    }) {
                        Image(self.countries[number])
                            .resizable()
                            .renderingMode(.original)
                            .clipShape(Rectangle())
                            .overlay(Rectangle().stroke(Color.black, lineWidth: 2))
                            .shadow(color: .black, radius: 2)
                        
                        
                    }
                }.frame(minWidth: 0, maxWidth: 600, minHeight: 0, maxHeight: 400)
                    .padding(.leading)
                    .padding(.trailing)
                
                HStack {
                    Button(action: {
                        self.notification.notificationOccurred(.error)
                        self.newGame()
                    }) {
                        Image(systemName: "gobackward")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    Spacer()
                    Text("Score: \(score)")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(4)
                        .background(Color.black)
                        .cornerRadius(15)
                    
                    Spacer()
                    
                    
                }
                .padding(.leading)
                .padding(.trailing)
                
                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text(alertMessage), dismissButton: .default(Text("👏 NEXT 👏")) {
                self.askQuestion()
                })
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct ✅\n" + "+15 points!"
            alertMessage = "That's the flag of \(countries[number])"
            score += 15
        } else {
            scoreTitle = "Wrong 🚫\n" + "-5 points"
            alertMessage = "That's the flag of \(countries[number])"
            score -= 5
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func newGame() {
        score = 0
        askQuestion()
    }
}

struct AsiaFlags_Previews: PreviewProvider {
    static var previews: some View {
        AsiaFlags()
    }
}
