import Foundation

class Game {
  // MARK: - Public Properties
  
  public var statusHandler: (Status) -> () = { _ in }
  
  public var playerOne: Player?
  public var playerTwo: Player?
  
  // MARK: - Private Properties
  
  private var player: Player?
  
  private var grid = Observable<[[Disk?]]>(value: [[]])
  private var disks: [Disk] = [] // Available disks that are not inserted in to the grid
  
  private let columns: Int
  private let rows: Int
  
  // MARK: - Lifecycle
  
  init(columns: Int, rows: Int) {
    self.columns = columns
    self.rows = rows

    self.grid.subscribe { [unowned self] grid in
      if self.isFourInRow() {
        self.statusHandler(.finished(winner: self.player))
      } else if self.isFinished() {
        let winner = self.isFourInRow() ? self.player : nil
        self.statusHandler(.finished(winner: winner))
      } else if self.isStart() {
        self.statusHandler(.start(self.player!))
      } else {
        self.player = try? self.switchPlayer()
        self.statusHandler(.active(self.player!))
      }
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
    // When this is done we return a Disk to update the UI
    return Disk(location: nil, color: nil)
  }
  
  // MARK: - Helpers
  
  private func isStart() -> Bool {
    return self.disks.count != 0 && self.disks.count == (self.columns * self.rows)
  }
  
  private func isFinished() -> Bool {
    return self.grid.value!.contains(where: {
      return $0.contains(where: { $0 != nil } )
    })
  }
  
  private func isFourInRow() -> Bool {
    // Check if we have a match in diagonal, vertical or horizontal on self.grid
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
  private func makeInitialGrid() -> [[Disk?]] {
    return Array(
      repeating: Array(
        repeating: nil,
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









