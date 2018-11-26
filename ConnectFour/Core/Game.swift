import Foundation

class Game {
  // MARK: - Public Properties
  
  public var statusHandler: (Status) -> () = { _ in }
  
  public var playerOne: Player?
  public var playerTwo: Player?
  
  // MARK: - Private Properties
  
  private var player: Player?
  
  private var grid = Observable<[[Disk]]>(value: [[]])
  private var disks: [Disk] = [] // Available disks that are not inserted in to the grid
  
  private let columns: Int
  private let rows: Int
  
  // MARK: - Lifecycle
  
  init(columns: Int, rows: Int) {
    self.columns = columns
    self.rows = rows

    self.grid.subscribe { [unowned self] grid in
      let status = self.currentStatus()
      self.statusHandler(status)
    }
  }
  
  // MARK: - Public Functions
  
  public func start() throws {
    self.player = try self.switchPlayer()
    
    guard self.columns > 0 else {
      throw Error.columns
    }
    
    self.grid.value = self.makeInitialGrid()
    self.disks = self.makeInitialDisks()
  }
  
  public func dropDisk(in column: Int) throws -> Disk {
    // Check if the column in grid contains less disks than rows
    // Check if there is a disk left in disks for the current player (check color)
    // If so we take out the next empty location in the column
    // We add the location to the disk
    // Then we move the disk to the grid by replacing the empty one at the location
    // Before returning the disk we call switchPlayer()
    // When this is done we return a Disk to update the UI
    return Disk(location: nil, color: nil)
  }
  
  // MARK: - Helpers
  
  private func currentStatus() -> Status {
    if self.columns > 0 {
      return .start(self.player!)
    } else if self.isFourInRow(self.grid.value!) {
      return .win(self.player!)
    } else if self.disks.count == 0 {
      return .draw
    } else {
      return .active(self.player!)
    }
  }
  
  private func isFourInRow(_ grid: [[Disk]]) -> Bool {
    // Check if we have a match in diagonal, vertical or horizontal
    return false
  }
  
  private func switchPlayer() throws -> Player {
    guard self.playerOne != nil && self.playerTwo != nil else {
      throw Error.players
    }
    
    return (self.player == self.playerOne) ? self.playerTwo! : self.playerOne!
  }
}

// MARK: - Factory

extension Game {
  private func makeInitialGrid() -> [[Disk]] {
    return Array(
      repeating: Array(
        repeating: Disk(location: nil, color: nil),
        count: self.columns
      ),
      count: self.rows
    )
  }
  
  // Create two arrays with the size of (columns * rows) / 2
  // Fill up the arrays with Disk adding both the players colors
  // Return the arrays flattened by flatMap
  private func makeInitialDisks() -> [Disk] {
    let disks: [Disk] = []
    return disks
  }
}









