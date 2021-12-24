//
//  SettingsView.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 21.11.2021.
//  Copyright © 2021 Marcus Ziadé. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject var model: SettingsViewModel
    
    var body: some View {
        NavigationView {
            List {
                Section("Flag Game") {
                    Toggle("Hard Mode", isOn: $model.isHardModeEnabled)
                    Text("Hard mode increases the amount of flag options, making the game more difficult")
                }                
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(model: SettingsViewModel())
    }
}
