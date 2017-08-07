//
//  test2VC.swift
//  together
//
//  Created by Seven Tsai on 2017/7/24.
//  Copyright © 2017年 Seven Tsai. All rights reserved.
//

import UIKit

class test2VC: UIViewController {
    func gotoTest2() {
        self.navigationController?.pushViewController(test2VC(), animated: true)
    }
    
    
    func btn_clicked(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func addNavigationBar(mainTitle:String,leftBtnTitle:String,rightBtnTitle:String){
        
        //        let mainTitle = mainTitle
        //        let leftBtnTitle = leftBtnTitle
        //        let rightBtnTitle =rightBtnTitle
        
        
        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height:44)) // Offset by 20 pixels vertically to take the status bar into account
        
        navigationBar.backgroundColor = UIColor.white
        
        
        // Create a navigation item with a title
        let navigationItem = UINavigationItem()
        navigationItem.title = mainTitle
        
        // Create left and right button for navigation item
        let leftButton =  UIBarButtonItem(title: leftBtnTitle, style:   .plain, target: self, action: #selector(self.btn_clicked(_:)))
        
        let rightButton = UIBarButtonItem(title: rightBtnTitle, style: .plain, target: self, action: #selector(self.gotoTest2))
        
        // Create two buttons for the navigation item
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.rightBarButtonItem = rightButton
        
        // Assign the navigation item to the navigation bar
        navigationBar.items = [navigationItem]
        
        // Make the navigation bar a subview of the current view controller
        self.view.addSubview(navigationBar)
        
        
        
    }
    
    func edit() {
        print("edit action")
    }
    
    func back() {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        addNavigationBar(mainTitle: "test2VC", leftBtnTitle: "back", rightBtnTitle: "setting")
            // 底色
        self.view.backgroundColor = UIColor.white
        
        // 導覽列標題
        self.title = "Article"
        
        // 導覽列底色
        self.navigationController?.navigationBar.barTintColor =
            UIColor.cyan
        
        // 導覽列是否半透明
        self.navigationController?.navigationBar.isTranslucent = false
        
        // 導覽列右邊按鈕
        let rightButton = UIBarButtonItem(
            barButtonSystemItem: .edit,
            target: self,
            action: #selector(self.edit))
        // 加到導覽列中
        self.navigationItem.rightBarButtonItem = rightButton
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
