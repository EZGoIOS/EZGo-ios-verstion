//
//  State_select.swift
//  Unity-iPhone
//
//  Created by Administrator on 2018/9/19.
//

import UIKit
public var stateAni = NSHomeDirectory() + "/Documents/stateAni.txt"

class State_select: UIViewController {
    let fullScreenSize = UIScreen.main.bounds.size
    var whichOne = Int()
    var select:String = "X"
    @IBOutlet var btnMenu: UIBarButtonItem!

    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var btnA: UIButton!
    @IBOutlet weak var btnB: UIButton!
    @IBOutlet weak var btnC: UIButton!
    @IBOutlet weak var btnD: UIButton!
    @IBOutlet weak var btnOK: UIButton!
    
    @IBAction func btnA(_ sender: Any) {
        select = "吃東西中"
        if UserDefaults.standard.bool(forKey: "english")==true{
            btnA.setBackgroundImage(UIImage(named: "emoticon-btn-eating-eng-pressed-1" ), for: UIControlState.normal)
            btnB.setBackgroundImage(UIImage(named: "emoticon-btn-hiding-eng" ), for: UIControlState.normal)
            btnC.setBackgroundImage(UIImage(named: "emoticon-btn-idle-eng" ), for: UIControlState.normal)
            btnD.setBackgroundImage(UIImage(named: "emoticon-btn-sleeping-eng" ), for: UIControlState.normal)
        }else{
        btnA.setBackgroundImage(UIImage(named: "emoticon-btn-eating-pressed-1" ), for: UIControlState.normal)
        btnB.setBackgroundImage(UIImage(named: "emoticon-btn-hiding" ), for: UIControlState.normal)
        btnC.setBackgroundImage(UIImage(named: "emoticon-btn-idle" ), for: UIControlState.normal)
        btnD.setBackgroundImage(UIImage(named: "emoticon-btn-sleeping" ), for: UIControlState.normal)
        }
        
    }
    @IBAction func btnB(_ sender: Any) {
        select = "躲起來了"
        if UserDefaults.standard.bool(forKey: "english")==true{
            btnA.setBackgroundImage(UIImage(named: "emoticon-btn-eating-eng" ), for: UIControlState.normal)
            btnB.setBackgroundImage(UIImage(named: "emoticon-btn-hiding-eng-pressed-1" ), for: UIControlState.normal)
            btnC.setBackgroundImage(UIImage(named: "emoticon-btn-idle-eng" ), for: UIControlState.normal)
            btnD.setBackgroundImage(UIImage(named: "emoticon-btn-sleeping-eng" ), for: UIControlState.normal)
        }else{
            btnA.setBackgroundImage(UIImage(named: "emoticon-btn-eating" ), for: UIControlState.normal)
            btnB.setBackgroundImage(UIImage(named: "emoticon-btn-hiding-pressed-1" ), for: UIControlState.normal)
            btnC.setBackgroundImage(UIImage(named: "emoticon-btn-idle" ), for: UIControlState.normal)
            btnD.setBackgroundImage(UIImage(named: "emoticon-btn-sleeping" ), for: UIControlState.normal)
        }
        
    }
    @IBAction func btnC(_ sender: Any) {
        select = "活動中"
        if UserDefaults.standard.bool(forKey: "english")==true{
            btnA.setBackgroundImage(UIImage(named: "emoticon-btn-eating-eng" ), for: UIControlState.normal)
            btnB.setBackgroundImage(UIImage(named: "emoticon-btn-hiding-eng" ), for: UIControlState.normal)
            btnC.setBackgroundImage(UIImage(named: "emoticon-btn-idle-eng-pressed-1" ), for: UIControlState.normal)
            btnD.setBackgroundImage(UIImage(named: "emoticon-btn-sleeping-eng" ), for: UIControlState.normal)
        }else{
            btnA.setBackgroundImage(UIImage(named: "emoticon-btn-eating" ), for: UIControlState.normal)
            btnB.setBackgroundImage(UIImage(named: "emoticon-btn-hiding" ), for: UIControlState.normal)
            btnC.setBackgroundImage(UIImage(named: "emoticon-btn-idle-pressed-1" ), for: UIControlState.normal)
            btnD.setBackgroundImage(UIImage(named: "emoticon-btn-sleeping" ), for: UIControlState.normal)
        }
        
    }
    @IBAction func btnD(_ sender: Any) {
        select = "睡覺中"
        if UserDefaults.standard.bool(forKey: "english")==true{
            btnA.setBackgroundImage(UIImage(named: "emoticon-btn-eating-eng" ), for: UIControlState.normal)
            btnB.setBackgroundImage(UIImage(named: "emoticon-btn-hiding-eng" ), for: UIControlState.normal)
            btnC.setBackgroundImage(UIImage(named: "emoticon-btn-idle-eng" ), for: UIControlState.normal)
            btnD.setBackgroundImage(UIImage(named: "emoticon-btn-sleeping-eng-pressed-1" ), for: UIControlState.normal)
        }else{
            btnA.setBackgroundImage(UIImage(named: "emoticon-btn-eating" ), for: UIControlState.normal)
            btnB.setBackgroundImage(UIImage(named: "emoticon-btn-hiding" ), for: UIControlState.normal)
            btnC.setBackgroundImage(UIImage(named: "emoticon-btn-idle" ), for: UIControlState.normal)
            btnD.setBackgroundImage(UIImage(named: "emoticon-btn-sleeping-pressed-1" ), for: UIControlState.normal)
        }
    }
    
