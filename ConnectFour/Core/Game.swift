import Foundation

class Game {
  // MARK: - Public Properties
  
  public var statusHandler: (Status) -> () = { _ in }
  
  public var playerOne: Player?
  public var playerTwo: Player?
  
  // MARK: - Private Properties

  private var activePlayer: Player?
  
  private var grid = Observable<[[Int]]>(value: [[]])

  private let columns: Int
  private let rows: Int
  
  // MARK: - Lifecycle
  
  init(columns: Int, rows: Int) {
    self.columns = columns
    self.rows = rows

    self.grid.subscribe { [unowned self] grid in
      if self.isFourInRow() {
        self.statusHandler(.finished(winner: self.activePlayer))
      } else if self.isFinished() {
        self.statusHandler(.finished(winner: nil))
      } else {
        self.activePlayer = self.switchActivePlayer()
        self.statusHandler(.active(self.activePlayer!))
      }
    }
  }
  
  // MARK: - Public Functions
  
  public func start() throws {
    guard self.playerOne != nil && self.playerTwo != nil else {
      throw Error.players
    }
    
    guard self.columns > 0 else {
      throw Error.noColumns
    }
    
    self.grid.value = self.makeInitialGrid()
  }
  
  public func dropDiskInColumn(_ column: Int) throws {
    guard let emptySlot = self.emptyRow(in: column) else {
      throw Error.columnFull
    }

    let disk = self.activePlayer == self.playerOne ? 1 : 2

    self.grid.value![column][emptySlot] = disk
  }
  
  // MARK: - Helpers
  
  private func switchActivePlayer() -> Player? {
    return self.activePlayer == self.playerOne ? self.playerTwo : self.playerOne
  }
  
  private func isStart() -> Bool {
    for column in self.grid.value! {
      if column.contains(where: { $0 != 0 } ) {
        return false
      }
    }
    
    return true
  }

  private func isFinished() -> Bool {
    for column in self.grid.value! {
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
    
    guard let grid = self.grid.value else {
      return false
    }
    
    for column in 0..<width { // Iterate on columns from left to right
      for row in 0..<height { // Iterate on rows in column from bottom to top
        
        let slot = grid[column][row]
        
        if slot == emptySlot {
          continue
        }
        
         // Vertical (up)
        if row + 3 < self.rows &&
          slot == grid[column][row + 1] &&
          slot == grid[column][row + 2] &&
          slot == grid[column][row + 3] {
          print(grid)
          return true
        }
        
        if column + 3 < self.columns {
          // Horizontal (right)
          if slot == grid[column + 1][row] &&
            slot == grid[column + 2][row] &&
            slot == grid[column + 3][row] {
            print(grid)
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
      let slot = self.grid.value![column][row]
      if slot == 0 {
        return row
      }
    }
    
    return nil
  }
}

// MARK: - Factory

extension Game {
  private func makeInitialGrid() -> [[Int]] { // 0, 1 och 2 (player 1 och 2)
    return Array(
      repeating: Array(
        repeating: 0,
        count: self.rows
      ),
      count: self.columns
    )
  }
}









