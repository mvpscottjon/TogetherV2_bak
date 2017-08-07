//
//  segmentMapListVC.swift
//  together
//
//  Created by Chuei-Ching Chiou on 04/08/2017.
//  Copyright © 2017 Seven Tsai. All rights reserved.
//

import UIKit

class resultMapListVC: UIViewController {
    
    var app = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var contViewList: UIView!
    @IBOutlet weak var contViewMap: UIView!
    @IBAction func toEditSearch(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "searchvc") as! searchGroupVC
        
        show(vc, sender: self)
        
    }
    
    @IBAction func didEditSearch(_ sender: UIStoryboardSegue) {
        print("修改了搜尋條件")
    }
    
    
    @IBAction func changeShowMode(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            print("List")
            
            contViewMap.isHidden = true
            contViewList.isHidden = false
            
        case 1:
            print("Map")
            
            contViewMap.isHidden = false
            contViewList.isHidden = true
            
        default:
            print("Map")
            
            contViewMap.isHidden = false
            contViewList.isHidden = true
            
            break
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.segmentedControl.selectedSegmentIndex = 1 // Map
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.changeShowMode(segmentedControl)
        
        self.loadTogetherDB()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    public func loadTogetherDB() {
        
        let url = URL(string: "https://together-seventsai.c9users.io/loadtogetherdb.php")
        let session = URLSession(configuration: .default)
        
        var req = URLRequest(url: url!)
        
        req.httpMethod = "POST"
        req.httpBody = "mid=\(app.mid!)".data(using: .utf8)
        
        let task = session.dataTask(with: req, completionHandler: {(data, response, error) in
        
            let source = String(data: data!, encoding: .utf8)
            print(source)
            
        })
        
        task.resume()
    }


}
