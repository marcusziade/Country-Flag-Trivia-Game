//
//  AfricaFlags.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 15.10.2019.
//  Copyright © 2019 Marcus Ziadé. All rights reserved.
//

import SwiftUI

struct AfricaFlags: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var countries = ["Algeria", "Angola", "Benin", "Botswana", "Burkina Faso", "Burundi", "Cameroon", "Cape Verde", "Central-African Republic", "Chad", "Comoros", "Congo-Brazzaville", "Congo-Kinshasa", "Djibouti", "Egypt", "Equatorial Guinea", "Eritrea", "Ethiopia", "Gabon", "Gambia", "Ghana", "Guinea-Bissau", "Guinea", "Ivory Coast", "Kenya", "Lesotho", "Liberia", "Libya", "Madagascar", "Malawi", "Mali", "Mauritania", "Mauritius", "Morocco", "Mozambique", "Namibia", "Niger", "Nigeria", "Rwanda", "Sao Tome and Principe", "Senegal", "Sierra Leone", "Somalia", "South Africa", "South Sudan", "Sudan", "Swaziland", "Tanzania", "The Seychelles", "Togo", "Tunisia", "Uganda", "Zambia", "Zimbabwe"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var score = 0
    
    var body: some View {
        ZStack {
                
                LinearGradient(gradient: Gradient(colors: [.red, .black]), startPoint: .top, endPoint: .bottom)
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

struct AfricaFlags_Previews: PreviewProvider {
    static var previews: some View {
        AfricaFlags()
    }
}
