//
//  RewardViewController.swift
//  ezgo1
//
//  Created by Administrator on 2018/5/5.
//  Copyright © 2018年 vickyliao. All rights reserved.
//

import UIKit

class RewardViewController: UIViewController {
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var btn: UIButton!
    /*
     if UserDefaults.standard.bool(forKey: "reward_done")==false{
     
     updateReward(user_id:String((UserDefaults.standard.string(forKey: "user_id"))!).replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "\n", with: "")){ConnectionResult3 in
     switch ConnectionResult3{
     case .failure(let error):
     print(error)
     case .success(let data):
     print("success")
     }
     }
     UserDefaults.standard.set(true, forKey: "reward_done")
     btn.setBackgroundImage(UIImage(named: "notexchange" ), for: UIControlState.normal)
     print("exchange")
     }
     if UserDefaults.standard.bool(forKey: "reward_done")==true{
     //UserDefaults.standard.set(false, forKey: "reward_done")
     btn.setBackgroundImage(UIImage(named: "notexchange" ), for: UIControlState.normal)
     print("can't exchange")
     }*/
    
    @IBAction func okAction(sender: UIButton){
        if UserDefaults.standard.bool(forKey: "reward_done")==false{
            
            updateReward(user_id:String((UserDefaults.standard.string(forKey: "user_id"))!).replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "\n", with: "")){ConnectionResult3 in
                switch ConnectionResult3{
                case .failure(let error):
                    print(error)
                case .success(let data):
                    print("success")
                }
            }
            UserDefaults.standard.set(true, forKey: "reward_done")
            btn.setBackgroundImage(UIImage(named: "notexchange" ), for: UIControlState.normal)
            print("exchange")
        }
        if UserDefaults.standard.bool(forKey: "reward_done")==true{
            //UserDefaults.standard.set(false, forKey: "reward_done")
            btn.setBackgroundImage(UIImage(named: "notexchange" ), for: UIControlState.normal)
            print("can't exchange")
        }
    }
    
    @IBAction func btn(_ sender: Any) {
        //  if btn.backgroundImage(UIImage(named: "exchange" ), for: UIControlState.normal)
        
        if UserDefaults.standard.bool(forKey: "reward_done")==false{
            // 建立一個提示框
            let alertController = UIAlertController(
                title: "注意",
                message: "你確定兌換?",
                preferredStyle: .alert)
            
            // 建立[取消]按鈕
            let cancelAction = UIAlertAction(
                title: "取消",
                style: .cancel,
                handler: nil)
            alertController.addAction(cancelAction)
            
            let okAction = UIAlertAction(
                title: "確認",
                style: .default,
                handler: {
                    (action: UIAlertAction!) -> Void in
                    if UserDefaults.standard.bool(forKey: "reward_done")==false{
                        updateReward(user_id:String((UserDefaults.standard.string(forKey: "user_id"))!).replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "\n", with: "")){ConnectionResult3 in
                            switch ConnectionResult3{
                            case .failure(let error):
                                print(error)
                            case .success(let data):
                                print("success")
                            }
                        }
                        UserDefaults.standard.set(true, forKey: "reward_done")
                        self.btn.setBackgroundImage(UIImage(named: "notexchange" ), for: UIControlState.normal)
                        print("exchange")
                    }
                    if UserDefaults.standard.bool(forKey: "reward_done")==true{
                        //UserDefaults.standard.set(false, forKey: "reward_done")
                        self.btn.setBackgroundImage(UIImage(named: "notexchange" ), for: UIControlState.normal)
                        print("can't exchange")
                    }
                    UserDefaults.standard.set(true, forKey: "hasChangedReward")
            })
            alertController.addAction(okAction)
            
            
            // 顯示提示框
            self.present(
                alertController,
                animated: true,
                completion: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //getDone()
        if UserDefaults.standard.bool(forKey: "hasChangedReward") == true{
            btn.setBackgroundImage(UIImage(named: "exchange" ), for: UIControlState.normal)
            UserDefaults.standard.set(true, forKey: "reward_done")
        }else{
            btn.setBackgroundImage(UIImage(named: "notexchange" ), for: UIControlState.normal)
            UserDefaults.standard.set(false, forKey: "reward_done")
        }
        print(UserDefaults.standard.bool(forKey: "reward_done"))
        // 取得螢幕的尺寸
        let fullScreenSize = UIScreen.main.bounds.size
        //UserDefaults.standard.set(false, forKey: "reward_done")
        image1.frame = CGRect(x: Int((fullScreenSize.width * 0.225)) , y:Int((fullScreenSize.height * 0.47)) , width: Int((fullScreenSize.width * 0.55)) , height: Int((fullScreenSize.height * 0.25)))
        image1.image = UIImage(named:"dog_exchange")
        btn.frame = CGRect(x: Int((fullScreenSize.width * 0.15)) , y:Int((fullScreenSize.height * 0.72)) , width: Int((fullScreenSize.width * 0.7)) , height: Int((fullScreenSize.width * 0.2)))
        if UserDefaults.standard.bool(forKey: "reward_done")==false{
            btn.setBackgroundImage(UIImage(named: "exchange" ), for: UIControlState.normal)
        }else{
            btn.setBackgroundImage(UIImage(named: "notexchange" ), for: UIControlState.normal)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


