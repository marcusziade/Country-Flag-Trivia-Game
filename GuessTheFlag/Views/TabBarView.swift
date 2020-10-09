//
//  TabBarView.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 9.10.2020.
//  Copyright © 2020 Marcus Ziadé. All rights reserved.
//

import SwiftUI

struct TabBarView: View {
    
    init() {
        UITabBar.appearance().barTintColor = UIColor.black
    }
    
    var body: some View {
        TabView {
            FlagsGameView().tabItem {
                Image(systemName: "globe")
                Text("Countries")
            }.tag(1)
        }
        .accentColor(.white)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TabBarView()
            TabBarView()
                .preferredColorScheme(.dark)
                .previewDevice("iPhone SE (1st generation)")
        }
    }
}
