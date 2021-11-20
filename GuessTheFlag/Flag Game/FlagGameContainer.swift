//
//  FlagGameContainer.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 15.10.2019.
//  Copyright © 2019 Marcus Ziadé. All rights reserved.
//

import SwiftUI
import Combine

struct FlagGameContainer: View {
    
    @StateObject var manager: FlagGameManager
    
    var body: some View {
        VStack {
            Picker(selection: $manager.activePickerValue, label: Text("Pick region")) {
                ForEach(0 ..< manager.regions.count) {
                    Text(manager.regions[$0].title)
                }
            }
            .onReceive(Just(manager.selectedRegion)) { _ in
                UISelectionFeedbackGenerator().selectionChanged()
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal, 4)
            
            FlagGameView(manager: manager)
            
        }
        .padding(.bottom, 4)
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FlagGameContainer(manager: FlagGameManager())
            FlagGameContainer(manager: FlagGameManager())
                .preferredColorScheme(.dark)
                .previewDevice("iPhone SE (1st generation)")
        }
    }
}
