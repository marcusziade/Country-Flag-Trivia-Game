//
//  FlagsGameView.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 15.10.2019.
//  Copyright © 2019 Marcus Ziadé. All rights reserved.
//

import SwiftUI
import Combine

struct FlagsGameView: View {
    
    var regions = ["Europe", "Asia", "Africa", "Americas", "World"]
    @State private var selectedRegion = 0
    
    var body: some View {
        VStack {
            Picker(selection: $selectedRegion, label: Text("Pick region")) {
                ForEach( 0 ..< regions.count) {
                    Text(regions[$0])
                }
            }
            .onReceive(Just(selectedRegion), perform: { _ in
                UISelectionFeedbackGenerator().selectionChanged()
            })
            .pickerStyle(SegmentedPickerStyle())
            .padding([.leading, .trailing], 4)
            
            switch selectedRegion {
                case 0:
                    EuropeFlags()
                case 1:
                    AsiaFlags()
                case 2:
                    AfricaFlags()
                case 3:
                    AmericaFlags()
                default:
                    WorldFlags()
            }
        }
        .padding(.bottom, 4)
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FlagsGameView()
            FlagsGameView()
                .preferredColorScheme(.dark)
                .previewDevice("iPhone SE (1st generation)")
        }
    }
}
