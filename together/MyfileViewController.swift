//
//  MyfileViewController.swift
//  together
//
//  Created by iii-user on 2017/7/19.
//  Copyright © 2017年 Seven Tsai. All rights reserved.
//

import UIKit

class MyfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate {

    let app = UIApplication.shared.delegate as! AppDelegate
    var nametext:String?
    var detailtext:String?
    var personalpic:String?
    var imgDataBase64String:String?
    var subjectpic:Array<Any> = []
    var groupimg:Array<String> = []
    var images = [UIImage]()
    var subject:Array<String> = []
    
    @IBOutlet weak var groupname: UILabel!
    @IBOutlet weak var mygroupControl: UIPageControl!
    @IBOutlet weak var Mygroupimage: UIImageView!
    @IBOutlet weak var testlabel: UITextView!
    @IBAction func editBtn(_ sender: Any) {
        
        let nickname = nameText.text!
        let description = testlabel.text!
        
        let q = DispatchQueue.global()
        q.sync {
            do {
                
                let url = URL(string: "https://together-seventsai.c9users.io/resumeEdit.php")
                let session = URLSession(configuration: .default)
                var request = URLRequest(url:url!)
                request.httpBody = "account=\(self.app.account!)&nickname=\(nickname)&description=\(description)".data(using: .utf8)
                request.httpMethod = "POST"
                
                let task = session.dataTask(with: request, completionHandler: {(data, response , error) in
                    
                    
                    
                    
                    if  error != nil {
                        print("gg")
                    }else{
                        print("success")
                        
                    }
                    
                    
                })
                
                
                task.resume()
                
                
            }catch{
                print(error)
            }

        }
        q.async {
            sleep(1)
            self.loadDB()
        }
        
    }

    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameText: UITextField!
    
