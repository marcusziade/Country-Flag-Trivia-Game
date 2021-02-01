//
//  ParentalGateView.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 31.1.2021.
//  Copyright © 2021 Marcus Ziadé. All rights reserved.
//

import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        return path
    }
}

struct ParentalGateView: View {

    // MARK: - Properties
    var onClose: (() -> Void)?
    var onCancel: (() -> Void)?
    @State private var circleTapped: Bool = false

    // MARK: - UI Layout
    var body: some View {
        VStack(alignment: .center, spacing: 60) {
            HStack {
                Image(systemName: "arrow.left")
                    .resizable()
                    .frame(width: 40, height: 33)
                    .foregroundColor(.red)
                    .onTapGesture {
                        HapticEngine.select.selectionChanged()
                        onCancel?()
                    }
                Spacer()
            }.padding([.leading, .top], 24)

            Text("Ask your parents")
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundColor(.blue)

            Spacer()
            HStack(spacing: 130) {
                Button("") {}
                .background(Triangle()
                                .foregroundColor(.green)
                                .frame(width: 100, height: 100)
                                .onLongPressGesture {circleTapped ? onClose?() : print("Triangle Disabled") })

                Button("") {}
                .background(Rectangle()
                                .foregroundColor(.blue)
                                .frame(width: 100, height: 100))

                Button("") {}
                .background(Circle()
                                .foregroundColor(circleTapped ? .green : .yellow)
                                .frame(width: 100, height: 100)
                                .animation(.easeInOut)
                                .onTapGesture(count: 4) { circleTapped = true })
            }.padding()

            Text("Tap inside the circle until the circle turns green, then hold triangle.")
                .multilineTextAlignment(.center)
                .font(.headline)
                .padding([.leading, .trailing], 16)
                .foregroundColor(.orange)
            Spacer()
        }
    }
}

struct ParentalGateView_Previews: PreviewProvider {
    static var previews: some View {
        ParentalGateView()
            .preferredColorScheme(.dark)
    }
}
