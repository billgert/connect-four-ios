import XCTest

@testable import ConnectFour

class GameTests: XCTestCase {
  var playerOne: Player!
  var playerTwo: Player!
  
  override func setUp() {
    self.playerOne = Player(name: "Sue", color: "#FF0000")
    self.playerTwo = Player(name: "Henry", color: "#0000FF")
  }
  
  override func tearDown() {
    self.playerOne = nil
    self.playerTwo = nil
  }
  
  // MARK: - start

  func testGameStartHasNoColumns() {
    let game = Game(columns: 0, rows: 0, players: (self.playerOne, self.playerTwo))

    XCTAssertThrowsError(try game.start()) { error in
      XCTAssertEqual(error as! Game.Error, Game.Error.noColumns)
    }
  }
  
  // MARK: - dropDiskInColumn
  
  func testGameDropDiskSuccess() {
    let game = Game(columns: 7, rows: 6, players: (self.playerOne, self.playerTwo))
    
    do {
      try game.start()
      try game.dropDiskInColumn(2)
    } catch {
      XCTAssertTrue(false, "testGameDropDiskSuccess: Error")
    }
  }
  
  func testGameDropMultipleDisksSuccess() {
    let game = Game(columns: 7, rows: 6, players: (self.playerOne, self.playerTwo))
    
    do {
      try game.start()
      try game.dropDiskInColumn(2)
      try game.dropDiskInColumn(2)
      try game.dropDiskInColumn(2)
      try game.dropDiskInColumn(2)
    } catch {
      XCTAssertTrue(false, "testGameDropMultipleDisksSuccess: Error")
    }
  }
  
  func testGameDropDiskColumnIsFull() {
    let game = Game(columns: 7, rows: 6, players: (self.playerOne, self.playerTwo))

    do {
      try game.start()
      try game.dropDiskInColumn(2)
      try game.dropDiskInColumn(2)
      try game.dropDiskInColumn(2)
      try game.dropDiskInColumn(2)
      try game.dropDiskInColumn(2)
      try game.dropDiskInColumn(2)
    } catch {
      XCTAssertTrue(false, "testGameDropDiskColumnIsFull: Error")
    }

    XCTAssertThrowsError(try game.dropDiskInColumn(2)) { error in
      XCTAssertEqual(error as! Game.Error, Game.Error.columnFull)
    }
  }
  
  // MARK: - statusHandler
  
  func testGameStatusHandlerIsFourInRowHorizontal() {
    let game = Game(columns: 7, rows: 6, players: (self.playerOne, self.playerTwo))
    
    XCTAssertNoThrow(try game.start())
    XCTAssertNoThrow(try game.dropDiskInColumn(0))
    XCTAssertNoThrow(try game.dropDiskInColumn(0))
    XCTAssertNoThrow(try game.dropDiskInColumn(1))
    XCTAssertNoThrow(try game.dropDiskInColumn(1))
    XCTAssertNoThrow(try game.dropDiskInColumn(2))
    XCTAssertNoThrow(try game.dropDiskInColumn(2))
    
    game.status.subscribe { status in
      switch status {
      case .finished(winner: let player):
        XCTAssertNotNil(player)
      default:
        XCTAssertTrue(false, "testGameStatusHandlerIsFourInRowHorizontal: Error")
      }
    }
    
    XCTAssertNoThrow(try game.dropDiskInColumn(3))
  }
  
  func testGameStatusHandlerIsFourInRowVertical() {
    let game = Game(columns: 7, rows: 6, players: (self.playerOne, self.playerTwo))
    
    XCTAssertNoThrow(try game.start())
    XCTAssertNoThrow(try game.dropDiskInColumn(2))
    XCTAssertNoThrow(try game.dropDiskInColumn(2))
    XCTAssertNoThrow(try game.dropDiskInColumn(2))
    XCTAssertNoThrow(try game.dropDiskInColumn(3))
    XCTAssertNoThrow(try game.dropDiskInColumn(2))
    XCTAssertNoThrow(try game.dropDiskInColumn(3))
    XCTAssertNoThrow(try game.dropDiskInColumn(2))
    XCTAssertNoThrow(try game.dropDiskInColumn(3))
    
    game.status.subscribe { status in
      switch status {
      case .finished(winner: let player):
        XCTAssertNotNil(player)
      default:
        XCTAssertTrue(false, "testGameStatusHandlerIsFourInRowVertical: Error")
      }
    }
    
    XCTAssertNoThrow(try game.dropDiskInColumn(2))
  }
  
