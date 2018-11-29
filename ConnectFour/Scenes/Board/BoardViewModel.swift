import UIKit

class BoardViewModel: ViewModel {
  // MARK: - Output

  public let currentPlayerTitle = Observable<String>()
  public let currentPlayerTitleColor = Observable<String>()
  
  public let restartButtonTitle: String = "Restart game"
  
  public let finishedMessage = Observable<String>()
  
  public var gridSectionCellModels: Array2D<BoardGridCellModel> = [[]]

  public var updateHandler: () -> () = {}

  // MARK: - Private Properties
  
  private let game: Game
 
  // MARK: - Lifecycle
  
  init(game: Game) {
    self.game = game

    super.init()
    
    self.game.status.subscribe { [unowned self] status in
      switch status {
      case .inactive:
        print("inactive")
      case .active(let player):
        self.currentPlayerTitle.value = "\(player.name)'s turn"
        self.currentPlayerTitleColor.value = player.color
      case .finished(winner: let player):
        if let player = player {
          self.finishedMessage.value = "Winner: \(player.name)"
        } else {
          self.finishedMessage.value = "Draw"
        }
      }
      
      self.updateHandler()
    }
    
    self.startGame()
  }
  
  // MARK: - Output
  
  public func collectionViewWidthMultiplier() -> CGFloat {
    let columns = CGFloat(self.game.columns)
    let rows = CGFloat(self.game.rows)
    return (columns / 1.0) / rows
  }
  
  // MARK: - Input
  
  public func didSelectSection(_ section: Int) {
    do {
      let disk = try self.game.dropDiskInColumn(section)
      let cellModel = self.gridSectionCellModels[disk.coordinate.column][disk.coordinate.row]
      cellModel.color = disk.color
    } catch {
      self.errorMessage.value = error.localizedDescription
    }
  }
  
  public func didTapRestartButton() {
    self.startGame()
  }
  
  // MARK: - Private Methods
  
  private func startGame() {
    do {
      let grid = try self.game.start()
      self.gridSectionCellModels = grid.map { column in
        return column.map { _ in BoardGridCellModel() }
      }
    } catch {
      self.errorMessage.value = error.localizedDescription
    }
  }
}


