import Foundation

class StartViewModel {
  // MARK: - Output
  
  public let playerOneTitle = Observable<String>(value: "Player 1 Loading...")
  public let playerTwoTitle = Observable<String>(value: "Player 2 Loading...")
  
  public let startButtonIsEnabled = Observable<Bool>(value: false)
  
  // MARK: - Private Properties
  
  private let players = Observable<(Player, Player)>()

  private let networkService: NetworkService
  private let navigationService: NavigationService
  
  // MARK: - Lifecycle
  
  init(networkService: NetworkService, navigationService: NavigationService) {
    self.networkService = networkService
    self.navigationService = navigationService
    
    self.requestConfiguration { configuration in
      self.players.value = (configuration.playerOne(), configuration.playerTwo())
    }
    
    self.players.subscribe { players in
      self.playerOneTitle.value = "\(players.0.name) is ready"
      self.playerTwoTitle.value = "\(players.1.name) is ready"
      self.startButtonIsEnabled.value = true
    }
  }
  
  // MARK: - Input

  public func didTapStartButton() {
    let game = Game(columns: 7, rows: 6, players: self.players.value!)
    // 2. Pass the game object and tell navigationService that start button was tapped
  }
  
  // MARK: - Requests
  
  private func requestConfiguration(completion: (Configuration) -> Void) {
    // 1. Use networkService
    // 2. Return configuration model
    // 3. It's an array...?
  }
}
