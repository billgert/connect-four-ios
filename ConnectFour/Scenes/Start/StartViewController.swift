import UIKit

class StartViewController: UIViewController {
  // MARK: - Private Properties
  
  private lazy var verticalStackView: UIStackView = {
    let s = UIStackView()
    s.axis = .vertical
    s.spacing = 20.0
    s.alignment = .center
    return s 
  }()
  
  private lazy var playerOneLabel: UILabel = {
    let l = UILabel()
    l.textAlignment = .center
    l.font = .systemFont(ofSize: 20.0, weight: .medium)
    return l
  }()
  
  private lazy var playerTwoLabel: UILabel = {
    let l = UILabel()
    l.textAlignment = .center
    l.font = .systemFont(ofSize: 20.0, weight: .medium)
    return l
  }()
  
  private lazy var startButton: UIButton = {
    let b = UIButton()
    b.layer.cornerRadius = 10.0
    b.contentEdgeInsets = UIEdgeInsets(top: 5.0, left: 10.0, bottom: 5.0, right: 10.0)
    b.titleLabel?.font = .boldSystemFont(ofSize: 40.0)
    return b
  }()
  
  private let viewModel: StartViewModel
  
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
    
    self.view.backgroundColor = .white
    
    self.setupLayout()
    self.setupBindings()
  }
  
  // MARK: - Private Methods
  
  private func setupLayout() {
    self.verticalStackView.addArrangedSubview(self.playerOneLabel)
    self.verticalStackView.addArrangedSubview(self.playerTwoLabel)
    self.verticalStackView.addArrangedSubview(self.startButton)
    
    self.view.addSubview(self.verticalStackView, constraints: [
      self.verticalStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      self.verticalStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
    ])
  }
  
  private func setupBindings() {
    // MARK: playerOneLabel
    
    self.viewModel.playerOneText.subscribe(trigger: true) { [unowned self] in
      self.playerOneLabel.text = $0
    }
    
    self.viewModel.playerOneTextColor.subscribe(trigger: true) { [unowned self] in
      self.playerOneLabel.textColor = UIColor(hexString: $0)
    }
    
    // MARK: playerTwoLabel
    
    self.viewModel.playerTwoText.subscribe(trigger: true) { [unowned self] in
      self.playerTwoLabel.text = $0
    }
    
    self.viewModel.playerTwoTextColor.subscribe(trigger: true) { [unowned self] in
      self.playerTwoLabel.textColor = UIColor(hexString: $0)
    }
    
    // MARK: startButton
    
    self.startButton.setTitle(self.viewModel.startButtonTitle, for: .normal)
    
    self.viewModel.startButtonIsUserInteractionEnabled.subscribe(trigger: true) { [unowned self] in
      self.startButton.isUserInteractionEnabled = $0
    }
    
    self.viewModel.startButtonBackgroundColor.subscribe(trigger: true) { [unowned self] in
      self.startButton.backgroundColor = UIColor(hexString: $0)
    }
    
    self.startButton.addAction(for: .touchUpInside, { [unowned self] in
      self.viewModel.didTapStartButton()
    })
  }
}
