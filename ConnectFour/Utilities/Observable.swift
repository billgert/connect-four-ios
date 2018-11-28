import Foundation

class Observable<T> {
  typealias ObservableCallback = ((T) -> Void)
  
  struct Subscription {
    var identifier: String?
    var callback: ObservableCallback = { _ in }
  }
  
  private var subscriptions: [Subscription] = []
  
  /** Set the generic value and trigger your subscriptions. */
  public var value: T? {
    didSet {
      guard let value = self.value else { return }
      self.subscriptions.forEach { $0.callback(value) }
    }
  }
  
  convenience init(value: T?) {
    self.init()
    self.value = value
  }
  
  public func subscribe(_ object: AnyObject? = nil,
                        trigger: Bool = false,
                        callback: @escaping ObservableCallback) {
    let subscription = Subscription(identifier: String.pointer(object), callback: callback)
    self.subscriptions.append(subscription)
    if trigger {
      guard let value = self.value else { return }
      subscription.callback(value)
    }
  }
  
  public func unsubscribeAll() {
    self.subscriptions.removeAll()
  }
  
  public func unsubscribe(_ object: AnyObject) {
    let objectIdentifer = String.pointer(object)
    self.subscriptions.removeAll(where: { $0.identifier == objectIdentifer })
  }
}
