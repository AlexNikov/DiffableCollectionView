//
//  HomeViewController.swift
//  DemoCollectionView
//
//  Created by Le Phuong Tien on 12/4/19.
//  Copyright © 2019 Fx Studio. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
  
  //MARK: - Define
    enum Section {

    case main
    case slave
        var title: String {
            switch self {
            case .main: return "main"
            case .slave: return "slave"
            }
        }
  }
    var newDataSource: [SectionModel] = []
  typealias DataSource = UICollectionViewDiffableDataSource<String, AnyHashable>
  typealias Snapshot = NSDiffableDataSourceSnapshot<String, AnyHashable>

    struct SectionModel {
        let type: Section
        var items: [Flower]
    }
  //MARK: - Properties
    var flowers1 = Flower.mainFlowers()
    var flowers2 = Flower.slaveFlowers()
    lazy var sections = newDataSource.map({ $0.type.title })
  private lazy var dataSource = makeDataSource()
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  //MARK: - Life cycles
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Flowers"
      newDataSource = [
        .init(type: .main, items: Flower.mainFlowers()),
        .init(type: .slave, items: Flower.slaveFlowers())
      ]
    configureLayout()
    applySnapshot()
    
  }
  
  //MARK: - Config View
  func makeDataSource() -> DataSource {
    let dataSource = DataSource(
      collectionView: collectionView,
      cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
          if let flower = (item as? FlowerWrap)?.data {
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HomeCell
              print("\(indexPath) - \(flower.id) - \(flower.name)")
              cell?.nameLabel.text = flower.name
              cell?.thumbImageView.image = UIImage(named: flower.imageName)
              return cell
          } else {
              return UICollectionViewCell()
          }
    })
    
    //header
    dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
      guard kind == UICollectionView.elementKindSectionHeader else {
        return UICollectionReusableView()
      }

      let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as? HomeHeaderView
        view?.titleLabel.text = self.newDataSource[indexPath.section].type.title
        view?.totalLabel.text = "\(self.newDataSource[indexPath.section].items.count)"

      return view
    }
    
    return dataSource
  }
  
  func configureLayout() {
    
    //delegate
    collectionView.delegate = self
    
    //register cell
    let nib = UINib(nibName: "HomeCell", bundle: .main)
    collectionView.register(nib, forCellWithReuseIdentifier: "cell")
    
    //register header
    let headerNib = UINib(nibName: "HomeHeaderView", bundle: .main)
    collectionView.register(headerNib,
                            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                            withReuseIdentifier: "header")
    
    //layout
    let screenWidth = UIScreen.main.bounds.width - 20
    // for items
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    layout.sectionInset = UIEdgeInsets(top: 20, left: 5, bottom: 10, right: 5)
    layout.itemSize = CGSize(width: screenWidth/2, height: screenWidth/2)
    layout.minimumInteritemSpacing = 5
    layout.minimumLineSpacing = 5
    layout.scrollDirection = .vertical
    
    // for header
    layout.sectionHeadersPinToVisibleBounds = false
    layout.headerReferenceSize = CGSize(width: screenWidth, height: 50)
    
    collectionView!.collectionViewLayout = layout
    
  }
  
  func applySnapshot(animatingDifferences: Bool = true) {
    var snapshot = Snapshot()

      snapshot.appendSections(sections)

      for section in newDataSource {
          snapshot.appendItems(section.items.compactMap({ FlowerWrap.init(name: $0.name, imageName: $0.imageName) }), toSection: section.type.title)
      }
      dataSource.apply(snapshot, animatingDifferences: false)
  }
  
}

extension HomeViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      print("----------------")

      newDataSource[indexPath.section].items[indexPath.row].name = "sdfsdf"
      applySnapshot()
  }
}