    @IBAction func loaddetail(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "Gpdetail")
        show(vc!, sender: self)
        
        
    }
    
    @IBAction func uploadsubmit(_ sender: Any) {
        
        personalpic = imgDataBase64String
        let url = URL(string: "https://together-seventsai.c9users.io/personalfileSavePic.php")
        let session = URLSession(configuration: .default)
        var req = URLRequest(url: url!)
        req.httpBody = "account=\(app.account!)&data=\(personalpic!)".data(using:.utf8)
        req.httpMethod = "POST"
        let task = session.dataTask(with: req, completionHandler: {(data,response,error) in
            if error == nil {
                print("add success")
                print(data)
            }else{
                print(error)
            }
        })
        task.resume()
    }
    
    
    @IBAction func takepic(_ sender: Any) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "use camera", style: .default, handler: {(action) in
            openCamera()
        })
        let libraryAction = UIAlertAction(title: "use library", style: .default, handler: {(action) in
            openLibrary()
        
        
        })
        let cancelAction = UIAlertAction(title: "cancel", style: .destructive, handler: {(action) in
           self.dismiss(animated: true, completion: nil)
        })
        
        alertController.addAction(cameraAction)
        alertController.addAction(libraryAction)
        alertController.addAction(cancelAction)
        
        if let popoverController = alertController.popoverPresentationController{
            popoverController.sourceView = view as? UIView
            popoverController.sourceRect = CGRect(x : self.view.bounds.midX, y : self.view.bounds.midY, width: 0, height: 0)
        }
        self.present(alertController, animated: true, completion: nil)
        
        func openCamera(){
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                
                let imgPickerTakeVC = UIImagePickerController()
                imgPickerTakeVC.sourceType = .camera
                imgPickerTakeVC.delegate = self
                
                show(imgPickerTakeVC, sender: self)
            }
        }
        
        func openLibrary(){
            let imgPickGetVC = UIImagePickerController()
            imgPickGetVC.sourceType = .photoLibrary
            imgPickGetVC.delegate = self
            
            if let popoverController = alertController.popoverPresentationController{
                popoverController.sourceView = view as? UIView
                popoverController.sourceRect = CGRect(x : self.view.bounds.midX, y : self.view.bounds.midY, width : 0 ,height : 0)
            }
            present(imgPickGetVC, animated: true, completion: nil)
        }
        
        func imagePickerController(_picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
            print("")
            let imgTaken = info[UIImagePickerControllerOriginalImage] as! UIImage
            imageView.image = imgTaken
            
            let imgData = UIImageJPEGRepresentation(imgTaken, 0.3)
            
            let imgDataBase64 = imgData?.base64EncodedData()
            
            imgDataBase64String = imgData?.base64EncodedString()
            
            dismiss(animated: true, completion: nil)
        }
        
        func imagePickerControllerDidCancel(_picker: UIImagePickerController){
            dismiss(animated: true, completion: nil)
        }
        
        
        
        
        
        
    }
    
   
     @IBAction func handleSwipeGesture(_ sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case UISwipeGestureRecognizerDirection.left:
            //left swipe
            if mygroupControl.currentPage < images.count {
                mygroupControl.currentPage += 1
            }
        case UISwipeGestureRecognizerDirection.right:
            //right swipe
            if mygroupControl.currentPage > 0 {
                mygroupControl.currentPage -= 1
            }
        default:
            return
        }
        Mygroupimage.image = images[mygroupControl.currentPage]
        groupname.text = self.subject[mygroupControl.currentPage]
    }
    
    func loadDB(){
        if let mid = String("8RM5OZY7f4cmj2YVPbN9eOIocm42") {
            
            //c9資料庫 post
            let url = URL(string: "https://together-seventsai.c9users.io/loadDatafromtable.php")
            let session = URLSession(configuration: .default)
            print("123465")
            
            var req = URLRequest(url: url!)
            
            req.httpMethod = "POST"
            req.httpBody = "mid=\(mid)".data(using: .utf8)
            
            let task = session.dataTask(with: req, completionHandler: {(data, response,error) in
                let source = String(data: data!, encoding: .utf8)
                
                //                print(source!)
                
                DispatchQueue.main.async {
                    do{
                        
                        
                        let jsonobj = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                        
                        for a in  jsonobj as! [[String:String]] {
                            var nickname = a["nickname"]!
                            var description = a["description"]
                            
                            self.nameText.text = nickname
                            self.testlabel.text = description
                            
                            print("987654")
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
    
    func loadmygroup(){
        
        
        if let mid = String("8RM5OZY7f4cmj2YVPbN9eOIocm42") {
            
            //c9資料庫 post
            let url = URL(string: "https://together-seventsai.c9users.io/loadtogetherdb.php")
            let session = URLSession(configuration: .default)
            
            
            var req = URLRequest(url: url!)
            
            req.httpMethod = "POST"
            req.httpBody = "mid=\(mid)".data(using: .utf8)
            
            let task = session.dataTask(with: req, completionHandler: {(data, response,error) in
                let source = String(data: data!, encoding: .utf8)
                
                //                print(source!)
                
                DispatchQueue.main.async {
                    do{
                        
                        
                        let jsonobj = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                        
                        for a in  jsonobj as! [[String:String]] {
                            
                            //var varsubjectpic = (a["subjectpic"]!)
                            self.subjectpic.append(a["subjectpic"])
                            self.subject.append(a["tid"]!)                            //print(self.subjectpic)
                            
                            
                        }
                        sleep(1)
                        self.putimage()
                        print("我是紗布傑克\(self.subject)")
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
    
    func putimage() {
        
        
        
                
                for i in 0..<self.subjectpic.count {
                    
                    var temp = self.subjectpic[i] as? String ?? ""
                    //print(type(of:temp))
                    //print(temp)
//                    if temp != "" {
                     do{
                        let url = URL(string:"\(temp)")
                        
                        if url != nil {
                            let data = try Data(contentsOf: url!)
                            images.append(UIImage(data: data)!)
                        }
                        //let data = try Data(contentsOf: url!)
                        //images.append(UIImage(data: data)!)
                        
                        
//                    }else {
//                        print("ok")
//                        images.append(UIImage(named: "question.jpg")!)
//                    }
                     }catch{
                        print(error)
                        images.append(UIImage(named: "question.jpg")!)
                    }
                
                
                
                
                
            }
        
        
        
        //print(subjectpic)
        //print(images)
        Mygroupimage.image = images[0]
        groupname.text =  self.subject[0]
        mygroupControl.numberOfPages = images.count
        
        
    }
    
    func loadimages(){
        print(images)
    }
    
    
    
    
   
    
    
    
    
    //let vc = storyboard?.instantiateViewController(withIdentifier: "Gpdetail")
    //show(vc!, sender: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDB()
        loadmygroup()
        //putimage()
        print(self.subject)
        print(app.mid)
        
//        DispatchQueue.global().sync {
//            putimage()
//        }
//        DispatchQueue.global().async {
//            sleep(2)
//            self.loadimages()
//        }
        //print(app.subjectpic)
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
