//
//  SettingsHardModeCell.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 24.4.2022.
//  Copyright © 2022 Marcus Ziadé. All rights reserved.
//

import Foundation
import UIKit

final class SettingsHardModeCell: SettingsCell {
    
    var onHardModeToggled: ((Bool) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addAndConstrainSubview(toggleView) {
            $0.top.right.bottom.equalToSuperview().inset(16)
        }
    }
    
    func configure(with item: SettingsItem, isEnabled: Bool) {
        itemBadgeView.configure(
            with: UIImage(systemName: item.image)!,
            color: item.color
        )
        titleLabel.text = item.title
        toggleView.isOn = isEnabled
    }
    
    // MARK: - Private
    
    private lazy var toggleView = UISwitch().configure {
        $0.addTarget(self, action: #selector(hardModeToggled), for: .valueChanged)
    }
    
    @objc private func hardModeToggled() {
        onHardModeToggled?(toggleView.isOn)
    }
}
