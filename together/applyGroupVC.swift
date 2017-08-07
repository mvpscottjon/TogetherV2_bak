//
//  applyGroupVC.swift
//  together
//
//  Created by Seven Tsai on 2017/7/29.
//  Copyright © 2017年 Seven Tsai. All rights reserved.
//

import UIKit

class applyGroupVC: UIViewController {
    /////先假裝給一個mid及tid
    
    //申請者是
    let mid = "0"
    //申請加入的團是
    let tid = "2"
    
    
    @IBAction func applyForGroup(_ sender: Any) {
        
        
        
        
        //https://together-seventsai.c9users.io/applyGroup.php
        
        
        let url = URL(string: "https://together-seventsai.c9users.io/applyGroup.php")
        let session = URLSession(configuration: .default)
        var req = URLRequest(url: url!)
        
        req.httpBody = "mid=\(mid)&tid=\(tid)".data(using: .utf8)
        
        req.httpMethod = "POST"
        
        let task = session.dataTask(with: req, completionHandler: {(data, response,error) in
            //        print(data)
            
            let source  =  String(data: data!, encoding: .utf8)
            
            print(source!)
            
            
            
        })
        
        task.resume()
        
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
