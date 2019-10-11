//
//  ViewController.swift
//  FiveDayStudy
//
//  Created by le tong on 2019/10/10.
//  Copyright © 2019 iOS. All rights reserved.
//

import UIKit

class SingleViewController: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    let identifier: String = "identifier"
    let headIdentifier: String = "headIdentifier"
    var modelArray:[BaseModel] = CurrentModel.init().Array
    var singleCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.navigationItem.title = "照片"
        setCurrentSingleCollectionView()
        // Do any additional setup after loading the view.
    }
    
    func setUseCurrentModel(array: [BaseModel], section: Int) -> [BaseModel] {
        var currentArray:[BaseModel] = []
        let currentDate: String = self .getCurrentDate(section: section)
        for model:BaseModel in array {
            if model.date == currentDate{
                currentArray.append(model)
            }
        }
        return currentArray
    }
    
    func getCurrentDate(section: Int) -> String {
        var currentDate: String = ""
        if section == 0 {
            currentDate = "2019-10-3"
        }else if section == 1{
            currentDate = "2019-10-2"
        }else if section == 2{
            currentDate = "2019-10-1"
        }
        return currentDate
    }
    
    func setCurrentSingleCollectionView() -> Void {
        let flow = UICollectionViewFlowLayout()
        flow.itemSize = CGSize.init(width: view.frame.width / 4.0 - 1, height: view.frame.width / 4.0 - 1)
        flow.minimumLineSpacing = 5
        flow.minimumInteritemSpacing = 1
        
        singleCollectionView = UICollectionView.init(frame: view.bounds, collectionViewLayout: flow)
        singleCollectionView.delegate = self
        singleCollectionView.dataSource = self
        singleCollectionView.register(SingleCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: identifier)
        singleCollectionView.register(SingleCollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headIdentifier)
        singleCollectionView.backgroundColor = UIColor.white
        view.addSubview(singleCollectionView)
    }

  
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
        return CGSize(width: self.view.frame.size.width, height: 50)
    }


    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
       
        if kind == UICollectionView.elementKindSectionHeader{
            let headView: SingleCollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headIdentifier, for: indexPath) as! SingleCollectionReusableView
            let nameLabel = UILabel.init(frame: headView.bounds)
            nameLabel.font = UIFont.systemFont(ofSize: 13)
            nameLabel.textColor = UIColor.black
            nameLabel.text = self.getCurrentDate(section: indexPath.section)
            headView.addSubview(nameLabel)
            return headView
        }else{
            return UICollectionReusableView.init()
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return setUseCurrentModel(array: self.modelArray, section: section).count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SingleCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! SingleCollectionViewCell
        let model: BaseModel = setUseCurrentModel(array: self.modelArray, section: indexPath.section)[indexPath.row]
        cell.setCurrentImageView(imgName: model.name)
        return cell
        
    }
    
    //    字符串 -> 日期
    func stringToDate(_ string:String, dateFormat:String = "yyyy-MM-dd HH:mm:ss") -> Date {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = dateFormat
        let date = formatter.date(from: string)
        return date!
    }
    
    //    日期 -> 字符串
    func dateToString(_ date:Date, dateFormat:String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = dateFormat
        let date = formatter.string(from: date)
        return date
    }
    //    日期比较
    func dateCompare() -> Void {
        let date1 = Date()
        let date2 = Date()
        // date1 < date2 升序排列
        if date1.compare(date2) == .orderedAscending{
            print("<")
        }else if date1.compare(date2) == .orderedDescending{
            print("<")
        }else{
            print(" = ")
        }
    }
    
}

