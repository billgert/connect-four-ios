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
      // 1. Transform configuration to players
      // 2. Set players tuple
    }
    
    self.players.subscribe { players in
      // 1. Set playerOneTitle & playerTwoTitle ({name} is ready)
      // 2. Set startButtonIsEnabled
    }
  }
  
  // MARK: - Input

  public func didTapStartButton() {
    // 1. Create a new game object with the players
    // 2. Pass the game object and tell navigationService that start button was tapped
  }
  
  // MARK: - Requests
  
  private func requestConfiguration(completion: (Configuration) -> Void) {
    // 1. Use networkService
    // 2. Return configuration model
  }
}

struct Configuration {
  
}

class NetworkService {
  
}

class NavigationService {
  
}
