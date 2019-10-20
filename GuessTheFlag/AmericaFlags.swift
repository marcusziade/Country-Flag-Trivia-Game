//
//  AmericaFlags.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 16.10.2019.
//  Copyright © 2019 Marcus Ziadé. All rights reserved.
//

import SwiftUI

struct AmericaFlags: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var countries = ["Antigua and Barbuda", "Argentina", "Bahama", "Barbados", "Belize", "Bolivia", "Brazil", "Canada", "Chile", "Colobia", "Costa Rica", "Cuba", "Dominica", "Dominican Republic", "Ecuador", "El Salvador", "Grenada", "Guatemala", "Guyana", "Haiti", "Honduras", "Jamaica", "Mexico", "Nicaragua", "Panama", "Paraguay", "Peru", "Saint Kitts and Nevis", "Saint Lucia", "Saint Vincent & Grenadines", "Suriname", "The United States", "Trinidad and Tobago", "Uruguay", "Venezuela"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var score = 0
    
    var body: some View {
        ZStack {
                
                LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
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
                            self.flagTapped(number)
                        }) {
                            Image(self.countries[number])
                                .resizable()
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .overlay(Capsule().stroke(Color.black, lineWidth: 2))
                                .shadow(color: .black, radius: 2)
                            
                            
                        }
                    }.frame(minWidth: 0, maxWidth: 600, minHeight: 0, maxHeight: 400)
                        .padding(.leading)
                        .padding(.trailing)
                    
                    HStack {
                        Button(action: {
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
                Alert(title: Text(scoreTitle), message: nil, dismissButton: .default(Text("Continue")) {
                    self.askQuestion()
                })
            }
        }
        
        func flagTapped(_ number: Int) {
            if number == correctAnswer {
                scoreTitle = "Correct ✅\n" + "+15 points!"
                score += 15
            } else {
                scoreTitle = "Wrong 🚫\n" + "-5 points"
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

struct AmericaFlags_Previews: PreviewProvider {
    static var previews: some View {
        AmericaFlags()
    }
}
