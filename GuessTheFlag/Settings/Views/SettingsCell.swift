//
//  SettingsCell.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 24.4.2022.
//  Copyright © 2022 Marcus Ziadé. All rights reserved.
//

import Foundation
import SnapKit
import UIKit

class SettingsCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let stackView = UIStackView(arrangedSubviews: [itemBadgeView, titleLabel]).configure {
            $0.spacing = 12
            $0.alignment = .center
        }
        
        contentView.addAndConstrainSubview(stackView) {
            $0.edges.equalToSuperview().inset(16)
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let itemBadgeView = SettingsItemBadgeView()
    
    let titleLabel = UILabel().configure {
#if DEBUG
        $0.text = "Item title"
#endif
    }
}
