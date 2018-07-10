//
//  ViewController.swift
//  闖關單
//
//  Created by Administrator on 2018/3/1.
//  Copyright © 2018年 Administrator. All rights reserved.
//

import UIKit

class workSheetViewController: UIViewController {
    @IBOutlet weak var btnStart: UIButton!
    var frequency:Int = 0 //作答次數
    var aa:Int = 0 //有幾個選項
    var recArray = [String](repeating:"0",count:3)
    var showAns=[String](repeating:"0", count:3)
    var showDescript=[String](repeating:"0", count:3)
    var showId=[String](repeating:"0", count:3)
    
    var options=[String](repeating:"=3=", count:16)
    var option:Array<String> = []
    var whichAnimal = Int()
    var option_question_id=[String]()
    
    public var recString = ""
    public var AnsString = ""
    public var DescriptString = ""
    public var optionsString = ""
    public var IDString = ""
    public var whichAnimalString = ""
    public var count:Int = 0
    
    
    
    @IBOutlet var lblshow: UILabel!
    func optionsCount(options:Array<String>,frequency:Int)->Array<String>{
        print("為啥咪全部都是梅花鹿ＱＡＱ3")
        
        print(options)
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
    @IBAction func btnGo(_ sender: UIButton) {
        //按按鈕觸發事件
        do{
            self.recString = try (NSString(contentsOfFile: showQFile, encoding: String.Encoding.utf8.rawValue) as String)
            self.recString.replacingOccurrences(of: "\n", with: "")
            recArray = self.recString.components(separatedBy: "\n")
            
            self.AnsString = try (NSString(contentsOfFile: showAnsFile, encoding: String.Encoding.utf8.rawValue) as String)
            self.AnsString.replacingOccurrences(of: "\n", with: "")
            showAns = self.AnsString.components(separatedBy: "\n")
            
            self.DescriptString = try (NSString(contentsOfFile: showDescriptFile, encoding: String.Encoding.utf8.rawValue) as String)
            self.DescriptString.replacingOccurrences(of: "\n", with: "")
            showDescript = self.DescriptString.components(separatedBy: "\n")
            
            self.optionsString = try (NSString(contentsOfFile: showOptFile, encoding: String.Encoding.utf8.rawValue) as String)
            self.optionsString.replacingOccurrences(of: "\n", with: "")
            options = self.optionsString.components(separatedBy: "\n")
            
            
            self.IDString = try (NSString(contentsOfFile: questionIdFile, encoding: String.Encoding.utf8.rawValue) as String)
            self.IDString.replacingOccurrences(of: "\n", with: "")
            showId = self.IDString.components(separatedBy: "\n")
            
            
            self.whichAnimalString = try (NSString(contentsOfFile: which_Animal, encoding: String.Encoding.utf8.rawValue) as String)
            self.whichAnimalString.replacingOccurrences(of: "\n", with: "")
            whichAnimal = Int(whichAnimalString)!
        }catch{
            print("error")
        }
        
        option = optionsCount(options: options , frequency: frequency)
        print(option)
        aa = option.count - 1
        if aa == 1{
            performSegue(withIdentifier: "gotoQ1", sender: self)
        }
        if aa == 2{
            performSegue(withIdentifier: "gotoQ2", sender: self)
        }
        if aa == 3{
            performSegue(withIdentifier: "gotoQ3", sender: self)
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {   //傳值
        if segue.identifier == "gotoQ1"{
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
        if segue.identifier == "gotoQ2"{
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
        if segue.identifier == "gotoQ3"{
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
        if UserDefaults.standard.bool(forKey: "english")==true{
            btnStart.setTitle("Start to Answer", for: UIControlState.normal)
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


