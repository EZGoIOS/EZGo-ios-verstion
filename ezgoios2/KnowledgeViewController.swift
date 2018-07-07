//
//  KnowledgeViewController.swift
//  ezgo1
//
//  Created by vickyliao on 2018/2/6.
//  Copyright © 2018年 vickyliao. All rights reserved.
//

import UIKit

class KnowledgeViewController: UIViewController {
    var aa:Int = 0
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
        performSegue(withIdentifier: "gotoM5", sender: self)
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func btn1(_ sender: Any) {aa = 1}
    @IBAction func btn2(_ sender: Any) {aa = 2}
    @IBAction func btn3(_ sender: Any) {aa = 3}
    @IBAction func btn4(_ sender: Any) {aa = 4}
    @IBAction func btn5(_ sender: Any) {aa = 5}
    @IBAction func btn6(_ sender: Any) {aa = 6}
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoM5"{
            
        }else{
            var xx:KnowledgeDetailViewController = segue.destination as! KnowledgeDetailViewController
            xx.whichOne = aa
        }
    }
    
}
