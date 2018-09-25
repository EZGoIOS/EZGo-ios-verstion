//
//  stateGuessViewController.swift
//  Unity-iPhone
//
//  Created by Administrator on 2018/9/18.
//

import UIKit

class stateGuessViewController: UIViewController {
    let fullScreenSize = UIScreen.main.bounds.size
    var whichOne = Int()

    @IBOutlet var btnMenu: UIBarButtonItem!

    @IBOutlet weak var lblshow: UILabel!
    
    @IBOutlet weak var btnGuess: UIButton!
    @IBOutlet weak var btnPre: UIButton!
    @IBOutlet weak var btnWrite: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblshow.text = String(whichOne)
        btnPre.frame = CGRect(x: Int((fullScreenSize.width * 0)) , y:Int((fullScreenSize.height * 0.89)) , width: Int((fullScreenSize.width * 0.5)) , height: Int((fullScreenSize.width * 0.1)))
        btnGuess.frame = CGRect(x: Int((fullScreenSize.width * 0.5)) , y:Int((fullScreenSize.height * 0.89)) , width: Int((fullScreenSize.width * 0.5)) , height: Int((fullScreenSize.width * 0.1)))

        btnWrite.frame = CGRect(x: Int((fullScreenSize.width * 0.35)) , y:Int((fullScreenSize.height * 0.83)) , width: Int((fullScreenSize.width * 0.3)) , height: Int((fullScreenSize.width * 0.1)))
        btnWrite.setBackgroundImage(UIImage(named: "btn_reward0" ), for: UIControlState.normal)
        btnWrite.setTitleColor(UIColor.white, for: UIControlState.normal)
        if UserDefaults.standard.bool(forKey: "english"){
            btnWrite.setTitle("Write", for: UIControlState.normal)
        }else{
            btnWrite.setTitle("填寫", for: UIControlState.normal)
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoSelect2"{
            let xx:State_select = segue.destination as! State_select
            xx.whichOne = whichOne
        }else{
            let xx:statePreViewController = segue.destination as! statePreViewController
            xx.whichOne = whichOne
        }
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
