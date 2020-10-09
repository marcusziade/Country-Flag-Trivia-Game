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
            .padding(.top, 3)
            .padding(.bottom, 3)
            .padding(.trailing)
            .padding(.leading)
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
            .padding(.top, 3)
            .padding(.bottom, 3)
            .padding(.trailing)
            .padding(.leading)
            .background(Color.green)
            .cornerRadius(15)
            .shadow(color: .green, radius: 2)
    }
}
