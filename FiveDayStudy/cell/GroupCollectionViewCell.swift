//
//  GroupCollectionViewCell.swift
//  FiveDayStudy
//
//  Created by le tong on 2019/10/10.
//  Copyright © 2019 iOS. All rights reserved.
//

import UIKit

class GroupCollectionViewCell: UICollectionViewCell {
    var imgView = UIImageView()
    var nameLable = UILabel()
    var countLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imgView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.width))
        nameLable = UILabel.init(frame: CGRect(x: 0, y: frame.size.width + 10, width: frame.size.width, height: 20))
        nameLable.font = UIFont.systemFont(ofSize: 18)
        nameLable.textColor = UIColor.black
        countLabel = UILabel.init(frame: CGRect(x: 0, y: frame.size.width + 35, width: frame.size.width, height: 10))
        countLabel.font = UIFont.systemFont(ofSize: 13)
        countLabel.textColor = UIColor.black
        contentView.addSubview(imgView)
        
        contentView.addSubview(nameLable)
        contentView.addSubview(countLabel)
    }
    
    func setCurrentUI(imgName: String, name: String, count: Int) -> Void {
        imgView.image = UIImage.init(named: imgName)
        nameLable.text = name
        countLabel.text = "\(count)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
