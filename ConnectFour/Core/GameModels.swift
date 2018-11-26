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
    case start(player: Player)
    case active(player: Player)
    case draw
    case win(player: Player)
  }
}

// MARK: - Equatable

extension Game.Player: Equatable {
  static func == (lhs: Game.Player, rhs: Game.Player) -> Bool {
    return lhs.name == rhs.name
  }
}
