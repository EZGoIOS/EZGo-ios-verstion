//
//  DogInfoViewController.swift
//  ezgo1
//
//  Created by vickyliao on 2017/11/23.
//  Copyright © 2017年 vickyliao. All rights reserved.
//

import UIKit

class DogInfoViewController: UIViewController {
    
    @IBOutlet var btnMenu: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        btnMenu.target = revealViewController()
        btnMenu.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        let fullScreenSize = UIScreen.main.bounds.size
        let btnM:UIButton = UIButton()
        btnM.frame = CGRect(x: Int((fullScreenSize.width * 0.025)) , y:Int((fullScreenSize.height * 0.125)) , width: Int((fullScreenSize.width * 0.15)) , height: Int((fullScreenSize.width * 0.15)))
        btnM.setBackgroundImage(UIImage(named: "house" ), for: UIControlState.normal)
        btnM.addTarget(self,action: #selector(self.clickbutton),for: .touchUpInside)
        view.addSubview(btnM)
    }
    @IBAction func clickbutton(sender: UIButton){
        performSegue(withIdentifier: "gotoM3", sender: self)
        
        
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
