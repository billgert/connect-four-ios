import Foundation

extension Game {
  enum Status {
    case active(Player)
    case finished(winner: Player?)
  }
}

