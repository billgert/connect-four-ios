import Foundation

extension Game {
  struct Player {
    let name: String
    let color: String
  }
  
  enum Status {
    case active(Player)
    case finished(winner: Player?)
  }
  
  enum Error: LocalizedError {
    case players
    case noColumns
    case columnFull

    var errorDescription: String? {
      switch self {
      case .players:
        return NSLocalizedString("Players have not been set.", comment: "")
      case .noColumns:
        return NSLocalizedString("There are no columns for building the game.", comment: "")
      case .columnFull:
        return NSLocalizedString("The column is full.", comment: "")
      }
    }
  }
}

// MARK: - Equatable

extension Game.Player: Equatable {
  static func == (lhs: Game.Player, rhs: Game.Player) -> Bool {
    return lhs.name == rhs.name
  }
}

