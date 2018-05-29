//
//  KnowledgeDetailViewController.swift
//  ezgo1
//
//  Created by Administrator on 2018/3/24.
//  Copyright © 2018年 vickyliao. All rights reserved.
//

import UIKit

class KnowledgeDetailViewController: UIViewController {
    var whichOne = Int()
    
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var background: UIImageView!
  //  @IBAction func clickbutton(sender: UIButton){
    //    performSegue(withIdentifier: "gotoKnowledgeView", sender: self)

    //}
 
    func whichKnowledge(whichOne:Int) -> String {
        var picture:String
        switch whichOne {
        case 1:
            picture = "knowledge_hyena.png"
        case 2:
            picture = "knowledge_bear.png"
        case 3:
            picture = "knowledge_wolf.png"
        case 4:
            picture = "knowledge_prairiedog.png"
        case 5:
            picture = "knowledge_kookaburra.png"
        case 6:
            picture = "knowledge_deer.png"
            
        default:
            picture = "GG"
        }
        return picture
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // 取得螢幕的尺寸
        let fullScreenSize = UIScreen.main.bounds.size
      
        //--------------------------------
        
        background.image = UIImage(named: "knowledge_background.png")

        background.frame = CGRect(x: 0, y: 0, width: fullScreenSize.width, height: fullScreenSize.height * 1.5)
        image1.image = UIImage(named: whichKnowledge(whichOne:whichOne))
        image1.frame = CGRect(x: fullScreenSize.width * 0.05, y: fullScreenSize.height * 0.05, width: fullScreenSize.width * 0.9, height: fullScreenSize.height * 0.9)
        //---------------------------------------
        //let buttonNumber:UIButton =   UIButton()

       // btn1.frame = CGRect(x: Int((fullScreenSize.width * 0.25)) , y:Int((fullScreenSize.height * 0.96)) , width: Int((fullScreenSize.width * 0.5)) , height: Int((fullScreenSize.width * 0.2)))
    //    btn1.setBackgroundImage(UIImage(named: "btn_reward0" ), for: UIControlState.normal)
      //  btn1.setTitleColor(UIColor.white, for: UIControlState.normal)
        
       // btn1.setTitle("返回", for: UIControlState.normal)
        //btn1.isEnabled = true
        // 按鈕按下後的動作


    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
