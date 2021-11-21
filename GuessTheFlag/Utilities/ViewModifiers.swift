//
//  ViewModifiers.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 9.10.2020.
//  Copyright © 2020 Marcus Ziadé. All rights reserved.
//

import SwiftUI

struct ExperiencePill: ViewModifier {
    
    func body(content: Content) -> some View {
        return content
            .font(.system(size: 20))
            .foregroundColor(.white)
            .frame(width: 80, height: 20, alignment: .leading)
            .padding([.top, .bottom], 3)
            .padding([.leading, .trailing])
            .background(Color.blue)
            .cornerRadius(15)
            .shadow(color: .blue, radius: 2)
    }
}

struct LevelPill: ViewModifier {
    
    func body(content: Content) -> some View {
        return content
            .font(.system(size: 20))
            .foregroundColor(.white)
            .frame(width: 80, height: 20, alignment: .leading)
            .padding([.top, .bottom], 3)
            .padding([.leading, .trailing])
            .background(Color.green)
            .cornerRadius(15)
            .shadow(color: .green, radius: 2)
    }
}

extension Image {
    
    func flagImageMofifier() -> some View {
        self
            .resizable()
            .renderingMode(.original)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.primary, lineWidth: 1))
            .shadow(color: .primary, radius: 2)
    }
}
