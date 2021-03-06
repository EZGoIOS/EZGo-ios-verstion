//
//  Q1.swift
//  闖關單
//
//  Created by Administrator on 2018/3/1.
//  Copyright © 2018年 Administrator. All rights reserved.
//

import UIKit
//btn_reward0
class Q1: UIViewController {
    @IBOutlet weak var btnSure: UIButton!
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn1: UIButton!
    var aaaa = Int()
    var frequency = Int() //作答次數
    var answer:Int = 0
    var recArray:Array<String> = []
    var showAns:Array<String> = []
    var showDescript:Array<String> = []
    var options:Array<String> = []
    var option:Array<String> = []
    var showId:Array<String> = []
    
    var whichAnimal = Int()
    
    
    @IBOutlet weak var lblshow: UILabel!
    @IBAction func btn1(_ sender: Any) {
        answer = 1
        btn1.setBackgroundImage(UIImage(named: "optionclick_a" ), for: UIControlState.normal)
        btn2.setBackgroundImage(UIImage(named: "optionb" ), for: UIControlState.normal)
        
    }
    @IBAction func btn2(_ sender: Any) {
        answer = 2
        btn2.setBackgroundImage(UIImage(named: "optionclick_b" ), for: UIControlState.normal)
        btn1.setBackgroundImage(UIImage(named: "optiona" ), for: UIControlState.normal)
        
    }
    @IBAction func btnSure(_ sender: Any) {
        
        
        if answer != 0{
            let Ans:String = showAns[frequency-1]
            var correct:String = "0"
            if Ans == String(answer){
                correct = "1"
            }else{
                correct = "0"
            }
            updateWorksheet(user_id:String((UserDefaults.standard.string(forKey: "user_id"))!).replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "\n", with: ""),correct:correct,question_id:showId[frequency-1]){
                ConnectionResult2 in
                switch ConnectionResult2{
                case .failure(let error):
                    print(error)
                    
                case .success( _):
                    print("success")
                }
            }
            performSegue(withIdentifier: "Q1gotoA1", sender: self)
        }else {
            if UserDefaults.standard.bool(forKey: "english")==true{
                let alert = UIAlertView()
                alert.title = "Notice！"
                alert.message = "You didn't choose"
                alert.addButton(withTitle: "OK")
                alert.show()
            }else{
                let alert = UIAlertView()
                alert.title = "注意！"
                alert.message = "你沒選選項"
                alert.addButton(withTitle: "OK")
                alert.show()
            }
        }
    }
    
    func whichKnowledge(whichOne:Int) -> String {
        var picture:String
        switch whichOne {
        case 1:
            picture = "worksheet_title_hyena.png"
        case 2:
            picture = "worksheet_title_bear.png"
        case 3:
            picture = "wolf_title.png"
        case 4:
            picture = "worksheet_title_prairiedog.png"
        case 5:
            picture = "worksheet_title_kookaburra.png"
        case 6:
            picture = "deer_title.png"
            
        default:
            picture = "GG"
        }
        return picture
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let xx = segue.destination as!A1
        xx.answer = answer
        xx.frequency = frequency
        xx.recArray = recArray
        xx.whichAnimal = whichAnimal
        xx.showAns = showAns
        xx.showDescript = showDescript
        xx.options = options
        xx.showId = showId
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // 取得螢幕的尺寸
        let fullScreenSize = UIScreen.main.bounds.size
        //-------------背景設定-------------
        image.frame = CGRect(x:0, y:0 , width: (fullScreenSize.width) , height:(fullScreenSize.height))
        //--------------圖片設定-----------
        image1.frame = CGRect(x: Int((fullScreenSize.width * 0.125)) , y:Int((fullScreenSize.height * 0.07)) , width: Int((fullScreenSize.width * 0.75)) , height: Int((fullScreenSize.height * 0.18)))
        image1.image = UIImage(named: whichKnowledge(whichOne:whichAnimal))
        image2.frame = CGRect(x: Int((fullScreenSize.width * 0.685)) , y:Int((fullScreenSize.height * 0.123)) , width: Int((fullScreenSize.width * 0.13)) , height: Int((fullScreenSize.width * 0.13)))
        if frequency == 1{image2.image = UIImage(named: "number_wood_1.png")}
        if frequency == 2{image2.image = UIImage(named: "number_wood_2.png")}
        if frequency == 3{image2.image = UIImage(named: "number_wood_3.png")}
        
        //-----------按鈕設定---------------
        btn1.frame = CGRect(x: Int((fullScreenSize.width * 0.15)) , y:Int((fullScreenSize.height * 0.55)) , width: Int((fullScreenSize.width * 0.7)) , height: Int((fullScreenSize.height * 0.07)))
        btn1.setBackgroundImage(UIImage(named: "optiona" ), for: UIControlState.normal)
        btn1.setTitle("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", for: UIControlState.normal)
        btn1.titleLabel?.lineBreakMode = .byWordWrapping
        btn2.frame = CGRect(x: Int((fullScreenSize.width * 0.15)) , y:Int((fullScreenSize.height * 0.64)) , width: Int((fullScreenSize.width * 0.7)) , height: Int((fullScreenSize.height * 0.07)))
        btn2.setBackgroundImage(UIImage(named: "optionb" ), for: UIControlState.normal)
        btn2.titleLabel?.lineBreakMode = .byWordWrapping
        
        btnSure.frame = CGRect(x: Int((fullScreenSize.width * 0.35)) , y:Int((fullScreenSize.height * 0.85)) , width: Int((fullScreenSize.width * 0.3)) , height: Int((fullScreenSize.width * 0.1)))
        btnSure.setBackgroundImage(UIImage(named: "btn_reward0" ), for: UIControlState.normal)
        btnSure.setTitleColor(UIColor.white, for: UIControlState.normal)
        if UserDefaults.standard.bool(forKey: "english"){
            btnSure.setTitle("OK", for: UIControlState.normal)
        }else{
            btnSure.setTitle("確定", for: UIControlState.normal)
        }
        //-------------label設定-------------
        lblshow.frame = CGRect(x: Int((fullScreenSize.width * 0.215)) , y:Int((fullScreenSize.height * 0.22)) , width: Int((fullScreenSize.width * 0.6)) , height: Int((fullScreenSize.height * 0.305)))
        if frequency == 1{
            lblshow.text = recArray[0]
            btn1.setTitle(option[0], for: UIControlState.normal)
            btn2.setTitle(option[1], for: UIControlState.normal)
            
            
        }else if frequency == 2{
            lblshow.text = recArray[1]
            btn1.setTitle(option[0], for: UIControlState.normal)
            btn2.setTitle(option[1], for: UIControlState.normal)
            
        }else if frequency == 3{
            lblshow.text = recArray[2]
            btn1.setTitle(option[0], for: UIControlState.normal)
            btn2.setTitle(option[1], for: UIControlState.normal)
            
        }
        
        
        
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

