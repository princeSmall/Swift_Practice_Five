//
//  DetailCollectionViewCell.swift
//  FiveDayStudy
//
//  Created by le tong on 2019/10/11.
//  Copyright © 2019 iOS. All rights reserved.
//

import UIKit

class DetailCollectionViewCell: UICollectionViewCell {
    
    var imgView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imgView = UIImageView.init(frame: self.contentView.bounds)
        self.contentView.addSubview(imgView)
    }
    
    func setCurrentImageView(imgName: String) -> Void {
        imgView.image = UIImage.init(named: imgName)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
