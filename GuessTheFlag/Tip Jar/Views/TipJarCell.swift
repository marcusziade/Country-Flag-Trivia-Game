//
//  TipJarCell.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 30.4.2022.
//  Copyright © 2022 Marcus Ziadé. All rights reserved.
//

import Foundation
import Lottie
import SnapKit
import UIKit

final class TipJarCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addShadow()
        
        contentView.addAndConstrainSubview(animationView) {
            $0.top.horizontalEdges.equalToSuperview()
        }
        
        contentView.addAndConstrainSubview(titleLabelContainerView) {
            $0.top.equalTo(animationView.snp.bottom)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with product: TipJarProductProtocol) {
        animationView.animation = Animation.named(product.animation)
        animationView.play()
        animationView.loopMode = .loop
        
        titleLabel.text = product.title
        priceLabel.text = product.price
        titleLabelContainerView.backgroundColor = product.color
    }
    
    // MARK: - Private
    
    private let animationView = AnimationView().configure {
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 12
        $0.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    private lazy var titleLabelContainerView = UIView().configure {
        $0.layer.cornerRadius = 12
        $0.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, priceLabel]).configure {
            $0.axis = .vertical
            $0.spacing = 4
            $0.distribution = .fillEqually
            $0.alignment = .center
        }
        
        $0.addAndConstrainSubview(stackView) {
            $0.verticalEdges.equalToSuperview().inset(8)
            $0.horizontalEdges.equalToSuperview().inset(12)
        }
    }
    
    private let titleLabel = UILabel().configure {
        $0.font = UIFont.preferredFont(forTextStyle: .title3, compatibleWith: .init(legibilityWeight: .bold))
        $0.textColor = .white
    }
    
    private let priceLabel = UILabel().configure {
        $0.font = UIFont.preferredFont(forTextStyle: .headline)
        $0.textColor = .white
    }
}

#if DEBUG

import SwiftUI

struct TipJarCell_Preview: PreviewProvider {
    
    static var previews: some View = Preview(for: TipJarCell().configure { $0.configure(with: MockTipJarProduct()) })
        .previewLayout(.fixed(width: 350, height: 400))
        .preferredColorScheme(.light)
        .padding()
}

#endif