  func testGameStatusHandlerIsFourInRowDiagonalRight() {
    let game = Game(columns: 7, rows: 6, players: (self.playerOne, self.playerTwo))
    
    XCTAssertNoThrow(try game.start())
    XCTAssertNoThrow(try game.dropDiskInColumn(6))
    XCTAssertNoThrow(try game.dropDiskInColumn(6))
    XCTAssertNoThrow(try game.dropDiskInColumn(6))
    XCTAssertNoThrow(try game.dropDiskInColumn(6))
    XCTAssertNoThrow(try game.dropDiskInColumn(6))
    XCTAssertNoThrow(try game.dropDiskInColumn(6))
    XCTAssertNoThrow(try game.dropDiskInColumn(4))
    XCTAssertNoThrow(try game.dropDiskInColumn(5))
    XCTAssertNoThrow(try game.dropDiskInColumn(5))
    XCTAssertNoThrow(try game.dropDiskInColumn(5))
    XCTAssertNoThrow(try game.dropDiskInColumn(5))
    XCTAssertNoThrow(try game.dropDiskInColumn(5))
    XCTAssertNoThrow(try game.dropDiskInColumn(4))
    XCTAssertNoThrow(try game.dropDiskInColumn(4))
    XCTAssertNoThrow(try game.dropDiskInColumn(3))
    XCTAssertNoThrow(try game.dropDiskInColumn(4))
    XCTAssertNoThrow(try game.dropDiskInColumn(3))
    
    game.status.subscribe { status in
      switch status {
      case .finished(winner: let player):
        XCTAssertNotNil(player)
      default:
        XCTAssertTrue(false, "testGameStatusHandlerIsFourInRowDiagonalRight: Error")
      }
    }
    
    XCTAssertNoThrow(try game.dropDiskInColumn(3))
  }
  
  func testGameStatusHandlerIsFourInRowDiagonalLeft() {
    let game = Game(columns: 7, rows: 6, players: (self.playerOne, self.playerTwo))
    
    XCTAssertNoThrow(try game.start())
    XCTAssertNoThrow(try game.dropDiskInColumn(0))
    XCTAssertNoThrow(try game.dropDiskInColumn(0))
    XCTAssertNoThrow(try game.dropDiskInColumn(0))
    XCTAssertNoThrow(try game.dropDiskInColumn(0))
    XCTAssertNoThrow(try game.dropDiskInColumn(0))
    XCTAssertNoThrow(try game.dropDiskInColumn(0))
    XCTAssertNoThrow(try game.dropDiskInColumn(2))
    XCTAssertNoThrow(try game.dropDiskInColumn(1))
    XCTAssertNoThrow(try game.dropDiskInColumn(1))
    XCTAssertNoThrow(try game.dropDiskInColumn(1))
    XCTAssertNoThrow(try game.dropDiskInColumn(1))
    XCTAssertNoThrow(try game.dropDiskInColumn(1))
    XCTAssertNoThrow(try game.dropDiskInColumn(2))
    XCTAssertNoThrow(try game.dropDiskInColumn(2))
    XCTAssertNoThrow(try game.dropDiskInColumn(3))
    XCTAssertNoThrow(try game.dropDiskInColumn(2))
    XCTAssertNoThrow(try game.dropDiskInColumn(3))
    
    game.status.subscribe { status in
      switch status {
      case .finished(winner: let player):
        XCTAssertNotNil(player)
      default:
        XCTAssertTrue(false, "testGameStatusHandlerIsFourInRowDiagonalLeft: Error")
      }
    }
    
    XCTAssertNoThrow(try game.dropDiskInColumn(3))
  }
}
