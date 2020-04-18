//
//  WorldFlags.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 17.10.2019.
//  Copyright © 2019 Marcus Ziadé. All rights reserved.
//

import SwiftUI

struct WorldFlags: View {
    
    let impact = UIImpactFeedbackGenerator()
    let notification = UINotificationFeedbackGenerator()
    let selection = UISelectionFeedbackGenerator()
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var alertMessage = ""
    @State private var countries = ["Australia", "East Timor", "Fiji", "Kiribati", "Marshall Islands", "Micronesia", "Nauru", "New Zealand", "Niue", "Palau", "Papua New Guinea", "Samoa", "Solomon Islands", "Tonga", "Tuvalu", "Antigua and Barbuda", "Argentina", "Bahama", "Barbados", "Belize", "Bolivia", "Brazil", "Canada", "Chile", "Colombia", "Costa Rica", "Cuba", "Dominica", "Dominican Republic", "Ecuador", "El Salvador", "Grenada", "Guatemala", "Guyana", "Haiti", "Honduras", "Jamaica", "Mexico", "Nicaragua", "Panama", "Paraguay", "Peru", "Saint Kitts and Nevis", "Saint Lucia", "Saint Vincent & Grenadines", "Suriname", "The United States", "Trinidad and Tobago", "Uruguay", "Venezuela", "Algeria", "Angola", "Benin", "Botswana", "Burkina Faso", "Burundi", "Cameroon", "Cape Verde", "Central-African Republic", "Chad", "Comoros", "Congo-Brazzaville", "Congo-Kinshasa", "Djibouti", "Egypt", "Equatorial Guinea", "Eritrea", "Ethiopia", "Gabon", "Gambia", "Ghana", "Guinea-Bissau", "Guinea", "Ivory Coast", "Kenya", "Lesotho", "Liberia", "Libya", "Madagascar", "Malawi", "Mali", "Mauritania", "Mauritius", "Morocco", "Mozambique", "Namibia", "Niger", "Nigeria", "Rwanda", "Sao Tome and Principe", "Senegal", "Sierra Leone", "Somalia", "South Africa", "South Sudan", "Sudan", "Swaziland", "Tanzania", "The Seychelles", "Togo", "Tunisia", "Uganda", "Zambia", "Zimbabwe", "Afghanistan", "Armenia", "Azerbaijan", "Bahrain", "Bangladesh", "Bhutan", "Brunei", "Cambodia", "China", "Cyprus", "India", "Indonesia", "Iran", "Iraq", "Israel", "Japan", "Jordan", "Kazakhstan", "Kuwait", "Kyrgyzstan", "Laos", "Lebanon", "Malaysia", "Maldives", "Mongolia", "Myanmar", "Nepal", "North Korea", "Oman", "Pakistan", "Philippines", "Qatar", "Russia", "Saudi Arabia", "Singapore", "South Korea", "Sri Lanka", "Syria", "Taiwan", "Tajikistan", "Thailand", "Turkey", "Turkmenistan", "United Arab Emirates", "Uzbekistan", "Vietnam", "Yemen", "Albania", "Andorra", "Austria", "Belarus", "Belgium", "Bosnia Herzegovina", "Bulgaria", "Croatia", "Czech Republic", "Denmark", "Finland", "Estonia", "France", "Georgia", "Germany", "Greece", "Hungary", "Iceland", "Ireland", "Italy", "Kosovo", "Latvia", "Liechtenstein", "Lithuania", "Luxembourg", "Macedonia", "Malta", "Moldova", "Monaco", "Montenegro", "Netherlands", "Norway", "Poland", "Portugal", "Romania", "San Marino", "Serbia", "Slovakia", "Slovenia", "Spain", "Sweden", "Switzerland", "Ukraine", "United Kingdom", "Vatican City"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = UserDefaults.standard.integer(forKey: "ScoreWorld")
    @State private var playerLevel = UserDefaults.standard.integer(forKey: "LevelWorld")
    @State private var dragAmount = CGSize.zero
    @State private var rotation = 1
    @State private var didSelectCorrectFlag = true
    @State private var showAboutScreen = false
    
    var body: some View {
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [.pink, .black]), startPoint: .top, endPoint: .bottom)
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
                    
                }.frame(minWidth: 0, maxWidth: 600, minHeight: 0, maxHeight: 400)
                    .padding(.leading)
                    .padding(.trailing)
                
                HStack {
                    
                    Text("XP: \(score)")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .frame(width: 80, height: 20, alignment: .leading)
                        .padding(.top, 3)
                        .padding(.bottom, 3)
                        .padding(.trailing)
                        .padding(.leading)
                        .background(Color.blue)
                        .cornerRadius(15)
                        .shadow(color: .blue, radius: 2)
                    
                    Spacer()
                    
                    Text("Level: \(playerLevel)")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .frame(width: 80, height: 20, alignment: .leading)
                        .padding(.top, 3)
                        .padding(.bottom, 3)
                        .padding(.trailing)
                        .padding(.leading)
                        .background(Color.green)
                        .cornerRadius(15)
                        .shadow(color: .green, radius: 2)
                    
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
        correctAnswer = Int.random(in: 0...2)
    }
}

struct WorldFlags_Previews: PreviewProvider {
    static var previews: some View {
        WorldFlags()
    }
}
