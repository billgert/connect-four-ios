import UIKit

class BoardGridCell: UICollectionViewCell {
  public lazy var testLabel: UILabel = {
    let l = UILabel()
    l.textAlignment = .center
    l.font = .systemFont(ofSize: 10.0, weight: .bold)
    return l
  }()
  
  public var model: BoardGridCellModel! {
    didSet {
      if let color = model.color {
        self.backgroundColor = UIColor(hexString: color)
      } else {
        self.backgroundColor = .clear
      }
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.contentView.addSubview(self.testLabel, constraints: [
      self.testLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
      self.testLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
      self.testLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
      self.testLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
    ])
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
