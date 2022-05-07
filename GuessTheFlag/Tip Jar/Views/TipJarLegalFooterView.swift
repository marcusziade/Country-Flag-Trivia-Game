//
//  TipJarLegalFooterView.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 7.5.2022.
//  Copyright © 2022 Marcus Ziadé. All rights reserved.
//

import Foundation
import SnapKit
import UIKit

final class TipJarLegalFooterView: UICollectionReusableView {
    
    var onPolicyPressed: (() -> Void)?
    var onTermsPressed: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let buttonStackView = UIStackView(arrangedSubviews: [policyButton, termsButton]).configure {
            $0.spacing = 32
        }
        
        let contentStackView = UIStackView(arrangedSubviews: [captionLabel, buttonStackView]).configure {
            $0.axis = .vertical
            $0.alignment = .center
            $0.spacing = 24
        }
        
        addAndConstrainSubview(contentStackView) {
            $0.top.equalToSuperview().inset(32)
            $0.horizontalEdges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    private let captionLabel = UILabel().configure {
        $0.font = UIFont.preferredFont(forTextStyle: .footnote)
        $0.text = NSLocalizedString("Payments will be charged to your Apple Account after confirmation", comment: "")
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.textColor = .white
    }
    
    private lazy var policyButton = UIButton(
        configuration: .tipJarLegal(with: "Privacy policy"),
        primaryAction: .init(handler: { [unowned self] _ in onPolicyPressed?() })
    )
    
    private lazy var termsButton = UIButton(
        configuration: .tipJarLegal(with: "Terms of use"),
        primaryAction: .init(handler: { [unowned self] _ in onTermsPressed?() })
    )
}

#if DEBUG

import SwiftUI

struct TipJarFooterCell_Preview: PreviewProvider {
    static var previews: some View = Preview(for: TipJarLegalFooterView())
        .previewLayout(.fixed(width: 400, height: 150))
        .preferredColorScheme(.dark)
}

#endif
