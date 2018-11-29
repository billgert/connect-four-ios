import UIKit

class BoardGridLayout: UICollectionViewLayout {
  // MARK: - Private Properties
  
  private var cache: [UICollectionViewLayoutAttributes] = []
  
  private var numberOfColumns: Int {
    guard let collectionView = self.collectionView else { return 0 }
    return collectionView.numberOfSections
  }
  
  // MARK: - Overridden Properties
  
  override var collectionViewContentSize: CGSize {
    guard let collectionView = self.collectionView else { return .zero }
    let insets = collectionView.contentInset
    let width = collectionView.bounds.width - (insets.left + insets.right)
    let height = collectionView.bounds.height - (insets.top + insets.bottom)
    return CGSize(width: width, height: height)
  }
  
  // MARK: Overridden Methods
  
  override func prepare() {
    super.prepare()

    guard self.cache.isEmpty == true, let collectionView = self.collectionView else {
      return
    }

    let columnWidth = self.collectionViewContentSize.width / CGFloat(self.numberOfColumns)
    var xOffset: [CGFloat] = []
    for column in 0..<self.numberOfColumns {
      xOffset.append(CGFloat(column) * columnWidth)
    }
    var yOffset = [CGFloat](repeating: self.collectionViewContentSize.height, count: self.numberOfColumns)

    for section in 0..<self.numberOfColumns {
      let numberOfItemsInSection = collectionView.numberOfItems(inSection: section)
      
      for item in 0..<numberOfItemsInSection {
        let indexPath = IndexPath(item: item, section: section)
        let height: CGFloat = self.collectionViewContentSize.height / CGFloat(numberOfItemsInSection)
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        attributes.frame = CGRect(x: xOffset[section], y: yOffset[section] - height, width: columnWidth, height: height)
        self.cache.append(attributes)
        yOffset[section] = yOffset[section] - height
      }
    }
  }

  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
    for attributes in self.cache {
      if attributes.frame.intersects(rect) {
        visibleLayoutAttributes.append(attributes)
      }
    }
    return visibleLayoutAttributes
  }
  
  override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    return self.cache[indexPath.item]
  }
}
