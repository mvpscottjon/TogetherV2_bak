//
//  manageGroupVC.swift
//  together
//
//  Created by Seven Tsai on 2017/7/28.
//  Copyright © 2017年 Seven Tsai. All rights reserved.
//
/////////揪團管理頁的外匡
import UIKit

class manageGroupVC: UIViewController{
//    @IBOutlet weak var tbView: UITableView!
//    @IBOutlet weak var segmentOutlet: UISegmentedControl!
    
    @IBOutlet weak var segmentOutlet: UISegmentedControl!
    
    @IBOutlet weak var containerManageGroup: UIView!
    @IBOutlet weak var containerApplyGroup: UIView!

    @IBOutlet weak var containerMyAllOpenGroup: UIView!
    //會員id
    var mid:String?
    
    
    
    @IBAction func logout(_ sender: Any) {
        dismiss(animated: true , completion: nil)
    }
    
    
//    //////btn to 我的所有揪團
//    @IBAction func toMyAllGroup(_ sender: Any) {
//        let vc = storyboard?.instantiateViewController(withIdentifier: "myallopengroupvc")
//        show(vc!, sender: self)
//    }
    
    @IBAction func segmetAction(_ sender: Any) {
        switch segmentOutlet.selectedSegmentIndex {
        case 0:
            apperaPage1()
        case 1:
            apperaPage2()
        default:
            break
        }
        
    }
    
    
    
    
    
    
    
    func apperaPage1(){
      containerManageGroup.isHidden = true
        containerMyAllOpenGroup.isHidden = false
        containerApplyGroup.isHidden = true
    }
    func apperaPage2(){
//        containerManageGroup.isHidden = true
        containerMyAllOpenGroup.isHidden = true
        containerApplyGroup.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let app = UIApplication.shared.delegate as! AppDelegate
        mid = app.mid
        
        if mid == nil {
            mid = "0"
        }
        
        print("manageGroupVC我是使用者：\(mid!)")
        apperaPage1()
        
        
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    
}
