//
//  ViewController.swift
//  together
//
//  Created by Seven Tsai on 2017/7/17.
//  Copyright © 2017年 Seven Tsai. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController {

    
    let app = UIApplication.shared.delegate as! AppDelegate
   
    let loginObj = loginViewController()
    
    /////直接以a帳號登入用
    @IBAction func aAccountLogin(_ sender: Any) {
        app.mid = "kO2iktB0BHRkDEhZVn8ds0s3G572"
       
     go()
        
      
    }
    /////直接以s帳號登入用
    @IBAction func sAccountLogin(_ sender: Any) {
         app.mid = "PaN9703dbLZ5s13wEjopxXCLMu52"
        go()
        
    }
    
    
    @IBAction func QLogin(_ sender: Any) {
        app.mid = "Bdsl773vHqTAVw4xwKQ2AsHRDKk1"
        go()
    }
    
    
    
    
    ////直接登入用
    func go(){
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "tabbarvc")
        show(vc!, sender: self)
    }
   


    //大家可以回家的segue
    @IBAction func home(_sender:UIStoryboardSegue){
        
        print("back home")
    }
    
    
    
    @IBAction func Gotomyile(_ sender: Any) {
        //let vc = storyboard?.instantiateViewController(withIdentifier: "MainView")
       // show(vc!, sender: self)
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "MyfileViewController1")
        show(vc!, sender: self)
    }
    
    
    
    @IBOutlet weak var segmentedController: UISegmentedControl!
    
    @IBOutlet weak var loginView: UIView!
    
    @IBOutlet weak var registerView: UIView!
    
    @IBAction func segmentValue(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            self.loginView.isHidden = false
            self.registerView.isHidden = true
        case 1:
            self.registerView.isHidden = false
            self.loginView.isHidden = true
        default:
            break
        }
    }
    
   
    func isPasswordValid(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
           return passwordTest.evaluate(with: password)
    }
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let app = UIApplication.shared.delegate as! AppDelegate

        self.loginView.isHidden = false
        self.registerView.isHidden = true
        
        
        //isLogin = true
        //addMemberOrLogin()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    //MyfileViewController1
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

