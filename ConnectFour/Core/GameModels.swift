import Foundation

extension Game {
  struct Disk {
    struct Location {
      let column: Int
      let row: Int
    }
    
    var location: Location?
    let color: String
  }
  
  struct Player {
    let name: String
    let color: String
  }
  
  enum Status {
    case start(Player)
    case active(Player)
    case finished(winner: Player?)
  }
  
  enum Error: LocalizedError {
    case players
    case noColumns
    case columnFull
    case noDisksLeft
    
    // Accessable from localizedDescription
    var errorDescription: String? {
      switch self {
      case .players:
        return NSLocalizedString("Players have not been set.", comment: "")
      case .noColumns:
        return NSLocalizedString("There are no columns for building the game.", comment: "")
      case .columnFull:
        return NSLocalizedString("The column is full.", comment: "")
      case .noDisksLeft:
        return NSLocalizedString("There are no more disks available for the current player.", comment: "")
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
