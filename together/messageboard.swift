//
//  messageboard.swift
//  together
//
//  Created by ooo on 27/07/2017.
//  Copyright © 2017 Seven Tsai. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class messageboard: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var reviewBtn: UIButton!
    
    @IBAction func reviewtestBtn(_ sender: Any) {
        alertReview()
    }
    
     var groupReviews: [GroupReviewItem] = [GroupReviewItem]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // reviewView.isHidden = true
        self.reviewBtn.isEnabled = false
        // 查詢節點資料
        let reference: DatabaseReference! = Database.database().reference().child("groupReviews").child("groupId-0000001")
        
        reference.queryOrderedByKey().observe(.value, with: { snapshot in
           if snapshot.childrenCount > 0 {
                var dataList: [GroupReviewItem] = [GroupReviewItem]()
                
                for item in snapshot.children {
                    let data = GroupReviewItem(snapshot: item as! DataSnapshot)
                    dataList.append(data)
                }
                
                self.groupReviews = dataList
                self.tableview.reloadData()
            }
            
            self.reviewBtn.isEnabled = true
        })
        
        
        
        

        // Do any additional setup after loading the view.
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.groupReviews.count
    }
    
    // 表格的儲存格設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupReviewTableViewCell", for: indexPath) as! GroupReviewTableViewCell
        
        cell.reViewTextView?.text = self.groupReviews[indexPath.row].groupReview
        cell.loginUser.text = self.groupReviews[indexPath.row].userEmail
        
        return cell
    }
 
    
    
    
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Msgboard" {
            _ = segue.destination as! MsgtableViewController
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // use alert function to edit review
    
    func alertReview() {
        let alert = UIAlertController(title: "輸入留言", message: "請輸入留言", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: {(action) in
           self.dismiss(animated: true, completion: nil)
        
        })
        
        let reviewAction = UIAlertAction(title: "留言", style: .default, handler: {(action) in
           
            let reviewText = alert.textFields![0].text as! String
            
            //print ("\(reviewText)")
            
            if reviewText == "" {
                self.alertEmpty()
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
            movieReview["groupReview"] = reviewText as AnyObject
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
            
            
            
            
            
            
            
            
        
        })
        
        alert.addTextField {
            (textField) in textField.placeholder = "留言"
        }
        
        alert.addAction(cancelAction)
        alert.addAction(reviewAction)
        
        show(alert, sender: self)
        
        
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
    
    

   
}
