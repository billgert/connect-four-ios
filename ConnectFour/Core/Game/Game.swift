import Foundation

class Game {
  // MARK: - Public Properties
  
  public var statusHandler: (Status) -> () = { _ in }
  
  // MARK: - Private Properties

  private var activePlayer: Player?
  
  private var grid: Array2D<Int> = [[]] {
    didSet { self.update() }
  }

  private let columns: Int
  private let rows: Int
  private let playerOne: Player
  private let playerTwo: Player
  
  // MARK: - Lifecycle
  
  init(columns: Int, rows: Int, players: (Player, Player)) {
    self.columns = columns
    self.rows = rows
    self.playerOne = players.0
    self.playerTwo = players.1
  }
  
  // MARK: - Public Functions
  
  @discardableResult
  public func start() throws -> Array2D<Int> {
    guard self.columns > 0 else {
      throw Error.noColumns
    }
    
    self.grid = self.makeInitialGrid()
    
    return self.grid
  }
  
  @discardableResult
  public func dropDiskInColumn(_ column: Int) throws -> Disk {
    guard let player = self.activePlayer else {
      throw Error.activePlayer
    }

    guard let row = self.emptyRow(in: column) else {
      throw Error.columnFull
    }

    let disk = Disk(
      coordinate: Disk.Coordinate(column: column, row: row),
      color: player.color
    )
    
    let slot = player == self.playerOne ? 1 : 2
    
    self.grid[column][row] = slot
    
    return disk
  }
  
  // MARK: - State Logic
  
  private func update() {
    if self.isFourInRow() {
      self.statusHandler(.finished(winner: self.activePlayer))
    } else if self.isFinished() {
      self.statusHandler(.finished(winner: nil))
    } else {
      self.activePlayer = self.switchActivePlayer()
      self.statusHandler(.active(self.activePlayer!))
    }
  }
  
  private func switchActivePlayer() -> Player? {
    return self.activePlayer == self.playerOne ? self.playerTwo : self.playerOne
  }
  
  // MARK: - Game Logic
  
  private func isFinished() -> Bool {
    for column in self.grid {
      if column.contains(where: { $0 == 0 } ) {
        return false
      }
    }
    
    return true
  }
  
  private func isFourInRow() -> Bool {
    let height = self.rows
    let width = self.columns
    let emptySlot = 0
    
    for column in 0..<width { // Iterate on columns from left to right
      for row in 0..<height { // Iterate on rows in column from bottom to top
        let slot = self.grid[column][row]
        
        guard slot != emptySlot else {
          continue
        }
        
         // Look up
        if row + 3 < self.rows &&
          slot == self.grid[column][row + 1] &&
          slot == self.grid[column][row + 2] &&
          slot == self.grid[column][row + 3] {
          print("vertical: \(self.grid)")
          return true
        }
        
        if column + 3 < self.columns {
          // Look right
          if slot == self.grid[column + 1][row] &&
            slot == self.grid[column + 2][row] &&
            slot == self.grid[column + 3][row] {
            print("horizontal: \(self.grid)")
            return true
          }
          
          // Look up & right
          if row + 3 < self.rows &&
            slot == self.grid[column + 1][row + 1] &&
            slot == self.grid[column + 2][row + 2] &&
            slot == self.grid[column + 3][row + 3] {
            print("diagonal right: \(self.grid)")
            return true
          }
          
          // Look up & left
          if row - 3 >= 0 &&
            slot == self.grid[column + 1][row - 1] &&
            slot == self.grid[column + 2][row - 2] &&
            slot == self.grid[column + 3][row - 3] {
            print("diagonal left: \(self.grid)")
            return true
          }
        }
      }
    }

    return false
  }
  
  // MARK: - Helpers
  
  private func emptyRow(in column: Int) -> Int? {
    let height = self.rows

    for row in 0..<height {
      let slot = self.grid[column][row]
      if slot == 0 {
        return row
      }
    }
    
    return nil
  }
}

// MARK: - Factory

extension Game {
  private func makeInitialGrid() -> Array2D<Int> {
    return Array(
      repeating: Array(
        repeating: 0,
        count: self.rows
      ),
      count: self.columns
    )
  }
}









