//
//  MsgtableViewController.swift
//  together
//
//  Created by ooo on 29/07/2017.
//  Copyright © 2017 Seven Tsai. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
class MsgtableViewController: UIViewController {

    
    @IBOutlet weak var review: UITextView!
    
    @IBAction func back(_ sender: Any) {
    }
    
    
    
    
    
    @IBAction func save(_ sender: Any) {
        
        if self.review.text == "" {
            alertEmpty()
            return
        }
        
        // 新增節點資料
        let reference: DatabaseReference! = Database.database().reference().child("groupReviews").child("groupId-0000001")
        let childRef: DatabaseReference = reference.childByAutoId() // 隨機生成的節點唯一識別碼，用來當儲存時的key值
        
        // get date
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/M/d H:m"
        let string = formatter.string(from: Date())
        
        
        //id name 再修正為團名以及ID        
        var movieReview: [String : AnyObject] = [String : AnyObject]()
        movieReview["groupId"] = "groupId-0000001" as AnyObject
        movieReview["childId"] = childRef.key as AnyObject
        movieReview["groupName"] = "玩命關頭8" as AnyObject
        movieReview["groupReview"] = self.review.text as AnyObject
        movieReview["userId"] = (Properties.user?.uid)! as AnyObject
        movieReview["userEmail"] = (Properties.user?.email)! as AnyObject
        movieReview["createDate"] = "\(string)" as AnyObject
        
        
        
        
        let movieReviewReference = reference.child(childRef.key)
        movieReviewReference.updateChildValues(movieReview) { (err, ref) in
            if err != nil{
                print("err： \(err!)")
                return
            }
            
            print(ref.description())
            
            // 返回上一頁
            //_ = self.navigationController?.popViewController(animated: true)
            self.go()
            
            
        }
        
 
        
        
        
        
        
    }
    
    
    func go(){
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "testvc")
        show(vc!, sender: self)
    }
    
    
    func alertEmpty() {
        
        let alertController = UIAlertController(title: "請輸入評論", message: "不能空白喔！", preferredStyle: .alert)
        let okaction = UIAlertAction(title: "確認", style: .default, handler: {(action) in
            self.dismiss(animated: true, completion: nil)
            
        })
        
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
