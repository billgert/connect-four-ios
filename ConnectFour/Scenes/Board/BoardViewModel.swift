import Foundation

class BoardViewModel {
  // MARK: - Output
  
  public let restartButtonIsHidden = Observable<Bool>(value: true)
  public let errorMessage = Observable<String>()
  public let finishedMessage = Observable<String>()
  public let currentPlayerTitle = Observable<String>()
  public let currentPlayerTitleColor = Observable<String>()
  public let gridSectionCellModels = Observable<[[BoardGridCellModel]]>()

  // MARK: - Private Properties
  
  private let game: Game
 
  // MARK: - Lifecycle
  
  init(game: Game) {
    self.game = game

    self.game.statusHandler = { [unowned self] status in
      switch status {
      case .active(let player):
        self.restartButtonIsHidden.value = true
        self.currentPlayerTitle.value = "Active player: \(player.name)"
        self.currentPlayerTitleColor.value = player.color
      case .finished(winner: let player):
        self.restartButtonIsHidden.value = false
        if let player = player {
          self.finishedMessage.value = "Winner: \(player.name)"
        } else {
          self.finishedMessage.value = "Draw"
        }
      }
    }
    
    self.startGame()
  }
  
  // MARK: - Input
  
  public func didSelectSection(_ section: Int) {
    do {
      let disk = try self.game.dropDiskInColumn(section)
      let cellModel = self.gridSectionCellModels.value![disk.coordinate.column][disk.coordinate.row]
      cellModel.color = disk.color // is this enough to trigger an update? Else make updateHandler. TEST
    } catch {
      self.errorMessage.value = error.localizedDescription
    }
  }
  
  public func didTapRestartButton() {
    self.startGame()
  }
  
  // MARK: - Private Functions
  
  private func startGame() {
    do {
      let grid = try self.game.start()
      self.gridSectionCellModels.value = grid.map { column in
        return column.map { _ in BoardGridCellModel() }
      }
    } catch {
      self.errorMessage.value = error.localizedDescription
    }
  }
}


