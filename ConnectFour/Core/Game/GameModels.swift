import Foundation

extension Game {
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
      case .noColumns:
        return NSLocalizedString("There are no columns for building the game.", comment: "")
      case .columnFull:
        return NSLocalizedString("The column is full.", comment: "")
      }
    }
  }
}

