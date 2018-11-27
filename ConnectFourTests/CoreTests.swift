//
//  CoreTests.swift
//  CoreTests
//
//  Created by Patrik Billgert on 2018-11-23.
//  Copyright © 2018 Patrik Billgert. All rights reserved.
//

import XCTest
@testable import ConnectFour

class CoreTests: XCTestCase {
  let playerOne = Game.Player(name: "Sue", color: "#FF0000")
  let playerTwo = Game.Player(name: "Henry", color: "#0000FF")
  
  // MARK: - start()
  
  func testGameStartHasNoPlayers() {
    let game = Game(columns: 7, rows: 6)
    
    XCTAssertThrowsError(try game.start()) { error in
      XCTAssertEqual(error as! Game.Error, Game.Error.players)
    }
  }
  
  func testGameStartHasNoColumns() {
    let game = Game(columns: 0, rows: 0)
    
    game.playerOne = self.playerOne
    game.playerTwo = self.playerTwo
    
    XCTAssertThrowsError(try game.start()) { error in
      XCTAssertEqual(error as! Game.Error, Game.Error.noColumns)
    }
  }
  
  // MARK: - dropDiskInColumn(_ column: Int)
  
  func testGameDropDiskSuccess() {
    let game = Game(columns: 7, rows: 6)
    
    game.playerOne = self.playerOne
    game.playerTwo = self.playerTwo

    do {
      try game.start()
      try game.dropDiskInColumn(2)
    } catch {
      XCTAssertTrue(false, "testGameDropDiskSuccess: Error")
    }
  }
  
  func testGameDropMultipleDisksSuccess() {
    let game = Game(columns: 7, rows: 6)
    
    game.playerOne = self.playerOne
    game.playerTwo = self.playerTwo
    
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
  
  func testGameDropDiskInFullColumn() {
    let game = Game(columns: 7, rows: 6)
    
    game.playerOne = self.playerOne
    game.playerTwo = self.playerTwo
  
    do {
      try game.start()
      try game.dropDiskInColumn(2)
      try game.dropDiskInColumn(2)
      try game.dropDiskInColumn(2)
      try game.dropDiskInColumn(2)
      try game.dropDiskInColumn(2)
      try game.dropDiskInColumn(2)
    } catch {
      XCTAssertTrue(false, "testGameDropDiskInFullColumn: Error")
    }

    XCTAssertThrowsError(try game.dropDiskInColumn(2)) { error in
      XCTAssertEqual(error as! Game.Error, Game.Error.columnFull)
    }
  }
  
  // MARK: - isFourInRow()
  
  func testGameIsFourInRowHorizontal() {
    let game = Game(columns: 7, rows: 6)
    
    game.playerOne = self.playerOne
    game.playerTwo = self.playerTwo
    
    XCTAssertNoThrow(try game.start())
    XCTAssertNoThrow(try game.dropDiskInColumn(0))
    XCTAssertNoThrow(try game.dropDiskInColumn(0))
    XCTAssertNoThrow(try game.dropDiskInColumn(1))
    XCTAssertNoThrow(try game.dropDiskInColumn(1))
    XCTAssertNoThrow(try game.dropDiskInColumn(2))
    XCTAssertNoThrow(try game.dropDiskInColumn(2))
    
    game.statusHandler = { status in
      switch status {
      case .finished(let winner):
        XCTAssertNotNil(winner)
      default:
        XCTAssertTrue(false, "testGameIsFourInRow: Error")
      }
    }
    
    XCTAssertNoThrow(try game.dropDiskInColumn(3))
  }
  
  func testGameIsFourInRowVertical() {
    let game = Game(columns: 7, rows: 6)
    
    game.playerOne = self.playerOne
    game.playerTwo = self.playerTwo
  
    XCTAssertNoThrow(try game.start())
    XCTAssertNoThrow(try game.dropDiskInColumn(2))
    XCTAssertNoThrow(try game.dropDiskInColumn(2))
    XCTAssertNoThrow(try game.dropDiskInColumn(2))
    XCTAssertNoThrow(try game.dropDiskInColumn(3))
    XCTAssertNoThrow(try game.dropDiskInColumn(2))
    XCTAssertNoThrow(try game.dropDiskInColumn(3))
    XCTAssertNoThrow(try game.dropDiskInColumn(2))
    XCTAssertNoThrow(try game.dropDiskInColumn(3))
    
    game.statusHandler = { status in
      switch status {
      case .finished(let winner):
        XCTAssertNotNil(winner)
      default:
        XCTAssertTrue(false, "testGameIsFourInRow: Error")
      }
    }
    
    XCTAssertNoThrow(try game.dropDiskInColumn(2))
  }
  
  func testGameIsFourInRowDiagonalRight() {
    let game = Game(columns: 7, rows: 6)
    
    game.playerOne = self.playerOne
    game.playerTwo = self.playerTwo
    
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
    
    game.statusHandler = { status in
      switch status {
      case .finished(let winner):
        XCTAssertNotNil(winner)
      default:
        XCTAssertTrue(false, "testGameIsFourInRow: Error")
      }
    }
    
    XCTAssertNoThrow(try game.dropDiskInColumn(3))
  }
  
  func testGameIsFourInRowDiagonalLeft() {
    let game = Game(columns: 7, rows: 6)
    
    game.playerOne = self.playerOne
    game.playerTwo = self.playerTwo
    
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
    
    game.statusHandler = { status in
      switch status {
      case .finished(let winner):
        XCTAssertNotNil(winner)
      default:
        XCTAssertTrue(false, "testGameIsFourInRow: Error")
      }
    }
    
    XCTAssertNoThrow(try game.dropDiskInColumn(3))
  }
}
