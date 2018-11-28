import Foundation

struct BoardViewModel {
  // MARK: - Output
  
  public let restartButtonIsHidden = Observable<Bool>(value: true) // hide on statusHandler
  public let errorMessage = Observable<String>()
  public let winnerMessage = Observable<String>() // based on statusHandler
  public let currentPlayerTitle = Observable<String>() // based on statusHandler
  public let currentPlayerTitleColor = Observable<String>() // based on statusHandler
  public let gridSectionCellModels = Observable<[[GridCellModel]]>()

  // MARK: - Private Properties
  
  private let game: Game
 
  // MARK: - Lifecycle
  
  init(game: Game) {
    self.game = game
    
    // 1. Listen for future changes in statusHandler
    // 2. Start the game
  }
  
  // MARK: - Input
  
  public func didSelectSection(_ section: Int) {
    // 1. Try and insert disk in column (section)
    // 2. If it throws an error set it on errorMessage
    // 3. If not update model state in gridSectionCellModels with returned disk
  }
  
  public func didTapRestartButton() {
    self.startGame()
  }
  
  // MARK: - Private Functions
  
  private func startGame() {
    do {
      let grid = try self.game.start()
      // 2. Setup models for grid
    } catch {
      self.errorMessage.value = error.localizedDescription
    }
  }
}

struct GridCellModel {
  public var color: String
}

