//
//  State_menu.swift
//  Unity-iPhone
//
//  Created by Administrator on 2018/9/18.
//

import UIKit
public var chooseStatAni = NSHomeDirectory() + "/Documents/chooseStatAni.txt"

class State_menu: UIViewController {
    var aa:Int = 0
    var animal:String = ""
    @IBOutlet var btnMenu: UIBarButtonItem!
    
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    @IBOutlet weak var btn6: UIButton!
    override func viewDidLoad() {
        // 取得螢幕的尺寸
        let fullScreenSize = UIScreen.main.bounds.size
        if UserDefaults.standard.bool(forKey: "english") == true{
            btn1.setImage(UIImage(named: "state_btn-hyena_eng"), for: UIControlState.normal)
            btn2.setImage(UIImage(named: "state_btn-taiwanese_bear_eng"), for: UIControlState.normal)
            btn3.setImage(UIImage(named: "state_btn-wolf_eng"), for: UIControlState.normal)
            btn4.setImage(UIImage(named: "state_btn-prairie_dog_eng"), for: UIControlState.normal)
            btn5.setImage(UIImage(named: "state_btn-kookaburra_eng"), for: UIControlState.normal)
            btn6.setImage(UIImage(named: "state_btn-deer_eng"), for: UIControlState.normal)
        }else{
            btn1.setImage(UIImage(named: "state_btn-hyena"), for: UIControlState.normal)
            btn2.setImage(UIImage(named: "state_btn-taiwanese_bear"), for: UIControlState.normal)
            btn3.setImage(UIImage(named: "state_btn-wolf"), for: UIControlState.normal)
            btn4.setImage(UIImage(named: "state_btn-prairie_dog"), for: UIControlState.normal)
            btn5.setImage(UIImage(named: "state_btn-kookaburra"), for: UIControlState.normal)
            btn6.setImage(UIImage(named: "state_btn-deer"), for: UIControlState.normal)
        }
        btn1.frame = CGRect(x: Int((fullScreenSize.width * 0.15)) , y:Int((fullScreenSize.height * 0.08)) , width: Int((fullScreenSize.width * 0.7)) , height: Int((fullScreenSize.width * 0.3)))
        btn2.frame = CGRect(x: Int((fullScreenSize.width * 0.15)) , y:Int((fullScreenSize.height * 0.28)) , width: Int((fullScreenSize.width * 0.7)) , height: Int((fullScreenSize.width * 0.3)))
        btn3.frame = CGRect(x: Int((fullScreenSize.width * 0.15)) , y:Int((fullScreenSize.height * 0.48)) , width: Int((fullScreenSize.width * 0.7)) , height: Int((fullScreenSize.width * 0.3)))
        btn4.frame = CGRect(x: Int((fullScreenSize.width * 0.15)) , y:Int((fullScreenSize.height * 0.68)) , width: Int((fullScreenSize.width * 0.7)) , height: Int((fullScreenSize.width * 0.3)))
        btn5.frame = CGRect(x: Int((fullScreenSize.width * 0.15)) , y:Int((fullScreenSize.height * 0.88)) , width: Int((fullScreenSize.width * 0.7)) , height: Int((fullScreenSize.width * 0.3)))
        btn6.frame = CGRect(x: Int((fullScreenSize.width * 0.15)) , y:Int((fullScreenSize.height * 1.08)) , width: Int((fullScreenSize.width * 0.7)) , height: Int((fullScreenSize.width * 0.3)))
        
        super.viewDidLoad()
        btnMenu.target = revealViewController()
        btnMenu.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        let btnM:UIButton = UIButton()
        btnM.frame = CGRect(x: Int((fullScreenSize.width * 0.025)) , y:Int((fullScreenSize.height * 0.125)) , width: Int((fullScreenSize.width * 0.15)) , height: Int((fullScreenSize.width * 0.15)))
        btnM.setBackgroundImage(UIImage(named: "house" ), for: UIControlState.normal)
        btnM.addTarget(self,action: #selector(self.clickbutton),for: .touchUpInside)
        view.addSubview(btnM)
        
    }
    
    @IBAction func clickbutton(sender: UIButton){
        performSegue(withIdentifier: "gotoMA1", sender: self)
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func btn1(_ sender: Any) {
        aa = 1
        animal = "斑點鬣狗"
        do{
            try animal.write(toFile: chooseStatAni, atomically: true, encoding: .utf8)
            print("choose this one========",chooseStatAni)
            let aniString = try (NSString(contentsOfFile: chooseStatAni, encoding: String.Encoding.utf8.rawValue) as String)
            print("catch aniString",aniString)
        }catch{
            print("error")
        }
    }
    @IBAction func btn2(_ sender: Any) {
        aa = 2
        animal = "臺灣黑熊"
        do{
            try animal.write(toFile: chooseStatAni, atomically: true, encoding: .utf8)
            print("choose this one========",chooseStatAni)
            let aniString = try (NSString(contentsOfFile: chooseStatAni, encoding: String.Encoding.utf8.rawValue) as String)
            print("catch aniString",aniString)
        }catch{
            print("error")
        }
    }
    @IBAction func btn3(_ sender: Any) {
        aa = 3
        animal = "北美灰狼"
        do{
            try animal.write(toFile: chooseStatAni, atomically: true, encoding: .utf8)
            print("choose this one========",chooseStatAni)
            let aniString = try (NSString(contentsOfFile: chooseStatAni, encoding: String.Encoding.utf8.rawValue) as String)
            print("catch aniString",aniString)
        }catch{
            print("error")
        }
    }
    @IBAction func btn4(_ sender: Any) {
        aa = 4
        animal = "黑尾草原犬鼠"
        do{
            try animal.write(toFile: chooseStatAni, atomically: true, encoding: .utf8)
            print("choose this one========",chooseStatAni)
            let aniString = try (NSString(contentsOfFile: chooseStatAni, encoding: String.Encoding.utf8.rawValue) as String)
            print("catch aniString",aniString)
        }catch{
            print("error")
        }
    }
    @IBAction func btn5(_ sender: Any) {
        aa = 5
        animal = "笑翠鳥"
        do{
            try animal.write(toFile: chooseStatAni, atomically: true, encoding: .utf8)
            print("choose this one========",chooseStatAni)
            let aniString = try (NSString(contentsOfFile: chooseStatAni, encoding: String.Encoding.utf8.rawValue) as String)
            print("catch aniString",aniString)
        }catch{
            print("error")
        }
    }
    @IBAction func btn6(_ sender: Any) {
        aa = 6
        animal = "山羌"
        do{
            try animal.write(toFile: chooseStatAni, atomically: true, encoding: .utf8)
            print("choose this one========",chooseStatAni)
            let aniString = try (NSString(contentsOfFile: chooseStatAni, encoding: String.Encoding.utf8.rawValue) as String)
            print("catch aniString",aniString)
        }catch{
            print("error")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoMA1"{
            
        }else{
            
            let xx:statePreViewController = segue.destination as! statePreViewController
            xx.whichOne = aa
            
        }
    }
    
}