    @IBAction func btnOK(_ sender: Any) {
        if select == "X"{
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
        }else{

            do{
                try select.write(toFile: stateAni, atomically: true, encoding: .utf8)
                print("choose this one========",stateAni)
                let recString = try (NSString(contentsOfFile: stateAni, encoding: String.Encoding.utf8.rawValue) as String)
                print("catch recString",recString)
            }catch{
                print("error")
            }
            performSegue(withIdentifier: "SelectgotoDone", sender: self)

        }
    }
    
    func whichAnimal(whichOne:Int) -> String {
         var picture:String
         if UserDefaults.standard.bool(forKey: "english")==true{
         switch whichOne {
         case 1: picture = "pictureFrame-hyena_eng.png"
         case 2: picture = "pictureFrame-bear_eng.png"
         case 3: picture = "pictureFrame-wolf_eng.png"
         case 4: picture = "prairie_dog-pictureFrames2wquestionBoard_eng.png"
         case 5: picture = "pictureFrame-kookaburra_eng.png"
         case 6: picture = "pictureFrame-deer_eng.png"
         default: picture = "GG"
         }
         }else{
         switch whichOne {
         case 1: picture = "pictureFrame-hyena.png"
         case 2: picture = "pictureFrame-bear.png"
         case 3: picture = "pictureFrame-wolf.png"
         case 4: picture = "prairie_dog-pictureFrames2wquestionBoard.png"
         case 5: picture = "pictureFrame-kookaburra.png"
         case 6: picture = "pictureFrame-deer.png"
         default: picture = "GG"
         }
         }
         return picture
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.bool(forKey: "english")==true{
            btnA.setBackgroundImage(UIImage(named: "emoticon-btn-eating-eng" ), for: UIControlState.normal)
            btnB.setBackgroundImage(UIImage(named: "emoticon-btn-hiding-eng" ), for: UIControlState.normal)
            btnC.setBackgroundImage(UIImage(named: "emoticon-btn-idle-eng" ), for: UIControlState.normal)
            btnD.setBackgroundImage(UIImage(named: "emoticon-btn-sleeping-eng" ), for: UIControlState.normal)
        }else{
            btnA.setBackgroundImage(UIImage(named: "emoticon-btn-eating" ), for: UIControlState.normal)
            btnB.setBackgroundImage(UIImage(named: "emoticon-btn-hiding" ), for: UIControlState.normal)
            btnC.setBackgroundImage(UIImage(named: "emoticon-btn-idle" ), for: UIControlState.normal)
            btnD.setBackgroundImage(UIImage(named: "emoticon-btn-sleeping" ), for: UIControlState.normal)
        }
        btnA.frame = CGRect(x: Int((fullScreenSize.width * 0.12)) , y:Int((fullScreenSize.height * 0.45)) , width: Int((fullScreenSize.width * 0.32)) , height: Int((fullScreenSize.width * 0.32)))
        btnB.frame = CGRect(x: Int((fullScreenSize.width * 0.56)) , y:Int((fullScreenSize.height * 0.45)) , width: Int((fullScreenSize.width * 0.32)) , height: Int((fullScreenSize.width * 0.32)))
        btnC.frame = CGRect(x: Int((fullScreenSize.width * 0.12)) , y:Int((fullScreenSize.height * 0.65)) , width: Int((fullScreenSize.width * 0.32)) , height: Int((fullScreenSize.width * 0.32)))
        btnD.frame = CGRect(x: Int((fullScreenSize.width * 0.56)) , y:Int((fullScreenSize.height * 0.65)) , width: Int((fullScreenSize.width * 0.32)) , height: Int((fullScreenSize.width * 0.32)))
        btnOK.frame = CGRect(x: Int((fullScreenSize.width * 0.3)) , y:Int((fullScreenSize.height * 0.85)) , width: Int((fullScreenSize.width * 0.4)) , height: Int((fullScreenSize.height * 0.1)))
        btnOK.setBackgroundImage(UIImage(named: "ok-btn3" ), for: UIControlState.normal)
        image1.frame = CGRect(x: Int((fullScreenSize.width * 0.075)) , y:Int((fullScreenSize.height * 0.17)) , width: Int((fullScreenSize.width * 0.85)) , height: Int((fullScreenSize.height * 0.25)))
        image1.image = UIImage(named: whichAnimal(whichOne: whichOne))
    }
        
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        let xx:State_done = segue.destination as! State_done
            xx.whichOne = whichOne
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

    
    
