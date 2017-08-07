//
//  classPickerVC.swift
//  together
//
//  Created by Seven Tsai on 2017/7/18.
//  Copyright © 2017年 Seven Tsai. All rights reserved.
//

import UIKit

class classPickerVC: UIViewController, UIPickerViewDataSource,UIPickerViewDelegate {

    let listClass = ["food","電影","運動","旅遊","其他"]

    var selectedClass:String = ""

    
    
    
    //////////Class Picker
        //幾個滾筒
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        //多少筆資料
    
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//            if component == 0 {
            return listClass.count
//            }
        }
    
        //資料內容
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//            if component == 0 {
    
            return listClass[row]
//            }
        }
    //
        //使用者選擇的資料
    
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            if component == 0 {
    
            print("selectClass:\(listClass[row])")
    
    
                selectedClass = listClass[row]
                
                print("\(selectedClass)")
            
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
