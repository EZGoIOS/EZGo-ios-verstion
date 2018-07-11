//
//  RestartViewController.swift
//  Unity-iPhone
//
//  Created by vickyliao on 2018/7/6.
//

import UIKit

class RestartViewController: UIViewController {

    @IBOutlet weak var btnMenu: UIBarButtonItem!

    @IBOutlet weak var pressConti: UIButton!
    @IBOutlet weak var lblConti: UILabel!
    @IBOutlet weak var lblRestart: UILabel!
    @IBOutlet weak var pressRestart: UIButton!
    @IBAction func pressConti(_ sender: Any) {
        performSegue(withIdentifier: "gotoMain", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.bool(forKey: "english")==true{
            lblConti.text = "Click Continue will keep going on your task."
            lblRestart.text = "Click Restart will restart your task."
        }
        // Do any additional setup after loading the view.
        let fullScreenSize = UIScreen.main.bounds.size
        pressConti.frame = CGRect(x: Int((fullScreenSize.width * 0.15)) , y:Int((fullScreenSize.height * 0.28)) , width: Int((fullScreenSize.width * 0.7)) , height: Int((fullScreenSize.width * 0.3)))
        pressRestart.frame = CGRect(x: Int((fullScreenSize.width * 0.15)) , y:Int((fullScreenSize.height * 0.28)) , width: Int((fullScreenSize.width * 0.7)) , height: Int((fullScreenSize.width * 0.3)))
        if UserDefaults.standard.bool(forKey: "english")==true{
            pressConti.setTitle("Continue", for: UIControlState.normal)
            pressRestart.setTitle("Restart", for: UIControlState.normal)
        }
        let btnM:UIButton = UIButton()
        btnM.frame = CGRect(x: Int((fullScreenSize.width * 0.025)) , y:Int((fullScreenSize.height * 0.125)) , width: Int((fullScreenSize.width * 0.15)) , height: Int((fullScreenSize.width * 0.15)))
        btnM.setBackgroundImage(UIImage(named: "house" ), for: UIControlState.normal)
        btnM.addTarget(self,action: #selector(self.clickbutton),for: .touchUpInside)
        btnMenu.target = revealViewController()
        btnMenu.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        view.addSubview(btnM)
    }

    @IBAction func pressRestart(_ sender: Any) {
        /*
        let alertController = UIAlertController(
            title: "提醒",
            message: "已重置闖關進度",
            preferredStyle: .alert)
        
        // 建立[了解]按鈕
        let okAction = UIAlertAction(
            title: "了解",
            style: .default,
            handler: nil)
        alertController.addAction(okAction)
        */
        
        clearRec(userid:String((UserDefaults.standard.string(forKey: "user_id"))!).replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "\n", with: "")){
            ConnectionResult8 in
            switch ConnectionResult8{
            case .failure(let error):
                print(error)
                
            case .success(let data):
                print("success")
            }
        }
        performSegue(withIdentifier: "gobackmain", sender: self)
    }
    
    @IBAction func clickbutton(sender: UIButton){
        performSegue(withIdentifier: "gotoM7", sender: self)
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
