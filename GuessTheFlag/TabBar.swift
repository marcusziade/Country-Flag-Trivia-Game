//
//  TabBar.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 15.10.2019.
//  Copyright © 2019 Marcus Ziadé. All rights reserved.
//

import SwiftUI

struct TabBar: View {

    init() {
        UITabBar.appearance().barTintColor = UIColor.black
    }
    
    var body: some View {
        TabView {
            EuropeFlags().tabItem {
                Image(systemName: "globe")
                Text("Europe")
            }.tag(1)
            
            AsiaFlags().tabItem {
                Image(systemName: "globe")
                Text("Asia")
            }.tag(2)
            
            AfricaFlags().tabItem {
                Image(systemName: "globe")
                Text("Africa")
                    
            }.tag(3)
            
            AmericaFlags().tabItem {
                Image(systemName: "globe")
                Text("Americas")
                    
            }.tag(4)
                
            WorldFlags().tabItem {
                Image(systemName: "globe")
                Text("World")
                    
            }.tag(5)
        }
        .accentColor(.white)
        .edgesIgnoringSafeArea(.top)
            
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
