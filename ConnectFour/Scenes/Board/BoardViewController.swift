import UIKit

class BoardViewController: UIViewController {
  private let viewModel: BoardViewModel
  
  // MARK: - Lifecycle
  
  init(viewModel: BoardViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = .yellow
  }
}
