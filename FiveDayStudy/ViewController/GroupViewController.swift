//
//  GroupViewController.swift
//  FiveDayStudy
//
//  Created by le tong on 2019/10/10.
//  Copyright © 2019 iOS. All rights reserved.
//

import UIKit

class GroupViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    let identifier: String = "identifier"
    let headIdentifier: String = "headIdentifier"
    var groupCollectionView: UICollectionView!
    
    var modelArray:[BaseModel] = CurrentModel.init().Array
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.navigationItem.title = "相册"
        setCurrentgroupCollectionView()
        // Do any additional setup after loading the view.
    }
    
//    获取不同的组
    func getGroupFromModel() -> NSArray {
        let dic: NSMutableDictionary = NSMutableDictionary.init()
        let groupArray: NSMutableArray = NSMutableArray.init()
//        获取组名
        for baseModel in modelArray {
            groupArray.add(baseModel.group)
        }
//        去除重复的组名
        for group in groupArray {
            dic.setObject(group, forKey: group as! NSCopying)
        }
        let array:NSMutableArray = NSMutableArray (array: dic.allKeys)
        array.insert("所有照片", at: 0)
        return array
    }
//    根据不同组，获取每个组的总数，每个组的一个图片
    func getImgNameFromGroup(row: Int) -> String {
        let name = getGroupFromModel()[row] as! String
        var group = ""
        self.count = 0
        
        for model in modelArray {
            if name == model.group{
                group = model.name
                self.count += 1
            }
        }
//        特殊处理所有照片：选取第一个为展示图片，数目为 所有
        if name == "所有照片" {
            self.count = modelArray.count
            let model: BaseModel = modelArray[0]
            group = model.name
        }
        return group
    }
    func setCurrentgroupCollectionView() -> Void {
        let flow = UICollectionViewFlowLayout.init()
        flow.itemSize = CGSize.init(width: (view.frame.width - 20) / 3.0 - 5, height: (view.frame.width - 20) / 3.0 + 40)
        flow.minimumLineSpacing = 10
        flow.minimumInteritemSpacing = 5
        
        groupCollectionView = UICollectionView.init(frame: CGRect(x: 10, y: 74, width: view.frame.width - 20, height: view.frame.height - 74), collectionViewLayout: flow)
        groupCollectionView.delegate = self
        groupCollectionView.dataSource = self
        groupCollectionView.register(GroupCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: identifier)
        
        groupCollectionView.backgroundColor = UIColor.white
        view.addSubview(groupCollectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getGroupFromModel().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: GroupCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! GroupCollectionViewCell
        cell.setCurrentUI(imgName: getImgNameFromGroup(row: indexPath.row), name: getGroupFromModel()[indexPath.row] as! String, count: self.count)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.imgName = getGroupFromModel()[indexPath.row] as! String
        self.navigationController?.pushViewController(detailVC, animated: true)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
