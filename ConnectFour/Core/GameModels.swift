import Foundation

extension Game {
  struct Disk {
    struct Location {
      let column: Int
      let row: Int
    }
    
    let location: Location?
    let color: String?
  }
  
  struct Player {
    let name: String
    let color: String
  }
  
  enum Status {
    case start(Player)
    case active(Player)
    case draw
    case win(Player)
  }
  
  enum Error: LocalizedError {
    case players
    case columns
    
    // Accessable from localizedDescription
    var errorDescription: String? {
      switch self {
      case .players:
        return NSLocalizedString("Players have not been set.", comment: "")
      case .columns:
        return NSLocalizedString("There are no columns for building the game.", comment: "")
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
