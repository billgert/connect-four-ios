import UIKit

class StartViewController: UIViewController {
  let viewModel: StartViewModel
  
  // MARK: - Lifecycle
  
  init(viewModel: StartViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
}
