import Foundation

class GameCore {
  // MARK: - Public Properties
  
  public var status: (GameStatus) -> () = { _ in }
  
  public var playerOne: GamePlayer?
  public var playerTwo: GamePlayer?
  
  // MARK: - Private Properties
  
  private var player: GamePlayer?
  
  private lazy var bricksGrid = Observable<[[GameBrick]]>(value: self.initialBricksGrid())
  private lazy var availableBricks: [GameBrick] = self.initialAvailableBricks()
  
  private let numberOfColumns: Int
  private let numberOfRows: Int
  
  // MARK: - Lifecycle
  
  init(numberOfColumns: Int, numberOfRows: Int) {
    self.numberOfColumns = numberOfColumns
    self.numberOfRows = numberOfRows

    self.bricksGrid.subscribe { grid in
      // Check if we have a match in diagonal, vertical or horizontal
      // If no match we call switchPlayer()
      // Always update status
    }
  }
  
  // MARK: - Public Functions
  
  public func start() {
    // Check if there is two players
    // If so reset()
  }
  
  public func insertBrick(at column: Int) throws -> GameBrick {
    // Check if the column in bricksGrid contains less bricks than numberOfRows
    // Check if there is a brick left in availableBricks for the current player
    // If so we take out the next empty location in the column
    // We add the location to the brick
    // Then we move the brick to the bricksGrid by replacing the empty one at the location
    // When this is done we return a GameBrick to update the UI
  }
  
  // MARK: - Private Functions
  
  private func reset() {
    // Set all bricksGrid and availableBricks to it's initial values
  }
  
  private func switchPlayer() {
    // Toggle the active player
  }
  
  private func initialAvailableBricks() -> [GameBrick] {
    // Create two arrays with the size of (numberOfColumns * numberOfRows) / 2
    // Fill up the arrays with GameBrick adding both the players colors
    // Return the arrays flattened by flatMap
  }
  
  private func initialBricksGrid() -> [[GameBrick]] {
    return Array(
      repeating: Array(
        repeating: GameBrick(location: nil, color: nil),
        count: self.numberOfColumns
      ),
      count: self.numberOfRows
    )
  }
}

struct GameBrick {
  struct Location {
    let column: Int
    let row: Int
  }
  
  let location: Location?
  let color: String?
}

struct GamePlayer {
  let name: String
  let color: String
}

enum GameStatus {
  case finished(winner: GamePlayer?)
  case ongoing(current: GamePlayer)
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





