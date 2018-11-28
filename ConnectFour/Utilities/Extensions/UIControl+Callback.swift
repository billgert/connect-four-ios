import UIKit

typealias UIControlCallback = () -> ()

class ClosureSleeve {
  let closure: UIControlCallback
  
  init (_ closure: @escaping UIControlCallback) {
    self.closure = closure
  }
  
  @objc func invoke () {
    self.closure()
  }
}

extension UIControl {
  func addAction(for controlEvents: UIControl.Event, _ closure: @escaping UIControlCallback) {
    let sleeve = ClosureSleeve(closure)
    self.addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
    objc_setAssociatedObject(self, String(format: "[%d]", arc4random()), sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
  }
}
