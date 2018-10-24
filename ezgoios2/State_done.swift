//
//  State_done.swift
//  Unity-iPhone
//
//  Created by Administrator on 2018/9/19.
//

import UIKit

class State_done: UIViewController {
    let fullScreenSize = UIScreen.main.bounds.size
    var whichOne = Int()

    @IBOutlet var btnMenu: UIBarButtonItem!

    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var btnOK: UIButton!
    @IBAction func clickOK(_ sender: Any) {
        do{
            let recString = try (NSString(contentsOfFile: stateAni, encoding: String.Encoding.utf8.rawValue) as String)
            let aniString = try (NSString(contentsOfFile: chooseStatAni, encoding: String.Encoding.utf8.rawValue) as String)
            var postAni = String()
            var postStat = String()
            
            if recString == "吃東西中"{
                postStat = "1"
            }else if recString == "躲起來了"{
                postStat = "2"
            }else if recString == "活動中"{
                postStat = "3"
            }else if recString == "睡覺中"{
                postStat = "4"
            }
            
            if aniString == "臺灣黑熊"{
                postAni = "57"
            }else if aniString == "北美灰狼"{
                postAni = "58"
            }else if aniString == "黑尾草原犬鼠"{
                postAni = "59"
            }else if aniString == "笑翠鳥"{
                postAni = "60"
            }else if aniString == "山羌"{
                postAni = "61"
            }else if aniString == "斑點鬣狗"{
                postAni = "62"
            }
            
            print("要上傳這個喔喔喔喔喔",recString,"跟跟跟跟",aniString)
            print("catch recString",recString)
            updateState(status: postStat, animal: postAni, completion: {
                ConnectionResult4 in
                switch ConnectionResult4{
                case .failure(let error):
                    print(error)
                    
                case .success( _):
                    print("success")
                }
            })
        }catch{
            print("error")
        }
    }
    
    
    
    func whichAnimal(whichOne:Int) -> String {
         var picture:String
         if UserDefaults.standard.bool(forKey: "english")==true{
         switch whichOne {
         case 1: picture = "thankYou_btn-hyena_eng.png"
         case 2: picture = "thankYou_btn-bear_eng.png"
         case 3: picture = "thankYou_btn-wolf_eng.png"
         case 4: picture = "thankYou_btn-prairieDog_eng.png"
         case 5: picture = "thankYou_btn-kookaburra_eng.png"
         case 6: picture = "thankYou_btn-deer_eng.png"
         default: picture = "GG"
         }
         }else{
         switch whichOne {
         case 1: picture = "thankYou_btn-hyena.png"
         case 2: picture = "thankYou_btn-bear.png"
         case 3: picture = "thankYou_btn-wolf.png"
         case 4: picture = "thankYou_btn-prairieDog.png"
         case 5: picture = "thankYou_btn-kookaburra.png"
         case 6: picture = "thankYou_btn-deer.png"
         default: picture = "GG"
         }
         }
         return picture
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnOK.frame = CGRect(x: Int((fullScreenSize.width * 0.3)) , y:Int((fullScreenSize.height * 0.85)) , width: Int((fullScreenSize.width * 0.4)) , height: Int((fullScreenSize.height * 0.1)))
        btnOK.setBackgroundImage(UIImage(named: "ok-btn3" ), for: UIControlState.normal)
        image1.frame = CGRect(x: Int((fullScreenSize.width * 0.1)) , y:Int((fullScreenSize.height * 0.15)) , width: Int((fullScreenSize.width * 0.8)) , height: Int((fullScreenSize.height * 0.65)))
        image1.image = UIImage(named: whichAnimal(whichOne: whichOne))
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
