import Foundation

class BoardViewModel: ViewModel {
  // MARK: - Output

  public let currentPlayerTitle = Observable<String>()
  public let currentPlayerTitleColor = Observable<String>()
  
  public let restartButtonIsHidden = Observable<Bool>(value: true)
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
      let cellModel = self.gridSectionCellModels[disk.coordinate.column][disk.coordinate.row]
      cellModel.color = disk.color
      self.updateHandler()
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


