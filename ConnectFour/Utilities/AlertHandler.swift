import UIKit

protocol AlertHandler {
  func presentAlert(title: String?, message: String?)
}

extension AlertHandler where Self: UIViewController {
  func presentAlert(title: String?, message: String?) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: "OK", style: .cancel))
    self.present(alertController, animated: true)
  }
}
