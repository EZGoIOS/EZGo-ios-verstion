//
//  MenuViewController.swift
//  ezgo1
//
//  Created by vickyliao on 2017/11/5.
//  Copyright © 2017年 vickyliao. All rights reserved.
//

import UIKit
import MessageUI
class MenuViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,MFMailComposeViewControllerDelegate{
    var menuNameArray:Array = [String]()
    var iconImage:Array = [UIImage]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        menuNameArray = ["地圖導覽","闖關進度","旺哥小檔案","闖關說明","動物小知識","關於我們","問題與回饋"]
        iconImage = [UIImage(named:"ezgo")!,UIImage(named:"assignment")!,UIImage(named:"footprint")!,UIImage(named:"info")!,UIImage(named:"knowledge")!,UIImage(named:"contact")!,UIImage(named:"email")!]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell") as! MenuTableViewCell
        cell.imgIcon.image = iconImage[indexPath.row]
        cell.lblMenuName.text! = menuNameArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let revealViewController:SWRevealViewController = self.revealViewController()
        
        let cell:MenuTableViewCell = tableView.cellForRow(at: indexPath) as! MenuTableViewCell
        
        if cell.lblMenuName.text! == "地圖導覽"{
            let mainStoryboard:UIStoryboard = UIStoryboard(name:"Main",bundle:nil)
            let newViewcontroller = mainStoryboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            let newFrontViewController = UINavigationController.init(rootViewController:newViewcontroller)
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        }
        if cell.lblMenuName.text! == "闖關進度"{
            let mainStoryboard:UIStoryboard = UIStoryboard(name:"Main",bundle:nil)
            let newViewcontroller = mainStoryboard.instantiateViewController(withIdentifier: "LessonViewController") as! LessonViewController
            let newFrontViewController = UINavigationController.init(rootViewController:newViewcontroller)
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        }
        if cell.lblMenuName.text! == "旺哥小檔案"{
            let mainStoryboard:UIStoryboard = UIStoryboard(name:"Main",bundle:nil)
            let newViewcontroller = mainStoryboard.instantiateViewController(withIdentifier: "DogInfoViewController") as! DogInfoViewController
            let newFrontViewController = UINavigationController.init(rootViewController:newViewcontroller)
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        }
        if cell.lblMenuName.text! == "闖關說明"{
            let mainStoryboard:UIStoryboard = UIStoryboard(name:"Main",bundle:nil)
            let newViewcontroller = mainStoryboard.instantiateViewController(withIdentifier: "GuideViewController") as! GuideViewController
            let newFrontViewController = UINavigationController.init(rootViewController:newViewcontroller)
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        }
        if cell.lblMenuName.text! == "動物小知識"{
            let mainStoryboard:UIStoryboard = UIStoryboard(name:"Main",bundle:nil)
            let newViewcontroller = mainStoryboard.instantiateViewController(withIdentifier: "KnowledgeViewController") as! KnowledgeViewController
            let newFrontViewController = UINavigationController.init(rootViewController:newViewcontroller)
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        }
        if cell.lblMenuName.text! == "關於我們"{
            let mainStoryboard:UIStoryboard = UIStoryboard(name:"Main",bundle:nil)
            let newViewcontroller = mainStoryboard.instantiateViewController(withIdentifier: "AboutViewController") as! AboutViewController
            let newFrontViewController = UINavigationController.init(rootViewController:newViewcontroller)
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        }
        if cell.lblMenuName.text! == "問題與回饋"{
            /*
             let mainStoryboard:UIStoryboard = UIStoryboard(name:"Main",bundle:nil)
             let newViewcontroller = mainStoryboard.instantiateViewController(withIdentifier: "ContactViewController") as! ContactViewController
             let newFrontViewController = UINavigationController.init(rootViewController:newViewcontroller)
             revealViewController.pushFrontViewController(newFrontViewController, animated: true)
             */
            let mailComposeViewController = configuredMailComposeViewController()
            if MFMailComposeViewController.canSendMail(){
                self.present(mailComposeViewController, animated: true, completion: nil)
            }else{
                self.showSendMailErrorAlert()
            }
        }
    }
    func configuredMailComposeViewController() -> MFMailComposeViewController{
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["ezgocase@gmail.com"])
        mailComposerVC.setSubject("EZGo feedback")
        mailComposerVC.setMessageBody("send by iphone", isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert(){
        //let showSendMailErrorAlert = UIAlertControllerStyle(title:"無法傳輸郵件",message:"請記得登入email帳號",delegate:self,cancelButtonTitle:"OK")
        let showSendMailErrorAlert = UIAlertController(title: "無法傳輸郵件", message: "請記得登入email帳號", preferredStyle: .alert)
        showSendMailErrorAlert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        self.present(showSendMailErrorAlert, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
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
