import Foundation

extension Game {
  enum Status {
    case inactive
    case active(Player)
    case finished(winner: Player?)
  }
}

