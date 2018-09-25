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

    @IBOutlet weak var btnOK: UIButton!
    
    
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
        btnOK.frame = CGRect(x: Int((fullScreenSize.width * 0.35)) , y:Int((fullScreenSize.height * 0.85)) , width: Int((fullScreenSize.width * 0.3)) , height: Int((fullScreenSize.width * 0.1)))

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
