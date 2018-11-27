import Foundation

class Game {
  // MARK: - Public Properties
  
  public var statusHandler: (Status) -> () = { _ in }
  
  public var playerOne: Player?
  public var playerTwo: Player?
  
  // MARK: - Private Properties

  private var activePlayer: Player?
  
  private var grid: [[Int]] = [[]] {
    didSet { self.update() }
  }

  private let columns: Int
  private let rows: Int
  
  // MARK: - Lifecycle
  
  init(columns: Int, rows: Int) {
    self.columns = columns
    self.rows = rows
  }
  
  // MARK: - Public Functions
  
  public func start() throws {
    guard self.playerOne != nil && self.playerTwo != nil else {
      throw Error.players
    }
    
    guard self.columns > 0 else {
      throw Error.noColumns
    }
    
    self.grid = self.makeInitialGrid()
  }
  
  public func dropDiskInColumn(_ column: Int) throws {
    guard let row = self.emptyRow(in: column) else {
      throw Error.columnFull
    }

    let disk = self.activePlayer == self.playerOne ? 1 : 2

    self.grid[column][row] = disk
  }
  
  // MARK: - Helpers
  
  private func update() {
    if self.isFourInRow() {
      self.statusHandler(.finished(winner: self.activePlayer))
    } else if self.isFinished() {
      self.statusHandler(.finished(winner: nil)) // test
    } else {
      self.activePlayer = self.switchActivePlayer()
      self.statusHandler(.active(self.activePlayer!)) // test
    }
  }
  
  private func switchActivePlayer() -> Player? {
    return self.activePlayer == self.playerOne ? self.playerTwo : self.playerOne
  }
  
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
  private func makeInitialGrid() -> [[Int]] {
    return Array(
      repeating: Array(
        repeating: 0,
        count: self.rows
      ),
      count: self.columns
    )
  }
}









