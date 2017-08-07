//
//  testVC.swift
//  together
//
//  Created by Seven Tsai on 2017/7/23.
//  Copyright © 2017年 Seven Tsai. All rights reserved.
//

import UIKit

class testVC: UIViewController {
    func article() {
        self.navigationController?.pushViewController(
            test2VC(), animated: true)
    }
    
    func check() {
        print("check button action")
    }
    
    func gotoTest2() {
        self.navigationController?.pushViewController(test2VC(), animated: true)
//        let vc = storyboard?.instantiateViewController(withIdentifier: "test2vc")
//        
//        show(vc!, sender: self)
    }
    
    
    func btn_clicked(_ sender: UIBarButtonItem) {
        // Do something
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
        
        let rightButton = UIBarButtonItem(title: rightBtnTitle, style: .plain, target: self, action: #selector(self.article))
        
        // Create two buttons for the navigation item
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.rightBarButtonItem = rightButton
        
        // Assign the navigation item to the navigation bar
        navigationBar.items = [navigationItem]
        
        // Make the navigation bar a subview of the current view controller
        self.view.addSubview(navigationBar)
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
        addNavigationBar(mainTitle: "testVC", leftBtnTitle: "back", rightBtnTitle: "gotovc2")
        
        
        
        
        
        
        
        
        
        
        
//                let nav = UINavigationController(rootViewController: testVC())
//
//        
//            // 底色
////        self.view.backgroundColor = UIColor.darkGray
//        
//        // 導覽列標題
//        self.title = "首頁"
//        
//        // 導覽列底色
//        self.navigationController?.navigationBar.barTintColor =
//            UIColor.lightGray
//        
//        // 導覽列是否半透明
//        self.navigationController?.navigationBar.isTranslucent = true
//        
//        // 導覽列左邊按鈕
//        let leftButton = UIBarButtonItem(
//            image: UIImage(named:"check"),
//            style:.plain ,
//            target:self ,
//            action: #selector(self.check))
//        // 加到導覽列中
//        self.navigationItem.leftBarButtonItem = leftButton
//        
//        // 導覽列右邊按鈕
//        let rightButton = UIBarButtonItem(
//            title:"設定",
//            style:.plain,
//            target:self,
//            action:#selector(self.setting))
//        // 加到導覽列中
//        self.navigationItem.rightBarButtonItem = rightButton
//        
////        // 建立一個按鈕
////        let myButton = UIButton(frame: CGRect(
////            x: 0, y: 0, width: 120, height: 40))
////        
////        myButton.setTitle("ARt", for: .normal)
////        
////        
////        myButton.backgroundColor = UIColor.blue
////        
////        myButton.addTarget(self, action: #selector(self.check), for: .touchUpInside)
////        
////        
////        
////
//// 
////
////            
////        self.view.addSubview(myButton)
//        // Do any additional setup after loading the view.
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
