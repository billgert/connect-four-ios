import Foundation

struct Player {
  let name: String
  let color: String
}

// MARK: - Equatable

extension Player: Equatable {
  static func == (lhs: Player, rhs: Player) -> Bool {
    return lhs.name == rhs.name
  }
}
