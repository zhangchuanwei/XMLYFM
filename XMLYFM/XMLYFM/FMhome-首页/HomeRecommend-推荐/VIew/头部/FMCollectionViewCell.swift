//
//  FMCollectionViewCell.swift
//  XMLYFM
//
//  Created by 张传伟 on 2018/10/11.
//  Copyright © 2018年 张传伟. All rights reserved.
//

import UIKit

class FMCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var labView: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var square:SquareModel? {
        didSet{
            guard let model = square else { return }
            self.imageView.kf.setImage(with: URL(string: model.coverPath!))
            self.labView.text = model.title
        }
    }
}
