import UIKit

class GameNavigator: Navigator {
  enum Destination {
    case start
    case board(viewModel: BoardViewModel)
  }
  
  private let navigationController: UINavigationController
  private let window: UIWindow
  
  // MARK: - Lifecycle
  
  init(navigationController: UINavigationController, window: UIWindow) {
    self.navigationController = navigationController
    
    self.window = window
    self.window.rootViewController = self.navigationController
    self.window.makeKeyAndVisible()
  }
  
  // MARK: - Navigator
  
  func navigate(to destination: Destination) {
    let viewController = self.makeViewController(for: destination)
    self.navigationController.pushViewController(viewController, animated: true)
  }
  
  // MARK: - Private Methods
  
  private func makeViewController(for destination: Destination) -> UIViewController {
    switch destination {
    case .start:
      let networkService = NetworkService<BlinkistEndPoint>()
      let startViewModel = StartViewModel(networkService, self)
      return StartViewController(viewModel: startViewModel)
    case .board(let viewModel):
      return BoardViewController(viewModel: viewModel)
    }
  }
}
