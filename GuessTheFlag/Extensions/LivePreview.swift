//
//  LivePreview.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 17.10.2020.
//  Copyright © 2020 Marcus Ziadé. All rights reserved.
//

import SwiftUI

private struct UIViewControllerPreviewContainer<T: UIViewController> : UIViewControllerRepresentable {
    var viewController: T
    
    func makeUIViewController(context: Context) -> T {
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: T, context: Context) {
    }
}

private struct UIViewPreviewContainer<T: UIView> : UIViewRepresentable {
    var view: T
    
    func makeUIView(context: Context) -> T {
        return view
    }
    
    func updateUIView(_ uiView: T, context: Context) {
    }
}

extension PreviewProvider {
    static func createPreview(for viewController: UIViewController, mode colorScheme: ColorScheme? = .light) -> some View {
        UIViewControllerPreviewContainer(viewController: viewController)
            .previewDevice(PreviewDevice("iPhone 11 Pro"))
            .preferredColorScheme(colorScheme)
            .edgesIgnoringSafeArea(.all)
    }
    
    static func createPreview(for view: UIView, mode colorScheme: ColorScheme? = .light, width: CGFloat, height: CGFloat) -> some View {
        UIViewPreviewContainer(view: view)
            .previewLayout(.fixed(width: width, height: height))
            .preferredColorScheme(colorScheme)
    }
}
