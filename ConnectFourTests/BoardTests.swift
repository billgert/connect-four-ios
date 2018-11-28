import XCTest

class BoardTests: XCTestCase {
  // MARK: - didSelectSection
  
  func testBoardSelectSectionChangedModel() {
    let playerOne = Player(name: "Sue", color: "#FF0000")
    let playerTwo = Player(name: "Henry", color: "#0000FF")
    
    let game = Game(columns: 7, rows: 6, players: (playerOne, playerTwo))
    
    let viewModel = BoardViewModel(game: game)
    
    viewModel.didSelectSection(0)
    
    let cellModel = viewModel.gridSectionCellModels[0][0]
    
    XCTAssertNotNil(cellModel.color)
  }
  
  
}
