import UIKit
import WalletConnectNotify

final class PushMessagesRouter {

    weak var viewController: UIViewController!

    private let app: Application

    init(app: Application) {
        self.app = app
    }

    func dismiss() {
        viewController.pop()
    }

    func presentPreferences(subscription: NotifySubscription) {
        let controller = NotifyPreferencesModule.create(app: app, subscription: subscription)
        controller.sheetPresentationController?.detents = [.medium()]
        controller.sheetPresentationController?.prefersGrabberVisible = true
        controller.present(from: viewController)
    }
}
