import Foundation

extension GameCore {
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
    case finished(winner: GamePlayer?)
    case ongoing(current: GamePlayer)
  }
}
