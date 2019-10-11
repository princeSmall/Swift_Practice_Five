//
//  BaseTabBarController.swift
//  FiveDayStudy
//
//  Created by le tong on 2019/10/10.
//  Copyright © 2019 iOS. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let A = self.setChildViewController(vc: SingleViewController.init(), title: "照片", image: "photo_un", selectedImage: "photo")
        let B = self.setChildViewController(vc: GroupViewController.init(), title: "相册", image: "PhotoGroup_un", selectedImage: "PhotoGroup")
        self.viewControllers = [A,B]
        tabBar.barTintColor = UIColor.white
        tabBar.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
    }
    
    func setChildViewController(vc: UIViewController, title: NSString,image: NSString,selectedImage: NSString) -> UIViewController{
        let Nav = UINavigationController.init(rootViewController: vc)
//        去除导航栏黑线
        Nav.navigationBar.shadowImage = UIImage.init()
        Nav.navigationBar.backgroundImage(for: UIBarMetrics.default)
        Nav.tabBarItem.title = title as String
        Nav.tabBarItem.image = UIImage.init(named: image as String)?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        Nav.tabBarItem.selectedImage = UIImage.init(named: selectedImage as String)?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        
        return Nav
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
