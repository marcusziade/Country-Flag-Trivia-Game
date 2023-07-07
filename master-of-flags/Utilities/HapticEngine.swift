import UIKit

final class HapticEngine {
    static let soft = UIImpactFeedbackGenerator(style: .soft)
    static let notification = UINotificationFeedbackGenerator()
    static let rigid = UIImpactFeedbackGenerator(style: .rigid)
    static let select = UISelectionFeedbackGenerator()
    static let result = UINotificationFeedbackGenerator()
}
