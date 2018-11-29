import UIKit

class BoardViewController: UIViewController, SetupVC {
  // MARK: - Private Properties
  
  private lazy var verticalStackView: UIStackView = {
    let s = UIStackView()
    s.axis = .vertical
    s.spacing = 20.0
    s.alignment = .center
    return s
  }()
  
  private lazy var playerLabel: UILabel = {
    let l = UILabel()
    l.textAlignment = .center
    l.font = .systemFont(ofSize: 40.0, weight: .bold)
    return l
  }()
  
  private lazy var collectionView: UICollectionView = {
    let c = UICollectionView(frame: .zero, collectionViewLayout: BoardGridLayout())
    c.dataSource = self
    c.delegate = self
    c.backgroundColor = .clear
    c.register(BoardGridCell.self, forCellWithReuseIdentifier: "BoardGridCell")
    return c
  }()
  
  private lazy var restartButton: UIButton = {
    let b = UIButton()
    b.layer.cornerRadius = 10.0
    b.contentEdgeInsets = UIEdgeInsets(top: 5.0, left: 10.0, bottom: 5.0, right: 10.0)
    b.titleLabel?.font = .boldSystemFont(ofSize: 20.0)
    b.backgroundColor = .green
    return b
  }()
  
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
    
    self.view.backgroundColor = .white
    
    self.setupLayout()
    self.setupBindings()
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
  }
  
  // MARK: - SetupVC
  
  func setupLayout() {
    self.verticalStackView.addArrangedSubview(self.playerLabel)
    self.verticalStackView.addArrangedSubview(self.collectionView)
    self.verticalStackView.addArrangedSubview(self.restartButton)

    self.view.addSubview(self.verticalStackView, constraints: [
      self.verticalStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
      self.verticalStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20.0),
      self.verticalStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
      self.verticalStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20.0)
    ])
    
    NSLayoutConstraint.activate([
      self.playerLabel.heightAnchor.constraint(equalToConstant: self.playerLabel.font.lineHeight),
      self.restartButton.heightAnchor.constraint(equalToConstant: self.restartButton.intrinsicContentSize.height),
      self.collectionView.widthAnchor.constraint(equalTo: self.collectionView.heightAnchor, multiplier: self.viewModel.collectionViewWidthMultiplier())
    ])
  }
  
  func setupBindings() {
    // MARK: playerLabel
    
    self.viewModel.currentPlayerTitle.subscribe(trigger: true) { [unowned self] in
      self.playerLabel.text = $0
    }
    
    self.viewModel.currentPlayerTitleColor.subscribe(trigger: true) { [unowned self] in
      self.playerLabel.textColor = UIColor(hexString: $0)
    }

    // MARK: restartButton
    
    self.restartButton.setTitle(self.viewModel.restartButtonTitle, for: .normal)
    
    self.viewModel.restartButtonIsHidden.subscribe(trigger: true) { [unowned self] in
      self.restartButton.isHidden = $0
    }
    
    self.restartButton.addAction(for: .touchUpInside, { [unowned self] in
      self.viewModel.didTapRestartButton()
    })
    
    // MARK: UIAlertView
    
    self.viewModel.finishedMessage.subscribe {
      print($0) // Present in alert view
    }
    
    self.viewModel.errorMessage.subscribe {
      print($0) // Present in alert view
    }
  }
}

// MARK: - UICollectionView

extension BoardViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return self.viewModel.gridSectionCellModels.count
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.viewModel.gridSectionCellModels[section].count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BoardGridCell", for: indexPath) as! BoardGridCell
    cell.model = self.viewModel.gridSectionCellModels[indexPath.section][indexPath.row]
    cell.testLabel.text = "\([indexPath.section], [indexPath.row])"
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    self.viewModel.didSelectSection(indexPath.section)
  }
}
