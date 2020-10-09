//
//  EuropeFlags.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 15.10.2019.
//  Copyright © 2019 Marcus Ziadé. All rights reserved.
//

import SwiftUI

struct EuropeFlags: View {
    
    let impact = UIImpactFeedbackGenerator()
    let notification = UINotificationFeedbackGenerator()
    let selection = UISelectionFeedbackGenerator()
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var alertMessage = ""
    @State private var flagNumber = 1
    
    @State private var countries = FlagStore().europeFlags.shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = UserDefaults.standard.integer(forKey: "ScoreEurope")
    @State private var dragAmount = CGSize.zero
    @State private var rotation = 1
    @State private var didSelectCorrectFlag = true
    @State private var showAboutScreen = false
    @State private var playerLevel = UserDefaults.standard.integer(forKey: "LevelEurope")
    
    var body: some View {
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [.purple, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                        .padding(.top, 8)
                        .layoutPriority(1)
                    
                    Text(countries[correctAnswer])
                        .font(.headline)
                        .fontWeight(.black)
                        .foregroundColor(.white)
                    
                }
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.selection.selectionChanged()
                        if self.didSelectCorrectFlag {
                            withAnimation(.interpolatingSpring(mass: 40, stiffness: 500, damping: 200, initialVelocity: 2.2)) {
                                self.rotation += 360
                            }
                        }
                        self.flagTapped(number)
                    }) {
                        Image(self.countries[number])
                            .resizable()
                            .renderingMode(.original)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
                            .shadow(color: .black, radius: 2)
                            .offset(self.dragAmount)
                            .gesture(
                                DragGesture()
                                    .onChanged { self.dragAmount = $0.translation }
                                    .onEnded { _ in
                                        withAnimation(.spring()) {
                                            self.dragAmount = .zero
                                        }
                                }
                        )
                    }
                        
                    .rotation3DEffect(.degrees((number == self.correctAnswer) ? Double(self.rotation) : 0), axis: (x: 1, y: 0, z: 0))
                    
                }
                .padding([.leading, .trailing])
                
                HStack {
                    
                    Text("XP: \(score)")
                        .modifier(ExperiencePill())
                    
                    Spacer()
                    
                    Text("Level: \(playerLevel)")
                        .modifier(LevelPill())
                    
                    Spacer()
                    
                    Button(action: {
                        self.notification.notificationOccurred(.success)
                        self.showAboutScreen.toggle()
                    }, label: {
                        Image(systemName: "info")
                            .font(.system(size: 17))
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color.yellow)
                            .clipShape(Circle())
                            .shadow(color: .yellow, radius: 3)
                        
                    }).sheet(isPresented: $showAboutScreen, content: { About() })
                    
                }
                .padding([.leading, .trailing])
                
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
            scoreTitle = "Correct ✅\n" + "+15 XP!"
            alertMessage = "That's the flag of \(countries[number])"
            UIView.animate(withDuration: 0.2) {
                self.score += 15
            }
            UserDefaults.standard.set(self.score, forKey: "ScoreEurope")
            
            if score >= 450 {
                UIView.animate(withDuration: 0.2) {
                    self.playerLevel += 1
                    self.score = 0
                }
                UserDefaults.standard.set(self.playerLevel, forKey: "LevelEurope")
                UserDefaults.standard.set(self.score, forKey: "ScoreEurope")
            }
            
        } else {
            scoreTitle = "Wrong 🚫\n" + "-10 XP"
            alertMessage = "That's the flag of \(countries[number])"
            UIView.animate(withDuration: 0.2) {
                self.score -= 10
            }
            UserDefaults.standard.set(self.score, forKey: "ScoreEurope")
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)    }
}

struct EuropeFlags_Previews: PreviewProvider {
    static var previews: some View {
        EuropeFlags()
    }
}
