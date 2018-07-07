//
//  A1.swift
//  闖關單
//
//  Created by Administrator on 2018/3/1.
//  Copyright © 2018年 Administrator. All rights reserved.
//

import UIKit

class A1: UIViewController {
    
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var lblshow: UILabel!
    var answer = Int()
    var frequency = Int()
    var aa:Int = 3 //有幾個選項
    var recArray:Array<String> = []
    var showAns:Array<String> = []
    var showDescript:Array<String> = []
    var options:Array<String> = []
    var option:Array<String> = []
    var showId:Array<String> = []
    
    
    var whichAnimal = Int()
    
    @IBOutlet weak var btn1: UIButton!
    @IBAction func btnGo(_ sender: Any) {
        if frequency == 3{
            performSegue(withIdentifier: "gotoMain", sender: self)
        }
        option = optionsCount(options: options , frequency: frequency)
        print(option)
        aa = option.count - 1
        if aa == 1{
            performSegue(withIdentifier: "A1gotoQ1", sender: self)
        }
        if aa == 2{
            performSegue(withIdentifier: "A1gotoQ2", sender: self)
        }
        if aa == 3{
            performSegue(withIdentifier: "A1gotoQ3", sender: self)
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
    
    func optionsCount(options:Array<String>,frequency:Int)->Array<String>{
        
        var gap1:Int = 0
        var gap2:Int = 0
        var gap3:Int = 0
        var count:Int = 0
        for i in 0...options.count - 1{
            if options[i] == "love666" {gap1 = i}
            if options[i] == "love777" {gap2 = i}
            if options[i] == "love888" {gap3 = i}
        }
        switch frequency + 1 {
        case 1:
            count = gap1 - 1
            
            
        case 2:
            count = (gap2 - 1) - gap1
            
        case 3:
            count = (gap3 - 1) - gap2
            
        default:
            break
        }
        var QAQ=[String](repeating:"0", count:count)
        switch frequency + 1 {
        case 1:
            for j in 0...gap1 - 2{
                QAQ[j] = options[j + 1]
                
            }
        case 2:
            for k in gap1...gap2 - 2{
                QAQ[k - gap1] = options[k + 1]
                
            }
        case 3:
            for m in gap2...gap3 - 2{
                QAQ [m - gap2] = options[m + 1]
                
            }
        default:
            break
        }
        
        return QAQ
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {   //傳值
        if segue.identifier == "A1gotoQ1"{
            var xxx = segue.destination as!Q1
            xxx.aaaa = aa
            xxx.frequency = frequency + 1
            xxx.recArray = recArray
            xxx.whichAnimal = whichAnimal
            xxx.showAns = showAns
            xxx.showDescript = showDescript
            xxx.options = options
            xxx.option = option
            xxx.showId = showId
        }
        if segue.identifier == "A1gotoQ2"{
            var xxx = segue.destination as!Q2
            xxx.aaaa = aa
            xxx.frequency = frequency + 1
            xxx.recArray = recArray
            xxx.whichAnimal = whichAnimal
            xxx.showAns = showAns
            xxx.showDescript = showDescript
            xxx.options = options
            xxx.option = option
            xxx.showId = showId
            
        }
        if segue.identifier == "A1gotoQ3"{
            var xxx = segue.destination as!Q3
            xxx.aaaa = aa
            xxx.frequency = frequency + 1
            xxx.recArray = recArray
            xxx.whichAnimal = whichAnimal
            xxx.showAns = showAns
            xxx.showDescript = showDescript
            xxx.options = options
            xxx.option = option
            xxx.showId = showId
            
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // 取得螢幕的尺寸
        print("顯示題目")
        print(showAns)
        let fullScreenSize = UIScreen.main.bounds.size
        image.frame = CGRect(x:0, y:0 , width: (fullScreenSize.width) , height:(fullScreenSize.height))
        //--------------圖片設定-----------
        var j:Int = 1//正確選項
        j = Int(showAns[frequency-1])!
        image1.frame = CGRect(x: Int((fullScreenSize.width * 0.125)) , y:Int((fullScreenSize.height * 0.07)) , width: Int((fullScreenSize.width * 0.75)) , height: Int((fullScreenSize.height * 0.18)))
        image1.image = UIImage(named: whichKnowledge(whichOne:whichAnimal))
        image2.frame = CGRect(x: Int((fullScreenSize.width * 0.685)) , y:Int((fullScreenSize.height * 0.123)) , width: Int((fullScreenSize.width * 0.13)) , height: Int((fullScreenSize.width * 0.13)))
        if frequency == 1{image2.image = UIImage(named: "number_wood_1.png")}
        if frequency == 2{image2.image = UIImage(named: "number_wood_2.png")}
        if frequency == 3{image2.image = UIImage(named: "number_wood_3.png")}
        //image2.frame = CGRect(x: Int((fullScreenSize.width * 0.69)) , y:Int((fullScreenSize.height * 0.09)) , width: Int((fullScreenSize.width * 0.1)) , height: Int((fullScreenSize.width * 0.1)))
        image3.frame = CGRect(x: Int((fullScreenSize.width * 0.4)) , y:Int((fullScreenSize.height * 0.3)) , width: Int((fullScreenSize.width * 0.2)) , height: Int((fullScreenSize.width * 0.2)))
        
        //-------------label設定-------------
        lblshow.frame = CGRect(x: Int((fullScreenSize.width * 0.2)) , y:Int((fullScreenSize.height * 0.5)) , width: Int((fullScreenSize.width * 0.6)) , height: Int((fullScreenSize.height * 0.275)))
        lbl1.frame = CGRect(x: Int((fullScreenSize.width * 0.35)) , y:Int((fullScreenSize.height * 0.4)) , width: Int((fullScreenSize.width * 0.3)) , height: Int((fullScreenSize.height * 0.05)))
        if frequency == 1{
            if showDescript[0] == "無"{
                lblshow.text = ""
            }else{
                lblshow.text = showDescript[0]
            }
        }else if frequency == 2{
            if showDescript[1] == "無"{
                lblshow.text = ""
            }else{
                lblshow.text = showDescript[1]
            }
        }else if frequency == 3{
            if showDescript[2] == "無"{
                lblshow.text = ""
            }else{
                lblshow.text = showDescript[2]
            }
        }
        
        if j == answer{
            lbl1.text = "恭喜您 答對了"
            image3.image = UIImage(named: "worksheet_true.png")
        }
        else {
            lbl1.text = "很可惜 答錯了"
            image3.image = UIImage(named: "worksheet_false.png")
            
        }
        //-----------按鈕設定---------------
        btn1.frame = CGRect(x: Int((fullScreenSize.width * 0.35)) , y:Int((fullScreenSize.height * 0.85)) , width: Int((fullScreenSize.width * 0.3)) , height: Int((fullScreenSize.width * 0.1)))
        btn1.setBackgroundImage(UIImage(named: "btn_reward0" ), for: UIControlState.normal)
        btn1.setTitleColor(UIColor.white, for: UIControlState.normal)
        if frequency == 3{
            btn1.setTitle("回主頁", for: UIControlState.normal)
            
        }else{
            btn1.setTitle("下一題", for: UIControlState.normal)
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

