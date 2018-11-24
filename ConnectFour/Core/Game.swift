import Foundation

class Game {
  // MARK: - Public Properties
  
  public var status: (Status) -> () = { _ in }
  
  public var playerOne: Player?
  public var playerTwo: Player?
  
  // MARK: - Private Properties
  
  private var player: Player?
  
  private lazy var grid = Observable<[[Disk]]>(value: self.makeInitialGrid())
  private lazy var disks: [Disk] = self.makeInitialDisks() // Available disks that are not inserted in to the grid
  
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
    self.grid = Observable<[[Disk]]>(value: self.makeInitialGrid())
    self.disks = self.makeInitialDisks()
  }
  
  public func dropDisk(in column: Int) throws -> Disk {
    // Check if the column in grid contains less disks than rows
    // Check if there is a disk left in disks for the current player
    // If so we take out the next empty location in the column
    // We add the location to the disk
    // Then we move the disk to the grid by replacing the empty one at the location
    // When this is done we return a Disk to update the UI
    return Disk(location: nil, color: nil)
  }
  
  // MARK: - Private Functions
  
  private func isFourDisksInRow() -> Bool {
    return false
  }
  
  private func switchPlayer() {
    // Toggle the active player
  }
}

// MARK: - Factory

extension Game {
  private func makeInitialDisks() -> [Disk] {
    // Create two arrays with the size of (columns * rows) / 2
    // Fill up the arrays with Disk adding both the players colors
    // Return the arrays flattened by flatMap
    return []
  }
  
  private func makeInitialGrid() -> [[Disk]] {
    return Array(
      repeating: Array(
        repeating: Disk(location: nil, color: nil),
        count: self.columns
      ),
      count: self.rows
    )
  }
}









