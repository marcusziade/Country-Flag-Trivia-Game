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
                Section {
                    Toggle("Enable Haptics", isOn: $model.isHapticsEnabled)
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
