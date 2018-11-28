import Foundation

struct Configuration: Codable {
  let id: Int
  let color1: String
  let color2: String
  let name1: String
  let name2: String
}

extension Configuration {
  public func playerOne() -> Player {
    return Player(
      name: self.name1,
      color: self.color1
    )
  }
  
  public func playerTwo() -> Player {
    return Player(
      name: self.name2,
      color: self.color2
    )
  }
}
