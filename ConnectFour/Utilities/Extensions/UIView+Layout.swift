import UIKit

extension UIView {
  func addSubview(_ subview: UIView, constraints: [NSLayoutConstraint]) {
    self.addSubview(subview)
    subview.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate(constraints)
  }
}
