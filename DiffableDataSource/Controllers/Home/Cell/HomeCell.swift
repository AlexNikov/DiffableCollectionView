//
//  HomeCell.swift
//  DemoCollectionView
//
//  Created by Le Phuong Tien on 12/4/19.
//  Copyright © 2019 Fx Studio. All rights reserved.
//

import UIKit

class HomeCell: UICollectionViewCell {

    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        print(nameLabel.text)
    }

}
