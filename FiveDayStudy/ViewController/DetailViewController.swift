//
//  DetailViewController.swift
//  FiveDayStudy
//
//  Created by le tong on 2019/10/10.
//  Copyright © 2019 iOS. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    let identifier = "identifier"
    var imgName: String = ""
    var detailCollectionView: UICollectionView!
    
    
    var modelArray: [BaseModel] = NSMutableArray.init() as! [BaseModel]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        getModel()
        self.setCurrentdetailCollectionView()
        // Do any additional setup after loading the view.
    }
    func getModel() -> Void {
        let currentModelArray: [BaseModel] = CurrentModel.init().Array
        for name in currentModelArray{
            if name.group == imgName {
                modelArray.append(name)
            }
        }
//        特殊处理所有照片
        if imgName == "所有照片" {
            modelArray = currentModelArray
        }
    }
    func setCurrentdetailCollectionView() -> Void {
        let flow = UICollectionViewFlowLayout.init()
        flow.itemSize = CGSize.init(width: view.frame.width / 4.0 - 5, height: view.frame.width / 4.0 - 5)
        flow.minimumLineSpacing = 5
        flow.minimumInteritemSpacing = 5
    
        self.detailCollectionView = UICollectionView.init(frame: view.bounds, collectionViewLayout: flow)
        self.detailCollectionView.delegate = self
        self.detailCollectionView.dataSource = self
        self.detailCollectionView.register(DetailCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: identifier)
        
       self.detailCollectionView.backgroundColor = UIColor.white
        view.addSubview(self.detailCollectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modelArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DetailCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! DetailCollectionViewCell
        let model: BaseModel = modelArray[indexPath.row]
        cell.setCurrentImageView(imgName: model.name)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
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
