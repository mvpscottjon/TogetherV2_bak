//
//  EditresumeView.swift
//  together
//
//  Created by iii-user on 2017/7/19.
//  Copyright © 2017年 Seven Tsai. All rights reserved.
//

import UIKit

class EditresumeView: UIViewController {

    let app = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet weak var nicknameText: UITextField!
    
    
    @IBOutlet weak var descriptionText: UITextView!
    
    
    @IBAction func update(_ sender: Any) {
        
        let nickname = nicknameText.text!
        let description = descriptionText.text!
        
        
        do {
            
            let url = URL(string: "https://together-seventsai.c9users.io/edit.php")
            let session = URLSession(configuration: .default)
            var request = URLRequest(url:url!)
            request.httpBody = "account=\(app.account!)&nickname=\(nickname)&description=\(description)".data(using: .utf8)
            request.httpMethod = "POST"
            
            let task = session.dataTask(with: request, completionHandler: {(data, response , error) in
                
                
                
                
                if  error != nil {
                    print("gg")
                }else{
                    print("success")
                    
                }
                
                
            })
            
            
            task.resume()
            loadDB()
            
        }catch{
            print(error)
        }
        
    }
    
    @IBAction func back(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MyfileViewController1")
        show(vc!, sender: self)
    }
    
    func loadDB(){
        if let account = app.account {
            
            //c9資料庫 post
            let url = URL(string: "https://together-seventsai.c9users.io/loadDatafromtable.php")
            let session = URLSession(configuration: .default)
            
            
            var req = URLRequest(url: url!)
            
            req.httpMethod = "POST"
            req.httpBody = "account=\(account)".data(using: .utf8)
            
            let task = session.dataTask(with: req, completionHandler: {(data, response,error) in
                let source = String(data: data!, encoding: .utf8)
                
                //                print(source!)
                
                DispatchQueue.main.async {
                    do{
                        
                        
                        let jsonobj = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                        
                        for a in  jsonobj as! [[String:String]] {
                            var nickname = a["nickname"]!
                            var description = a["description"]
                            self.nicknameText.text = nickname
                            self.descriptionText.text = description
                        }
                        
                        
                        //self.tbView.reloadData()
                        
                    }catch {
                        print("thisis \(error)")
                    }}
                
                
                
                
                
            })
            
            task.resume()
            
        }else {
            
            //沒輸入帳號直接跑到的話 給他一個假帳號
            print("no account")
            
                    }
        
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
