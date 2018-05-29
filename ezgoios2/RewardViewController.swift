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
    @IBAction func btn(_ sender: Any) {
        //  if btn.backgroundImage(UIImage(named: "exchange" ), for: UIControlState.normal)
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
    override func viewDidLoad() {
        super.viewDidLoad()
        //getDone()
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
    
    //    func getDone(){
    //        let defaults = UserDefaults.standard
    //        let name = defaults.string(forKey: "device id")
    //        let parameters = ["device_id" : name]
    //        guard let url = URL(string:"http://ezgo.twjoin.com/update")else{return}
    //        var request = URLRequest(url:url)
    //        request.httpMethod = "POST"
    //        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    //        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])else{return}
    //        request.httpBody = httpBody
    //
    //        let session = URLSession.shared
    //
    //        session.dataTask(with:request){(data,response,error) in
    //            if let response = response{
    //                print(response)
    //            }
    //            if let data = data{
    //                do{
    //                    let json = try JSONSerialization.jsonObject(with: data, options:[.allowFragments]) as? NSDictionary
    //                    //print(json)
    //                    //print(json!)
    //                    let val = (((json!.value(forKey: "userDone")!)) as AnyObject).value(forKey: "user_done")!
    //                    print(String(describing: val))
    //
    //                    if (String(describing: val).replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "\n", with: ""))=="1"{
    //                        UserDefaults.standard.set(true, forKey: "reward_done")
    //                        print("done")
    //                    }else{
    //                        UserDefaults.standard.set(false, forKey: "reward_done")
    //                        print("haven't done")
    //                    }
    //
    //                }catch{
    //                    print(error)
    //                }
    //            }
    //            }.resume()
    //
    //    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
