import Foundation

class GameCore {
  // MARK: - Public Properties
  
  public var status: (Status) -> () = { _ in }
  
  public var playerOne: Player?
  public var playerTwo: Player?
  
  // MARK: - Private Properties
  
  private var player: Player?
  
  private lazy var grid = Observable<[[Disk]]>(value: self.initialGrid())
  private lazy var disks: [Disk] = self.initialDisks() // Available disks that are not inserted in to the grid
  
  private let columns: Int
  private let rows: Int
  
  // MARK: - Lifecycle
  
  init(columns: Int, rows: Int) {
    self.columns = columns
    self.rows = rows

    self.grid.subscribe { grid in
      // Check if we have a match in diagonal, vertical or horizontal
      // If no match we call switchPlayer()
      // Always update status
    }
  }
  
  // MARK: - Public Functions
  
  public func start() {
    // Check if there is two players
    // Set all grid and availableDisks to it's initial values
    self.grid = Observable<[[Disk]]>(value: self.initialGrid())
    self.disks = self.initialDisks()
  }
  
  public func insertDisk(at column: Int) throws -> Disk {
    // Check if the column in grid contains less disks than rows
    // Check if there is a disk left in disks for the current player
    // If so we take out the next empty location in the column
    // We add the location to the disk
    // Then we move the disk to the grid by replacing the empty one at the location
    // When this is done we return a Disk to update the UI
  }
  
  // MARK: - Private Functions
  
  private func switchPlayer() {
    // Toggle the active player
  }
  
  private func initialDisks() -> [Disk] {
    // Create two arrays with the size of (columns * rows) / 2
    // Fill up the arrays with Disk adding both the players colors
    // Return the arrays flattened by flatMap
  }
  
  private func initialGrid() -> [[Disk]] {
    return Array(
      repeating: Array(
        repeating: Disk(location: nil, color: nil),
        count: self.columns
      ),
      count: self.rows
    )
  }
}

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
                        triggerCallback: Bool = false,
                        callback: @escaping ObservableCallback) {
    let subscription = Subscription(identifier: String.pointer(object), callback: callback)
    self.subscriptions.append(subscription)
    if triggerCallback {
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

extension String {
  static func pointer(_ object: AnyObject?) -> String {
    guard let object = object else { return "nil" }
    let opaque: UnsafeMutableRawPointer = Unmanaged.passUnretained(object).toOpaque()
    return String(describing: opaque)
  }
}





