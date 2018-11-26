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
  // MARK: - start()
  
  func testGameStartHasNoPlayers() {
    let game = Game(columns: 7, rows: 6)
    
    XCTAssertThrowsError(try game.start()) { error in
      XCTAssertEqual(error as! Game.Error, Game.Error.players)
    }
  }
  
  func testGameStartHasNoColumns() {
    let game = Game(columns: 0, rows: 0)
    
    game.playerOne = Game.Player(name: "Sue", color: "#FF0000")
    game.playerTwo = Game.Player(name: "Henry", color: "#0000FF")
    
    XCTAssertThrowsError(try game.start()) { error in
      XCTAssertEqual(error as! Game.Error, Game.Error.columns)
    }
  }
  
  // MARK: - statusHandler
  
  func testGameStatusHandlerStarted() {
    let game = Game(columns: 7, rows: 6)
    
    game.playerOne = Game.Player(name: "Sue", color: "#FF0000")
    game.playerTwo = Game.Player(name: "Henry", color: "#0000FF")

    game.statusHandler = { status in
      guard case .start = status else {
        XCTAssertTrue(false, "error")
        return
      }
    }
    
    XCTAssertNoThrow(try game.start())
  }
}
