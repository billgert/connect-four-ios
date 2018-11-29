import UIKit

class BoardGridCell: UICollectionViewCell {
  // MARK: - Private Properties
  
  public lazy var circleView: UIView = {
    let v = UIView()
    v.clipsToBounds = true
    v.layer.cornerRadius = 30.0
    return v
  }()
  
  public var model: BoardGridCellModel! {
    didSet {
      if let color = model.color {
        self.circleView.backgroundColor = UIColor(hexString: color)
      } else {
        self.circleView.backgroundColor = UIColor.white.withAlphaComponent(0.1)
      }
    }
  }
  
  // MARK: - Lifecycle
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.contentView.addSubview(self.circleView, constraints: [
      self.circleView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
      self.circleView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
      self.circleView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
      self.circleView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
    ])
    
    self.circleView.setNeedsLayout()
    self.circleView.layoutIfNeeded()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    self.circleView.layer.cornerRadius = self.circleView.frame.height / 2
  }
}
