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
    case finished(winner: Player?)
    case ongoing(current: Player)
  }
}
