//
//  manageApplyViewVC.swift
//  together
//
//  Created by Seven Tsai on 2017/7/31.
//  Copyright © 2017年 Seven Tsai. All rights reserved.
//

import UIKit

class manageApplyViewVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tbView: UITableView!
    
    //mastatus = 0 時的陣列。 申請中
    var mydataGroup:Array<String> = []
    var mydataMaid:Array<String> = []
    var mydataStatus:Array<String> = []
    var mydataAdmitOrDeny:Array<String> = []
    //    //mastatus = 1 時的陣列  審核結束
    //    var mydataStatusFinish:Array<String> = []
    //    var mydataGroupFinish:Array<String> = []
    //    var mydataMaidFinish:Array<String> = []
    
    //會員id
    var mid:String?
    
 
    
    
    
    
    //ＴＢV數量
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return mydataGroup.count
    }
    
    
    
    //ＴＢ內容
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //////////這是table 我的揪團審核用的
        
        let cell = tbView.dequeueReusableCell(withIdentifier: "manageapplycell", for: indexPath) as! applyGroupTBVCell
        
     
        
        //        if mydataStatus[indexPath.row] == "0"  {
        //
        //        cell.labelStatus.text = "申請中"
        //
        //        }
        
        switch mydataStatus[indexPath.row] {
        case "0":
            cell.labelStatus.text = "申請中"
            
        case "1":
            if mydataAdmitOrDeny[indexPath.row] == "0" {
                cell.labelStatus.text = "拒絕申請"
            }
            if mydataAdmitOrDeny[indexPath.row] == "1" {
                cell.labelStatus.text = "允許進入"
                
            }
        default:
            break
        }
        
        
        
        cell.labelCell.text = mydataGroup[indexPath.row]
        
        
        
        return cell
        
        
        
    }
    
    
    //選擇ＴＢV的實作
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tbView.dequeueReusableCell(withIdentifier: "manageapplycell", for: indexPath) as! applyGroupTBVCell
        
        
        cell.labelCell.text = mydataGroup[indexPath.row]
        
        
        
        
    }
    
    
    
    ///VIEWDIDLOAD   讀取ＤＢ資料
    func loadDB(){
        
        
        mydataGroup = []
        mydataMaid = []
        mydataStatus = []
        //先假裝給一個tid
        let tid = "1"
        
        //c9資料庫 post
        let url = URL(string: "https://together-seventsai.c9users.io/getMyApplyGroup.php")
        let session = URLSession(configuration: .default)
        
        
        var req = URLRequest(url: url!)
        
        req.httpMethod = "POST"
        req.httpBody = "tid=\(tid)&mid=\(mid)".data(using: .utf8)
        
        let task = session.dataTask(with: req, completionHandler: {(data, response,error) in
            
            if data != nil{
                let source = String(data: data!, encoding: .utf8)
                
                //                print(source!)
                DispatchQueue.main.async {
                    do{
                        
                        
                        let jsonobj = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                        
                        for a in  jsonobj as! [[String:String]] {
                            
                            
                            //managegroupid
                            var maid = a["maid"]!
                            //managegroup 資料表 的狀態 0 表申請中,1表已審核
                            var mastatus = a["mastatus"]!
                            //1允許或0拒絕。
                            var admitordeny = a["admitordeny"]!
                            //申請的團tid
                            var applyGrouptId = a["applygrouptid"]!
                            //申請者mid
                            var applyUsermId = a["applyusermid"]!
                            //開團者mid
                            var openGroupmId = a["opengroupmid"]!
                            //主題名稱
                            var subject = a["subject"]!
                            
                            
                            
                            //                        var displayLebel = "id:\(maid)的揪團主題是\(subject),創辦者是\(openGroupmId),申請者是\(applyUsermId)"
                            
                            var displayLebel = "maid:\(maid)主題是\(subject),創辦者是\(openGroupmId),申請者是\(applyUsermId)"
                            
                            //                        print("manageid:\(maid)")
                            print("mastatus:\(mastatus)")
                            //                        print("揪團主題是\(subject)")
                            //                        print("揪團ＩＤ是\(applyGrouptId)")
                            //                        print("創辦者是\(openGroupmId)")
                            //                        print("申請者是\(applyUsermId)")
                            print("-----------")
                            
                            //全部顯示用
                            
                            if  applyUsermId == self.mid {
                                self.mydataStatus.append("\(mastatus)")
                                self.mydataGroup.append("\(displayLebel)")
                                self.mydataMaid.append("\(maid)")
                                self.mydataAdmitOrDeny.append("\(admitordeny)")
                            }
                            
                            
                            //                            //如果狀態為申請中 且 申請者id ＝使用者id
                            //                            if mastatus == "0" &&  applyUsermId == self.mid {
                            //                                self.mydataStatus.append("\(mastatus)")
                            //                                self.mydataGroup.append("\(displayLebel)")
                            //                                self.mydataMaid.append("\(maid)")
                            //                            }
                            
                            //                            // 如果狀態為審核結束 且 申請者id ＝ 使用者id
                            //                            if mastatus == "1" &&  applyUsermId == self.mid {
                            //                                self.mydataStatusFinish.append("\(mastatus)")
                            //                                self.mydataGroupFinish.append("\(displayLebel)")
                            //                                self.mydataMaidFinish.append("\(maid)")
                            //                            }
                            
                            
                        }
                        
                        self.tbView.reloadData()
                        
                    }catch {
                        print("thisis \(error)")
                    }}
                
                
                
            }
       
        })
        
        task.resume()
   
    }
    
    
    
    func handleRefresh(){
        
        tbView.refreshControl?.endRefreshing()
        
        
        loadDB()
        tbView.reloadData()
    }
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let app = UIApplication.shared.delegate as! AppDelegate
        mid = app.mid
        
        if mid == nil {
            mid = "0"
        }
        
        print("manaApplyViewVC我是使用者：\(mid!)")
        loadDB()
        
        tbView.refreshControl = UIRefreshControl()
        tbView.refreshControl?.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tbView.refreshControl?.attributedTitle = NSAttributedString(string: "更新中")
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
