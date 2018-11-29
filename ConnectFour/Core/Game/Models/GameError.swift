import Foundation

extension Game {
  enum Error: LocalizedError {
    case activePlayer
    case noColumns
    case columnFull
    case gameFinished
    
    var errorDescription: String? {
      switch self {
      case .activePlayer:
        return NSLocalizedString("There is no active player.", comment: "")
      case .noColumns:
        return NSLocalizedString("There are no columns for building the game.", comment: "")
      case .columnFull:
        return NSLocalizedString("The column is full.", comment: "")
      case .gameFinished:
        return NSLocalizedString("Game is finished.", comment: "")
      }
    }
  }
}

