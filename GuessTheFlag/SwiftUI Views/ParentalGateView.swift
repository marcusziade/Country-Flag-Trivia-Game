//
//  ParentalGateView.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 31.1.2021.
//  Copyright © 2021 Marcus Ziadé. All rights reserved.
//

import SwiftUI

struct ParentalGateView: View {

    // MARK: - Properties
    @Environment(\.presentationMode) var presentationMode
    @State var tInput1 = "1"
    @State var tInput2 = "2"
    @State var tInput3 = "3"
    @State var nP = ""
    @State var npP = ""
    @State var pressedN  = ""
    @State var randN = 0
    @State var showingAbout = false
    @State var hiddenOpp = 1.0

    var body: some View {
        ZStack {
            Color(.white)
            VStack {
                Capsule()
                    .fill(Color.gray)
                    .frame(width: 80, height: 5)
                    .padding(.vertical)
                Spacer()
                Text("""
            This area is for parents only.
            Please press the numbers shown, in order.
            """)
                    .padding()
                    .font(.system(size: 20))
                    .multilineTextAlignment(.center)
                    .frame(width: 400)
                Spacer()
                HStack {
                    Text(tInput1)
                        .font(.system(size: 30))
                        .frame(width: 40, height: 40, alignment: .center)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.black, lineWidth: 2)
                        )
                        .multilineTextAlignment(.center)

                    Text(tInput2)
                        .font(.system(size: 30))
                        .frame(width: 40, height: 40, alignment: .center)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.black, lineWidth: 2)
                        )
                        .multilineTextAlignment(.center)

                    Text(tInput3)
                        .font(.system(size: 30))
                        .frame(width: 40, height: 40, alignment: .center)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.black, lineWidth: 2)
                        )
                        .multilineTextAlignment(.center)
                }
                .padding()
                Spacer()
                HStack {
                    Group {

                        Button(action: {
                            pressedN = "0"
                            numbersPressed()
                        }) {
                            Text("0")
                                .font(.system(size: 20))
                                .fontWeight(.heavy)
                                .foregroundColor(Color.blue)
                                .multilineTextAlignment(.center)
                                .padding(20.0)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.blue, lineWidth: 4)
                                )

                        }
                        Button(action: {
                            pressedN = "1"
                            numbersPressed()
                        }) {
                            Text("1")
                                .font(.system(size: 20))
                                .fontWeight(.heavy)
                                .foregroundColor(Color.blue)
                                .multilineTextAlignment(.center)
                                .padding(20.0)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.blue, lineWidth: 4)
                                )
                        }

                        Button(action: {
                            pressedN = "2"
                            numbersPressed()
                        }) {
                            Text("2")
                                .font(.system(size: 20))
                                .fontWeight(.heavy)
                                .foregroundColor(Color.blue)
                                .multilineTextAlignment(.center)
                                .padding(20.0)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.blue, lineWidth: 4)
                                )
                        }
                        Button(action: {
                            pressedN = "3"
                            numbersPressed()
                        }) {
                            Text("3")
                                .font(.system(size: 20))
                                .fontWeight(.heavy)
                                .foregroundColor(Color.blue)
                                .multilineTextAlignment(.center)
                                .padding(20.0)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.blue, lineWidth: 4)
                                )
                        }
                        Button(action: {
                            pressedN = "4"
                            numbersPressed()
                        }) {
                            Text("4")
                                .font(.system(size: 20))
                                .fontWeight(.heavy)
                                .foregroundColor(Color.blue)
                                .multilineTextAlignment(.center)
                                .padding(20.0)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.blue, lineWidth: 4)
                                )
                        }
                    }
                }
                HStack {
                    Group {
                        Button(action: {
                            pressedN = "5"
                            numbersPressed()
                        }) {
                            Text("5")
                                .font(.system(size: 20))
                                .fontWeight(.heavy)
                                .foregroundColor(Color.blue)
                                .multilineTextAlignment(.center)
                                .padding(20.0)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.blue, lineWidth: 4)
                                )
                        }
                        Button(action: {
                            pressedN = "6"
                            numbersPressed()
                        }) {
                            Text("6")
                                .font(.system(size: 20))
                                .fontWeight(.heavy)
                                .foregroundColor(Color.blue)
                                .multilineTextAlignment(.center)
                                .padding(20.0)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.blue, lineWidth: 4)
                                )
                        }
                        Button(action: {
                            pressedN = "7"
                            numbersPressed()
                        }) {
                            Text("7")
                                .font(.system(size: 20))
                                .fontWeight(.heavy)
                                .foregroundColor(Color.blue)
                                .multilineTextAlignment(.center)
                                .padding(20.0)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.blue, lineWidth: 4)
                                )
                        }
                        Button(action: {
                            pressedN = "8"
                            numbersPressed()
                        }) {
                            Text("8")
                                .font(.system(size: 20))
                                .fontWeight(.heavy)
                                .foregroundColor(Color.blue)
                                .multilineTextAlignment(.center)
                                .padding(20.0)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.blue, lineWidth: 4)
                                )
                        }
                        Button(action: {
                            pressedN = "9"
                            numbersPressed()
                        }) {
                            Text("9")
                                .font(.system(size: 20))
                                .fontWeight(.heavy)
                                .foregroundColor(Color.blue)
                                .multilineTextAlignment(.center)
                                .padding(20.0)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.blue, lineWidth: 4)
                                )
                        }
                    }
                }
                Spacer()
            }
        }
        .opacity(hiddenOpp)
        .onAppear() {
            setNums()

        }
    }

    func setNums() {
        for _ in 0..<3 {
            randN = Int.random(in: 0..<10)
            npP = npP + "\(randN)"
            print("Tony numbers are \(npP)")
        }
        let char1 = npP[npP.index(npP.startIndex, offsetBy: 0)]
        tInput1 = "\(char1)"

        let char2 = npP[npP.index(npP.startIndex, offsetBy: 1)]
        tInput2 = "\(char2)"

        let char3 = npP[npP.index(npP.startIndex, offsetBy: 2)]
        tInput3 = "\(char3)"
    }

    func numbersPressed() {
        if nP == "" {
            nP = pressedN
            print("Tony numbers are \(nP)")
        } else {
            if nP.count == 1 {
                nP = nP + pressedN
                print("Tony numbers are \(nP)")
            } else {
                nP = nP + pressedN
                print("Tony numbers are \(nP)")
                if nP == "\(npP)" {
                    npP = ""
                    nP = ""
                    print("Tony Corect numbers")
                    hiddenOpp = 0.0
                } else {
                    self.presentationMode.wrappedValue.dismiss()
                    print("Tony Incorect numbers")
                    npP = ""
                    nP = ""
                    setNums()
                }
            }
        }
    }
}

struct ParentalGateView_Previews: PreviewProvider {
    static var previews: some View {
        ParentalGateView()
    }
}
