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
      let disk = try game.dropDiskInColumn(2)
      XCTAssertTrue(disk.location!.column == 2)
      XCTAssertTrue(disk.location!.row == 0)
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
      let disk = try game.dropDiskInColumn(2)
      XCTAssertTrue(disk.location!.column == 2)
      XCTAssertTrue(disk.location!.row == 3)
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
  
  // MARK: - statusHandler
  
  func testGameStatusHandlerStarted() {
    let game = Game(columns: 7, rows: 6)
    
    game.playerOne = self.playerOne
    game.playerTwo = self.playerTwo
    
    game.statusHandler = { status in
      guard case .start = status else {
        XCTAssertTrue(false, "testGameStatusHandlerStarted: Error")
        return
      }
    }
    
    XCTAssertNoThrow(try game.start())
  }
}
