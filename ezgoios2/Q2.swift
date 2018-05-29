//
//  Q2.swift
//  闖關單
//
//  Created by Administrator on 2018/3/1.
//  Copyright © 2018年 Administrator. All rights reserved.
//

import UIKit

class Q2: UIViewController {
    @IBOutlet weak var image: UIImageView!
    var aaaa = Int()
    var frequency = Int()
    var answer:Int = 0
    var recArray:Array<String> = []
    var showAns:Array<String> = []
    var showDescript:Array<String> = []
    var options:Array<String> = []
    var option:Array<String> = []
    var showId:Array<String> = []
    
    var whichAnimal = Int()
    
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btnSure: UIButton!
    
    @IBOutlet weak var lblshow: UILabel!
    @IBAction func btn1(_ sender: Any) {
        answer = 1
        btn1.setBackgroundImage(UIImage(named: "optionclick_a" ), for: UIControlState.normal)
        btn2.setBackgroundImage(UIImage(named: "optionb" ), for: UIControlState.normal)
        btn3.setBackgroundImage(UIImage(named: "optionc" ), for: UIControlState.normal)
        
    }
    @IBAction func btn2(_ sender: Any) {
        answer = 2
        btn2.setBackgroundImage(UIImage(named: "optionclick_b" ), for: UIControlState.normal)
        btn1.setBackgroundImage(UIImage(named: "optiona" ), for: UIControlState.normal)
        btn3.setBackgroundImage(UIImage(named: "optionc" ), for: UIControlState.normal)
        
    }
    @IBAction func btn3(_ sender: Any) {
        answer = 3
        btn3.setBackgroundImage(UIImage(named: "optionclick_c" ), for: UIControlState.normal)
        btn1.setBackgroundImage(UIImage(named: "optiona" ), for: UIControlState.normal)
        btn2.setBackgroundImage(UIImage(named: "optionb" ), for: UIControlState.normal)
        
    }
    
    @IBAction func btnSure(_ sender: Any) {
        if answer != 0{
            var Ans:String = showAns[frequency-1]
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
                    
                case .success(let data):
                    print("success")
                }
            }
            performSegue(withIdentifier: "Q2gotoA1", sender: self)
        }else {
            lblshow.text = "你沒選選項"
        }
    }
    func whichKnowledge1(whichOne:Int) -> String {
        var picture:String
        switch whichOne {
        case 1:
            picture = "number_wood_1.png"
        case 2:
            picture = "number_wood_2.png"
        case 3:
            picture = "number_wood_3.png"
            
        default:
            picture = "GG"
        }
        return picture
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
        var xx = segue.destination as!A1
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
        
        image.frame = CGRect(x:0, y:0 , width: (fullScreenSize.width) , height:(fullScreenSize.height))
        
        //--------------圖片設定-----------
        
        image1.frame = CGRect(x: Int((fullScreenSize.width * 0.17)) , y:Int((fullScreenSize.height * 0.05)) , width: Int((fullScreenSize.width * 0.65)) , height: Int((fullScreenSize.height * 0.15)))
        image1.image = UIImage(named: whichKnowledge(whichOne:whichAnimal))
        image2.frame = CGRect(x: Int((fullScreenSize.width * 0.69)) , y:Int((fullScreenSize.height * 0.09)) , width: Int((fullScreenSize.width * 0.1)) , height: Int((fullScreenSize.width * 0.1)))
        if frequency == 1{image2.image = UIImage(named: "number_wood_1.png")}
        if frequency == 2{image2.image = UIImage(named: "number_wood_2.png")}
        if frequency == 3{image2.image = UIImage(named: "number_wood_3.png")}
        
        //-----------按鈕設定---------------
        btn1.frame = CGRect(x: Int((fullScreenSize.width * 0.21)) , y:Int((fullScreenSize.height * 0.55)) , width: Int((fullScreenSize.width * 0.6)) , height: Int((fullScreenSize.width * 0.1)))
        btn1.setBackgroundImage(UIImage(named: "optiona" ), for: UIControlState.normal)
        btn1.titleLabel?.lineBreakMode = .byWordWrapping
        
        btn2.frame = CGRect(x: Int((fullScreenSize.width * 0.21)) , y:Int((fullScreenSize.height * 0.61)) , width: Int((fullScreenSize.width * 0.6)) , height: Int((fullScreenSize.width * 0.1)))
        btn2.setBackgroundImage(UIImage(named: "optionb" ), for: UIControlState.normal)
        btn2.titleLabel?.lineBreakMode = .byWordWrapping
        
        btn3.frame = CGRect(x: Int((fullScreenSize.width * 0.21)) , y:Int((fullScreenSize.height * 0.67)) , width: Int((fullScreenSize.width * 0.6)) , height: Int((fullScreenSize.width * 0.1)))
        btn3.setBackgroundImage(UIImage(named: "optionc" ), for: UIControlState.normal)
        btn3.titleLabel?.lineBreakMode = .byWordWrapping
        
        btnSure.frame = CGRect(x: Int((fullScreenSize.width * 0.35)) , y:Int((fullScreenSize.height * 0.85)) , width: Int((fullScreenSize.width * 0.3)) , height: Int((fullScreenSize.width * 0.1)))
        btnSure.setBackgroundImage(UIImage(named: "btn_reward0" ), for: UIControlState.normal)
        btnSure.setTitleColor(UIColor.white, for: UIControlState.normal)
        btnSure.setTitle("確定", for: UIControlState.normal)
        //-------------label設定-------------
        lblshow.frame = CGRect(x: Int((fullScreenSize.width * 0.215)) , y:Int((fullScreenSize.height * 0.22)) , width: Int((fullScreenSize.width * 0.6)) , height: Int((fullScreenSize.height * 0.305)))
        
        
        print(recArray)
        if frequency == 1{
            lblshow.text = recArray[0]
            btn1.setTitle(option[0], for: UIControlState.normal)
            btn2.setTitle(option[1], for: UIControlState.normal)
            btn3.setTitle(option[2], for: UIControlState.normal)
            
        }else if frequency == 2{
            lblshow.text = recArray[1]
            btn1.setTitle(option[0], for: UIControlState.normal)
            btn2.setTitle(option[1], for: UIControlState.normal)
            btn3.setTitle(option[2], for: UIControlState.normal)
        }else if frequency == 3{
            lblshow.text = recArray[2]
            btn1.setTitle(option[0], for: UIControlState.normal)
            btn2.setTitle(option[1], for: UIControlState.normal)
            btn3.setTitle(option[2], for: UIControlState.normal)
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
