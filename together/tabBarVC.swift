//
//  tabBarVC.swift
//  together
//
//  Created by Seven Tsai on 2017/8/11.
//  Copyright © 2017年 Seven Tsai. All rights reserved.
//

import UIKit

class tabBarVC: UITabBarController {

    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print("tabbar select")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
