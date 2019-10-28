//
//  AmericaFlags.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 16.10.2019.
//  Copyright © 2019 Marcus Ziadé. All rights reserved.
//

import SwiftUI

struct AmericaFlags: View {
    
    let impact = UIImpactFeedbackGenerator()
    let notification = UINotificationFeedbackGenerator()
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var alertMessage = ""
    @State private var countries = ["Antigua and Barbuda", "Argentina", "Bahama", "Barbados", "Belize", "Bolivia", "Brazil", "Canada", "Chile", "Colombia", "Costa Rica", "Cuba", "Dominica", "Dominican Republic", "Ecuador", "El Salvador", "Grenada", "Guatemala", "Guyana", "Haiti", "Honduras", "Jamaica", "Mexico", "Nicaragua", "Panama", "Paraguay", "Peru", "Saint Kitts and Nevis", "Saint Lucia", "Saint Vincent & Grenadines", "Suriname", "The United States", "Trinidad and Tobago", "Uruguay", "Venezuela"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var score = 0
    @State private var dragAmount = CGSize.zero
    
    @State private var rotation = 1
    
    @State private var didSelectCorrectFlag = true
    
    @State private var showSettingsScreen = false
    @State private var showNewGameAlert = false
    
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
                        self.impact.impactOccurred()
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
                    
                }.frame(minWidth: 0, maxWidth: 600, minHeight: 0, maxHeight: 400)
                    .padding(.leading)
                    .padding(.trailing)
                
                HStack {
                    Button(action: {
                        self.showNewGameAlert.toggle()
                        self.notification.notificationOccurred(.error)
                        self.newGame()
                    }, label: {
                        Image(systemName: "gobackward")
                            .font(.title)
                            .foregroundColor(.white)
                        })
                    
                    Spacer()
                    Text("Score: \(score)")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(4)
                        .background(Color.black)
                        .cornerRadius(15)
                    
                    Spacer()
                    
                    Button(action: {
                        self.notification.notificationOccurred(.success)
                        self.showSettingsScreen.toggle()
                    }, label: {
                        Image(systemName: "gear")
                            .font(.title)
                            .foregroundColor(.white)
                        }).sheet(isPresented: $showSettingsScreen, content: { Settings() })
                    
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
            didSelectCorrectFlag = true
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

struct AmericaFlags_Previews: PreviewProvider {
    static var previews: some View {
        AmericaFlags()
    }
}
