import UIKit

final class NotifyPreferencesRouter {

    weak var viewController: UIViewController!

    private let app: Application

    init(app: Application) {
        self.app = app
    }
}
