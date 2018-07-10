//
//  LessonViewController.swift
//  ezgo1
//
//  Created by vickyliao on 2017/11/22.
//  Copyright © 2017年 vickyliao. All rights reserved.
//

import UIKit
//import CoreImage
public var which_Animal = NSHomeDirectory() + "/Documents/which_Animal.txt"
public var vall=String()

class LessonViewController: UIViewController {

    @IBAction func back_gesture(_ sender: Any) {
        self.present(ViewController() ,animated: false, completion:nil)
        //print("swipeeeeeeeeeeeeeeeeeeeeeeeeeeeeee")
    }
    var recDone=[String](repeating:"0", count:18)
    var recDoneString = String()
    static var uuid=""
    public var whichAnimal:Int = 0
    public var showQr=[String](repeating:"y",count:3)
    
    //A string array to save all the names
    var nameArray = [String]()
    
    
    @IBOutlet var btnMenu: UIBarButtonItem!
    @IBOutlet var txtShow: UITextField!
    
    @IBOutlet weak var lblshow: UILabel!
    
    @IBOutlet weak var lbl: UILabel!
    
    @IBAction func clickbuttonjump(sender: UIButton){
        performSegue(withIdentifier: "gotoReward", sender: self)
        
    }
    @IBAction func clickbuttonMenu(sender: UIButton){
        performSegue(withIdentifier: "gotoM2", sender: self)
        
    }
    @IBAction func clickbutton(sender: UIButton){
        if sender.tag == 1{//hyena
            whichAnimal = 1
            getJsonFromUrl(whichAnimal: self.whichAnimal){ConnectionResult in
                //print("first-----",self.showQr)
                switch ConnectionResult{
                case .failure(let error):
                    print(error)
                    
                case .success(let data):
                    print("success")
                }
                //寫檔 （給EnterUnityViewController讀）
                do{
                    vall = String(describing: self.whichAnimal)
                    try vall.write(toFile: which_Animal, atomically: true, encoding: .utf8)
                    print(which_Animal)
                    let recString = try (NSString(contentsOfFile: which_Animal, encoding: String.Encoding.utf8.rawValue) as String)
                    print("catch recString",recString)
                }catch{
                    print("catch error")
                    
                }
                //print("more outside(showQr)",self.showQr)
                
            }
        }
        if sender.tag == 2{        //bear
            whichAnimal = 2
            getJsonFromUrl(whichAnimal: self.whichAnimal){ConnectionResult in
                switch ConnectionResult{
                case .failure(let error):
                    print(error)
                    
                case .success(let data):
                    print("outside=====:",self.showQr)
                }
                //寫檔 （給EnterUnityViewController讀）
                do{
                    vall = String(describing: self.whichAnimal)
                    try vall.write(toFile: which_Animal, atomically: true, encoding: .utf8)
                    print(which_Animal)
                    let recString = try (NSString(contentsOfFile: which_Animal, encoding: String.Encoding.utf8.rawValue) as String)
                    //print("catch recString",recString)
                }catch{
                    print("catch error")
                    
                }
            }
        }
        if sender.tag == 3{        //wolf
            whichAnimal = 3
            getJsonFromUrl(whichAnimal: self.whichAnimal){ConnectionResult in
                switch ConnectionResult{
                case .failure(let error):
                    print(error)
                    
                case .success(let data):
                    print("outside=====:",self.showQr)
                }
                //寫檔 （給EnterUnityViewController讀）
                do{
                    vall = String(describing: self.whichAnimal)
                    try vall.write(toFile: which_Animal, atomically: true, encoding: .utf8)
                    print(which_Animal)
                    let recString = try (NSString(contentsOfFile: which_Animal, encoding: String.Encoding.utf8.rawValue) as String)
                    //print("catch recString",recString)
                }catch{
                    print("catch error")
                    
                }
            }
        }
        if sender.tag == 4{        //prairiedog
            whichAnimal = 4
            getJsonFromUrl(whichAnimal: self.whichAnimal){ConnectionResult in
                switch ConnectionResult{
                case .failure(let error):
                    print(error)
                    
                case .success(let data):
                    print("outside=====:",self.showQr)
                }
                //寫檔 （給EnterUnityViewController讀）
                do{
                    vall = String(describing: self.whichAnimal)
                    try vall.write(toFile: which_Animal, atomically: true, encoding: .utf8)
                    print(which_Animal)
                    let recString = try (NSString(contentsOfFile: which_Animal, encoding: String.Encoding.utf8.rawValue) as String)
                    //print("catch recString",recString)
                }catch{
                    print("catch error")
                    
                }
            }
        }
        if sender.tag == 5{        //kookaburra
            whichAnimal = 5
            getJsonFromUrl(whichAnimal: self.whichAnimal){ConnectionResult in
                switch ConnectionResult{
                case .failure(let error):
                    print(error)
                    
                case .success(let data):
                    print("outside=====:",self.showQr)
                }
                //寫檔 （給EnterUnityViewController讀）
                do{
                    vall = String(describing: self.whichAnimal)
                    try vall.write(toFile: which_Animal, atomically: true, encoding: .utf8)
                    print(which_Animal)
                    let recString = try (NSString(contentsOfFile: which_Animal, encoding: String.Encoding.utf8.rawValue) as String)
                    //print("catch recString",recString)
                }catch{
                    print("catch error")
                    
                }
            }
        }
        //kookaburra
        if sender.tag == 6{       //deer
            whichAnimal = 6
            getJsonFromUrl(whichAnimal: self.whichAnimal){ConnectionResult in
                switch ConnectionResult{
                case .failure(let error):
                    print(error)
                    
                case .success(let data):
                    print("outside=====:",self.showQr)
                }
                //寫檔 （給EnterUnityViewController讀）
                do{
                    vall = String(describing: self.whichAnimal)
                    try vall.write(toFile: which_Animal, atomically: true, encoding: .utf8)
                    print(which_Animal)
                    let recString = try (NSString(contentsOfFile: which_Animal, encoding: String.Encoding.utf8.rawValue) as String)
                    //print("catch recString",recString)
                }catch{
                    print("catch error")
                    
                }
            }
        }
        let enterVC = EnterUnityViewController()
        
        present(enterVC, animated: false) {() -> Void in }
       // performSegue(withIdentifier: "gotoworksheet", sender: self)
    }
    /*
     func animalDone(whichAnimal:Int)->Bool{
     var done:Bool = true
     var ifdone = 0
     for i in whichAnimal*3-2...whichAnimal*3{
     if recDone[i] == "1"{
     ifdone = ifdone+1
     }
     }
     if ifdone == 3{
     done = true
     }else{
     done = false
     }
     return done
     }
     */
    func whichKnowledge(whichOne:Int) -> String {
        var picture:String
        switch whichOne {
        case 1:
            picture = "sticker_hyena-1.png"
        case 2:
            picture = "sticker_bear-1.png"
        case 3:
            picture = "sticker_wolf-1.png"
        case 4:
            picture = "sticker_prairiedog-1.png"
        case 5:
            picture = "sticker_kookaburra-1.png"
        case 6:
            picture = "sticker_deer-1.png"
            
        default:
            picture = "GG"
        }
        return picture
    }
    @IBAction func clickMenubutton(sender: UIButton){
        performSegue(withIdentifier: "gotoM2", sender: self)
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // 取得螢幕的尺寸r
        let fullScreenSize = UIScreen.main.bounds.size
        let btnM:UIButton = UIButton()
        btnM.frame = CGRect(x: Int((fullScreenSize.width * 0.025)) , y:Int((fullScreenSize.height * 0.125)) , width: Int((fullScreenSize.width * 0.15)) , height: Int((fullScreenSize.width * 0.15)))
        btnM.setBackgroundImage(UIImage(named: "house" ), for: UIControlState.normal)
        btnM.addTarget(self,action: #selector(self.clickbuttonMenu),for: .touchUpInside)
        view.addSubview(btnM)
        
        getRecordDone()
        //        do{
        //            recDoneString = try (NSString(contentsOfFile: rec_done, encoding: String.Encoding.utf8.rawValue) as String)
        //            recDoneString.replacingOccurrences(of: ",", with: "")
        //            recDone = recDoneString.components(separatedBy: ",")
        //            print("recdone",recDone)
        //        }catch{
        //            print("recdone error")
        //        }
        btnMenu.target = revealViewController()
        btnMenu.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        
        
        //---------------------------------------
        //用迴圈建立6個按鈕
        let buttonNumber:UIButton = UIButton()
        buttonNumber.frame = CGRect(x: Int((fullScreenSize.width * 0.15)) , y:Int((fullScreenSize.height * 0.8)) , width: Int((fullScreenSize.width * 0.7)) , height: Int((fullScreenSize.width * 0.2)))
        buttonNumber.setBackgroundImage(UIImage(named: "btn_reward0" ), for: UIControlState.normal)
        buttonNumber.setTitleColor(UIColor.white, for: UIControlState.normal)
        buttonNumber.setTitle("闖關尚未成功", for: UIControlState.normal)
        buttonNumber.tag = 7
        view.addSubview(buttonNumber)
        lblshow.frame = CGRect(x: Int((fullScreenSize.width * 0.15)) , y:Int((fullScreenSize.height * 0.1)) , width: Int((fullScreenSize.width * 0.7)) , height: Int((fullScreenSize.height * 0.1)))
        
        lbl.frame = CGRect(x: Int((fullScreenSize.width * 0.15)) , y:Int((fullScreenSize.height * 0.9)) , width: Int((fullScreenSize.width * 0.7)) , height: Int((fullScreenSize.width * 0.2)))
        
        for var i in 1...6
        {
            //按鋌水平位置
            var X:Int = i%2
            if X==1 {X=Int((fullScreenSize.width * 0.15))}
            else if X==0 {X=Int((fullScreenSize.width * 0.55))}
            //按鈕垂直位置
            var Y:Int = i
            if Y==1 || Y==2 {Y=Int((fullScreenSize.height * 0.2))}
            else if Y==3 || Y==4 {Y=Int((fullScreenSize.height * 0.4))}
            else if Y==5 || Y==6 {Y=Int((fullScreenSize.height * 0.6))}
            //圖片大小
            var OUO:Int = Int((fullScreenSize.width * 0.3))
            //圖片遮色
            let origin = CIImage(image:UIImage(named: whichKnowledge(whichOne:i))!)
            let filter = CIFilter(name:"CIPhotoEffectMono")
            filter?.setDefaults()
            filter?.setValue(origin,forKey:kCIInputImageKey)
            //new UIButton
            switch i{
            case 1:
                let buttonNumber1:UIButton =   UIButton()
                do{
                    recDoneString = try (NSString(contentsOfFile: rec_done, encoding: String.Encoding.utf8.rawValue) as String)
                    recDoneString.replacingOccurrences(of: ",", with: "")
                    recDone = recDoneString.components(separatedBy: ",")
                    //print("recdone",recDone)
                }catch{
                    //print("recdone error")
                }
                if recDone[0]=="1" && recDone[1]=="1" && recDone[2]=="1"{
                    buttonNumber1.setImage(UIImage(named: whichKnowledge(whichOne:i)), for: UIControlState.normal)
                    //指定UIButton位置，大小
                    buttonNumber1.frame = CGRect(x: X , y:Y , width: OUO , height: OUO)
                    view.addSubview(buttonNumber1)
                }else{
                    buttonNumber1.setImage(UIImage(named: whichKnowledge(whichOne:i)), for: UIControlState.normal)
                    //指定UIButton位置，大小
                    buttonNumber1.frame = CGRect(x: X , y:Y , width: OUO , height: OUO)
                    if let output = filter?.outputImage{
                        let tmp = CIContext().createCGImage(output, from: output.extent)
                        buttonNumber1.setImage(UIImage(cgImage:tmp!), for: UIControlState.normal)
                    }
                    view.addSubview(buttonNumber1)
                    buttonNumber1.tag = 1
                    buttonNumber1.addTarget(self,action: #selector(self.clickbutton),for: .touchUpInside)
                }
            case 2:
                let buttonNumber2:UIButton =   UIButton()
                do{
                    recDoneString = try (NSString(contentsOfFile: rec_done, encoding: String.Encoding.utf8.rawValue) as String)
                    recDoneString.replacingOccurrences(of: ",", with: "")
                    recDone = recDoneString.components(separatedBy: ",")
                    //print("recdone",recDone)
                }catch{
                    //print("recdone error")
                }
                if recDone[3]=="1" && recDone[4]=="1" && recDone[5]=="1"{
                    buttonNumber2.setImage(UIImage(named: whichKnowledge(whichOne:i)), for: UIControlState.normal)
                    //指定UIButton位置，大小
                    buttonNumber2.frame = CGRect(x: X , y:Y , width: OUO , height: OUO)
                    view.addSubview(buttonNumber2)
                }else{
                    buttonNumber2.setImage(UIImage(named: whichKnowledge(whichOne:i)), for: UIControlState.normal)
                    //指定UIButton位置，大小
                    buttonNumber2.frame = CGRect(x: X , y:Y , width: OUO , height: OUO)
                    if let output = filter?.outputImage{
                        let tmp = CIContext().createCGImage(output, from: output.extent)
                        buttonNumber2.setImage(UIImage(cgImage:tmp!), for: UIControlState.normal)
                    }
                    view.addSubview(buttonNumber2)
                    buttonNumber2.tag = 2
                    buttonNumber2.addTarget(self,action: #selector(self.clickbutton),for: .touchUpInside)
                }
            case 3:
                let buttonNumber3:UIButton =   UIButton()
                do{
                    recDoneString = try (NSString(contentsOfFile: rec_done, encoding: String.Encoding.utf8.rawValue) as String)
                    recDoneString.replacingOccurrences(of: ",", with: "")
                    recDone = recDoneString.components(separatedBy: ",")
                    //print("recdone",recDone)
                }catch{
                    //print("recdone error")
                }
                if recDone[6]=="1" && recDone[7]=="1" && recDone[8]=="1"{
                    buttonNumber3.setImage(UIImage(named: whichKnowledge(whichOne:i)), for: UIControlState.normal)
                    //指定UIButton位置，大小
                    buttonNumber3.frame = CGRect(x: X , y:Y , width: OUO , height: OUO)
                    view.addSubview(buttonNumber3)
                }else{
                    buttonNumber3.setImage(UIImage(named: whichKnowledge(whichOne:i)), for: UIControlState.normal)
                    //指定UIButton位置，大小
                    buttonNumber3.frame = CGRect(x: X , y:Y , width: OUO , height: OUO)
                    if let output = filter?.outputImage{
                        let tmp = CIContext().createCGImage(output, from: output.extent)
                        buttonNumber3.setImage(UIImage(cgImage:tmp!), for: UIControlState.normal)
                    }
                    view.addSubview(buttonNumber3)
                    buttonNumber3.tag = 3
                    buttonNumber3.addTarget(self,action: #selector(self.clickbutton),for: .touchUpInside)
                }
            case 4:
                let buttonNumber4:UIButton =   UIButton()
                do{
                    recDoneString = try (NSString(contentsOfFile: rec_done, encoding: String.Encoding.utf8.rawValue) as String)
                    recDoneString.replacingOccurrences(of: ",", with: "")
                    recDone = recDoneString.components(separatedBy: ",")
                    //print("recdone",recDone)
                }catch{
                    //print("recdone error")
                }
                if recDone[9]=="1" && recDone[10]=="1" && recDone[11]=="1"{
                    buttonNumber4.setImage(UIImage(named: whichKnowledge(whichOne:i)), for: UIControlState.normal)
                    //指定UIButton位置，大小
                    buttonNumber4.frame = CGRect(x: X , y:Y , width: OUO , height: OUO)
                    view.addSubview(buttonNumber4)
                }else{
                    buttonNumber4.setImage(UIImage(named: whichKnowledge(whichOne:i)), for: UIControlState.normal)
                    //指定UIButton位置，大小
                    buttonNumber4.frame = CGRect(x: X , y:Y , width: OUO , height: OUO)
                    if let output = filter?.outputImage{
                        let tmp = CIContext().createCGImage(output, from: output.extent)
                        buttonNumber4.setImage(UIImage(cgImage:tmp!), for: UIControlState.normal)
                    }
                    view.addSubview(buttonNumber4)
                    buttonNumber4.tag = 4
                    buttonNumber4.addTarget(self,action: #selector(self.clickbutton),for: .touchUpInside)
                }
            case 5:
                let buttonNumber5:UIButton =   UIButton()
                do{
                    recDoneString = try (NSString(contentsOfFile: rec_done, encoding: String.Encoding.utf8.rawValue) as String)
                    recDoneString.replacingOccurrences(of: ",", with: "")
                    recDone = recDoneString.components(separatedBy: ",")
                    //print("recdone",recDone)
                }catch{
                    //print("recdone error")
                }
                if recDone[12]=="1" && recDone[13]=="1" && recDone[14]=="1"{
                    buttonNumber5.setImage(UIImage(named: whichKnowledge(whichOne:i)), for: UIControlState.normal)
                    //指定UIButton位置，大小
                    buttonNumber5.frame = CGRect(x: X , y:Y , width: OUO , height: OUO)
                    view.addSubview(buttonNumber5)
                }else{
                    buttonNumber5.setImage(UIImage(named: whichKnowledge(whichOne:i)), for: UIControlState.normal)
                    //指定UIButton位置，大小
                    buttonNumber5.frame = CGRect(x: X , y:Y , width: OUO , height: OUO)
                    if let output = filter?.outputImage{
                        let tmp = CIContext().createCGImage(output, from: output.extent)
                        buttonNumber5.setImage(UIImage(cgImage:tmp!), for: UIControlState.normal)
                    }
                    view.addSubview(buttonNumber5)
                    buttonNumber5.tag = 5
                    buttonNumber5.addTarget(self,action: #selector(self.clickbutton),for: .touchUpInside)
                }
            case 6:
                let buttonNumber6:UIButton =   UIButton()
                do{
                    recDoneString = try (NSString(contentsOfFile: rec_done, encoding: String.Encoding.utf8.rawValue) as String)
                    recDoneString.replacingOccurrences(of: ",", with: "")
                    recDone = recDoneString.components(separatedBy: ",")
                    //print("recdone",recDone)
                }catch{
                    //print("recdone error")
                }
                if recDone[15]=="1" && recDone[16]=="1" && recDone[17]=="1"{
                    buttonNumber6.setImage(UIImage(named: whichKnowledge(whichOne:i)), for: UIControlState.normal)
                    //指定UIButton位置，大小
                    buttonNumber6.frame = CGRect(x: X , y:Y , width: OUO , height: OUO)
                    view.addSubview(buttonNumber6)
                }else{
                    buttonNumber6.setImage(UIImage(named: whichKnowledge(whichOne:i)), for: UIControlState.normal)
                    //指定UIButton位置，大小
                    buttonNumber6.frame = CGRect(x: X , y:Y , width: OUO , height: OUO)
                    if let output = filter?.outputImage{
                        let tmp = CIContext().createCGImage(output, from: output.extent)
                        buttonNumber6.setImage(UIImage(cgImage:tmp!), for: UIControlState.normal)
                    }
                    view.addSubview(buttonNumber6)
                    buttonNumber6.tag = 6
                    buttonNumber6.addTarget(self,action: #selector(self.clickbutton),for: .touchUpInside)
                }
            default: break //GG
            }
        }
        var ansCnt:Int = 0
        var TOT:Float = 0
        //print(recDone)
        for i in 0...17{
            if recDone[i] == "1"{TOT = TOT + 1}
            
        }
        //ansCnt = TOT\3
        //print("NOOOOOOOOOOO",TOT)
        ansCnt = Int(floorf(TOT/3))
        //print("NNNNNOOOOOOO",ansCnt)
        
        lblshow.text = "目前闖關進度:" + String(ansCnt)
        //ansCnt = 6
        if ansCnt == 6{
            buttonNumber.setTitle("可以兌換獎品囉", for: UIControlState.normal)
            buttonNumber.addTarget(self,action: #selector(self.clickbuttonjump),for: .touchUpInside)
            
        }
    }
    
    // Do any additional setup after loading the view.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
//            var xxx = segue.destination as!workSheetViewController// workSheetViewController
//            xxx.whichAnimal = whichAnimal
//        do{
//            vall = String(describing: whichAnimal)
//            try vall.write(toFile: which_Animal, atomically: true, encoding: .utf8)
//            print(which_Animal)
//            var recString = try (NSString(contentsOfFile: which_Animal, encoding: String.Encoding.utf8.rawValue) as String)
//            print("catch recString",recString)
//        }catch{
//            print("catch error")
//
//        }
//        var xxxx = segue.destination as!EnterUnityViewController// workSheetViewController
//        xxxx.whichAnimal = Int32(whichAnimal)
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
