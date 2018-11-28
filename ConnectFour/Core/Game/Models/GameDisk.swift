import Foundation

extension Game {
  struct Disk {
    struct Coordinate {
      let column: Int
      let row: Int
    }
    
    let coordinate: Coordinate
    let color: String
  }
}
