//
//  Settings.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 28.10.2019.
//  Copyright © 2019 Marcus Ziadé. All rights reserved.
//

import SwiftUI

struct Settings: View {
    var body: some View {
        VStack {
            NavigationView {
                Form {
                    Section(header: Text("General")) {
                        Text("Haptic Feedback")
                        Text("Haptic Feedback")
                        Text("Haptic Feedback")
                        Text("Haptic Feedback")
                    }
                    
                    Section(header: Text("General")) {
                        Text("Haptic Feedback")
                        Text("Haptic Feedback")
                        Text("Haptic Feedback")
                        Text("Haptic Feedback")
                    }
                }.navigationBarTitle("Settings")
            }
        }
        
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
