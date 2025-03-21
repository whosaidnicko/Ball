import UIKit

extension UIButton {
    func addCustomAction(_ action: @escaping () -> Void) {
        self.addAction(.init(handler: { _ in
            let impactMedia = UIImpactFeedbackGenerator(style: .medium)
            impactMedia.impactOccurred()
            action()
        }), for: .touchUpInside)
    }
}
