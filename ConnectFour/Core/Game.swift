import Foundation

class Game {
  // MARK: - Public Properties
  
  public var statusHandler: (Status) -> () = { _ in }
  
  public var playerOne: Player?
  public var playerTwo: Player?
  
  // MARK: - Private Properties
  
  private var player: Player?
  
  public var grid = Observable<[[Disk?]]>(value: [[]])
  public var disks: [Disk] = [] // Available disks that are not inserted in to the grid
  
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
      throw Error.noColumns
    }
    
    self.disks = self.makeInitialDisks()
    self.grid.value = self.makeInitialGrid()
  }
  
  @discardableResult
  public func dropDisk(in column: Int) throws -> Disk {
    let gridColumn = self.grid.value![column]

    guard let emptyRow = gridColumn.firstIndex(where: { $0 == nil } ) else {
      throw Error.columnFull
    }
    
    guard var disk = self.disks.first(where: { $0.color == self.player!.color }) else {
      throw Error.noDisksLeft
    }
    
    disk.location = Disk.Location(column: column, row: emptyRow)

    self.grid.value![column][emptyRow] = disk
    
    return disk
  }
  
  // MARK: - Helpers
  
  private func isStart() -> Bool {
    return self.disks.count != 0 && (self.disks.count == (self.columns * self.rows))
  }

  private func isFinished() -> Bool {
    for column in self.grid.value! {
      if column.contains(where: { $0 == nil } ) {
        return false
      }
    }

    return true
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
        count: self.rows
      ),
      count: self.columns
    )
  }
  
  private func makeInitialDisks() -> [Disk] {
    let playerDisksCount = (self.columns * self.rows) / 2
    let playerOneDisks = Array(repeating: Disk(location: nil, color: self.playerOne!.color), count: playerDisksCount)
    let playerTwoDisks = Array(repeating: Disk(location: nil, color: self.playerTwo!.color), count: playerDisksCount)
    return playerOneDisks + playerTwoDisks
  }
}









