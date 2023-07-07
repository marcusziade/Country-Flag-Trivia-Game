import XCTest

@testable import Master_of_Flags

final class UIViewControllerExtensionTests: XCTestCase {
    
    func testInstall() {
        let testCases = [
            ("Case1: Correct Install", true),
            ("Case2: Incorrect Install", false)
        ]
        
        for testCase in testCases {
            let (description, shouldInstall) = testCase
            let parentVC = UIViewController()
            let childVC = UIViewController()
            
            let view = UIView()
            let constraints = [
                childVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                childVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                childVC.view.topAnchor.constraint(equalTo: view.topAnchor),
                childVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ]
            
            if shouldInstall {
                parentVC.install(childVC, to: view, with: constraints)
            }
            
            XCTAssertEqual(parentVC.children.contains(childVC), shouldInstall, description)
            XCTAssertEqual(view.subviews.contains(childVC.view), shouldInstall, description)
        }
    }
    
    func testUnInstall() {
        let testCases = [
            ("Case1: Correct Uninstall", true),
            ("Case2: Incorrect Uninstall", false)
        ]
        
        for testCase in testCases {
            let (description, shouldUninstall) = testCase
            let parentVC = UIViewController()
            let childVC = UIViewController()
            
            let view = UIView()
            let constraints = [
                childVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                childVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                childVC.view.topAnchor.constraint(equalTo: view.topAnchor),
                childVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ]
            
            parentVC.install(childVC, to: view, with: constraints)
            
            if shouldUninstall {
                parentVC.unInstall(childVC, with: constraints)
            }
            
            XCTAssertEqual(!parentVC.children.contains(childVC), shouldUninstall, description)
            XCTAssertEqual(!view.subviews.contains(childVC.view), shouldUninstall, description)
        }
    }
}
