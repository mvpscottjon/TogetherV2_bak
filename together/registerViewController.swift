//
//  registerViewController.swift
//  together
//
//  Created by ooo on 03/08/2017.
//  Copyright © 2017 Seven Tsai. All rights reserved.
//

import UIKit
import Firebase
class registerViewController: UIViewController {

    let app = UIApplication.shared.delegate as! AppDelegate
    var passwd:String?
    var account:String?
    var isLogin = true
    var id:String?
    
    
    
    
    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    @IBOutlet weak var nicknameText: UITextField!
    
    
    @IBAction func registerBtn(_ sender: Any) {
        
        let url = URL(string: "https://together-seventsai.c9users.io/addMemberv2.php")
        var request = URLRequest(url: url!)
        if emailText.text != "" && passwordText.text != "" && nicknameText.text != ""{
            
            passwordText.isSecureTextEntry = true
            
            let account = emailText.text!
            let passwd = passwordText.text!
            let nickname = nicknameText.text!
            
            Auth.auth().createUser(withEmail: self.emailText.text!, password: self.passwordText.text!) { (user, error) in
                if error != nil {
                    self.alertWrong()
                    print("error")
                }else {
                    
                    Properties.user = User1(authData: user!)
                    self.app.mid = Properties.user?.uid
                    let mid = self.app.mid!
                    
                    do {
                        let urlGet = URL(string: "https://together-seventsai.c9users.io/addMemberv2.php?account=\(account)&passwd=\(passwd)&mid=\(mid)&nickname=\(nickname)")
                        let source = try String(contentsOf: urlGet!, encoding: .utf8)
                        
                        if source == "accountok" {
                            print("add OK")
                            self.app.account = account
                            
                            //Properties.user = User1(authData: user!)
                            
                            
                            self.alertSuccess()
                            print("show")
                            
                            
                        }else if source == "accountexist" {
                            
                            print("exist")
                            self.alertExist()
                            
                            
                        }else {
                            print("else")
                        }
                        
                        
                    }catch{
                        print(error)
                    }
                    
                }
            }
            
            
        }else {
            print("no words")
            alertEmpty()
        }
        
    }
    
    
    //驗證密碼安全性
    func isPasswordValid(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    
    //alert 空白
    func alertEmpty() {
        
        let alertController = UIAlertController(title: "帳號申請/登入/暱稱", message: "不能空白喔！", preferredStyle: .alert)
        let okaction = UIAlertAction(title: "確認", style: .default, handler: {(action) in
            self.dismiss(animated: true, completion: nil)
            
        })
        
        alertController.addAction(okaction)
        self.present(alertController, animated: true, completion: nil)
        
        
    }
    //alert 存在
    func alertExist() {
        let alertController = UIAlertController(title: "帳號已重複", message: "請重新輸入", preferredStyle: .alert)
        let okaction = UIAlertAction(title: "確認", style: .default, handler: {(action) in
            self.dismiss(animated: true, completion: nil)
        })
        
        alertController.addAction(okaction)
        self.present(alertController, animated: true, completion: nil)
    }
    //alert 錯誤
    func alertWrong() {
        let alertController = UIAlertController(title: "帳號登入", message: "帳號重複或密碼小於6碼", preferredStyle: .alert)
        let okaction = UIAlertAction(title: "確認", style: .default, handler: {(action) in
            self.dismiss(animated: true, completion: nil)
        })
        
        alertController.addAction(okaction)
        self.present(alertController, animated: true, completion: nil)
    }
    //register 成功
    func alertSuccess() {
        app.mid = Properties.user?.uid
        
        let alertController = UIAlertController(title: "帳號註冊", message: "註冊成功", preferredStyle: .alert)
        let okaction = UIAlertAction(title: "確認", style: .default, handler: {(action) in
            go()
        })
        
        
        func go(){
            ////幫修改為tabbarvc
            let vc = storyboard?.instantiateViewController(withIdentifier: "tabbarvc")
            show(vc!, sender: self)
        }
        
        
        
        alertController.addAction(okaction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
