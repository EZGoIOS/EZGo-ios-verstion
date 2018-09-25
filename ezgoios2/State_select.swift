//
//  State_select.swift
//  Unity-iPhone
//
//  Created by Administrator on 2018/9/19.
//

import UIKit

class State_select: UIViewController {
    let fullScreenSize = UIScreen.main.bounds.size
    var whichOne = Int()
    var select:String = "X"
    @IBOutlet var btnMenu: UIBarButtonItem!

    @IBOutlet weak var btnA: UIButton!
    @IBOutlet weak var btnB: UIButton!
    @IBOutlet weak var btnC: UIButton!
    @IBOutlet weak var btnD: UIButton!
    @IBOutlet weak var btnOK: UIButton!
    
    @IBAction func btnA(_ sender: Any) {select = "A"}
    @IBAction func btnB(_ sender: Any) {select = "B"}
    @IBAction func btnC(_ sender: Any) {select = "C"}
    @IBAction func btnD(_ sender: Any) {select = "D"}
    
    @IBAction func btnOK(_ sender: Any) {
    }
    
    /*
    func whichAnimal(whichOne:Int) -> String {
         var picture:String
         if UserDefaults.standard.bool(forKey: "english")==true{
         switch whichOne {
         case 1: picture = "knowledge_hyena_en.png"
         case 2: picture = "knowledge_bear_en.png"
         case 3: picture = "knowledge_wolf_en.png"
         case 4: picture = "knowledge_prairiedog_en.png"
         case 5: picture = "knowledge_kookaburra_en.png"
         case 6: picture = "knowledge_deer_en.png"
         default: picture = "GG"
         }
         }else{
         switch whichOne {
         case 1: picture = "knowledge_hyena.png"
         case 2: picture = "knowledge_bear.png"
         case 3: picture = "knowledge_wolf.png"
         case 4: picture = "knowledge_prairiedog.png"
         case 5: picture = "knowledge_kookaburra.png"
         case 6: picture = "knowledge_deer.png"
         default: picture = "GG"
         }
         }
         return picture
    }
    
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnA.frame = CGRect(x: Int((fullScreenSize.width * 0.17)) , y:Int((fullScreenSize.height * 0.5)) , width: Int((fullScreenSize.width * 0.25)) , height: Int((fullScreenSize.width * 0.25)))
        btnB.frame = CGRect(x: Int((fullScreenSize.width * 0.58)) , y:Int((fullScreenSize.height * 0.5)) , width: Int((fullScreenSize.width * 0.25)) , height: Int((fullScreenSize.width * 0.25)))
        btnC.frame = CGRect(x: Int((fullScreenSize.width * 0.17)) , y:Int((fullScreenSize.height * 0.7)) , width: Int((fullScreenSize.width * 0.25)) , height: Int((fullScreenSize.width * 0.25)))
        btnD.frame = CGRect(x: Int((fullScreenSize.width * 0.58)) , y:Int((fullScreenSize.height * 0.7)) , width: Int((fullScreenSize.width * 0.25)) , height: Int((fullScreenSize.width * 0.25)))
        btnOK.frame = CGRect(x: Int((fullScreenSize.width * 0.35)) , y:Int((fullScreenSize.height * 0.85)) , width: Int((fullScreenSize.width * 0.3)) , height: Int((fullScreenSize.width * 0.1)))

        
        
        
        /*
//        //按鈕Ａ----------------------------
        btnA.frame = CGRect(x: Int((fullScreenSize.width * 0.15)) , y:Int((fullScreenSize.height * 0.4)) , width: Int((fullScreenSize.width * 0.3)) , height: Int((fullScreenSize.width * 0.1)))
        //btnA.setBackgroundImage(UIImage(named: "btn_reward0" ), for: UIControlState.normal)
        btnA.setTitleColor(UIColor.white, for: UIControlState.normal)
       /* if UserDefaults.standard.bool(forKey: "english"){
            btnA.setTitle("Write", for: UIControlState.normal)
        }else{
            btnA.setTitle("填寫", for: UIControlState.normal)
        }*/
        //按鈕B----------------------------
        btnB.frame = CGRect(x: Int((fullScreenSize.width * 0.55)) , y:Int((fullScreenSize.height * 0.4)) , width: Int((fullScreenSize.width * 0.3)) , height: Int((fullScreenSize.width * 0.1)))
        //btnB.setBackgroundImage(UIImage(named: "btn_reward0" ), for: UIControlState.normal)
        btnB.setTitleColor(UIColor.white, for: UIControlState.normal)
        /* if UserDefaults.standard.bool(forKey: "english"){
         btnB.setTitle("Write", for: UIControlState.normal)
         }else{
         btnB.setTitle("填寫", for: UIControlState.normal)
         }*/
        //按鈕C----------------------------
        btnC.frame = CGRect(x: Int((fullScreenSize.width * 0.15)) , y:Int((fullScreenSize.height * 0.6)) , width: Int((fullScreenSize.width * 0.3)) , height: Int((fullScreenSize.width * 0.1)))
        //btnC.setBackgroundImage(UIImage(named: "btn_reward0" ), for: UIControlState.normal)
        btnC.setTitleColor(UIColor.white, for: UIControlState.normal)
        /* if UserDefaults.standard.bool(forKey: "english"){
         btnC.setTitle("Write", for: UIControlState.normal)
         }else{
         btnC.setTitle("填寫", for: UIControlState.normal)
         }*/
        //按鈕D----------------------------
        btnD.frame = CGRect(x: Int((fullScreenSize.width * 0.55)) , y:Int((fullScreenSize.height * 0.6)) , width: Int((fullScreenSize.width * 0.3)) , height: Int((fullScreenSize.width * 0.1)))
        //btnD.setBackgroundImage(UIImage(named: "btn_reward0" ), for: UIControlState.normal)
        btnD.setTitleColor(UIColor.white, for: UIControlState.normal)
        /* if UserDefaults.standard.bool(forKey: "english"){
         btnD.setTitle("Write", for: UIControlState.normal)
         }else{
         btnD.setTitle("填寫", for: UIControlState.normal)
         }*/
        //按鈕OK-------------------------------
        btnOK.frame = CGRect(x: Int((fullScreenSize.width * 0.35)) , y:Int((fullScreenSize.height * 0.85)) , width: Int((fullScreenSize.width * 0.3)) , height: Int((fullScreenSize.width * 0.1)))
        //btnOK.setBackgroundImage(UIImage(named: "btn_reward0" ), for: UIControlState.normal)
        btnOK.setTitleColor(UIColor.white, for: UIControlState.normal)*/
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        let xx:State_done = segue.destination as! State_done
            xx.whichOne = whichOne
        
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
