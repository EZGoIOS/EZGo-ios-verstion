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
    @IBOutlet weak var table: UITableView!
    public var menuNameArray:Array = [String]()
    public var iconImage:Array = [UIImage]()
    
    override func viewDidLoad() {
        //super.viewWillAppear(true)
        super.viewDidLoad()
        menuNameArray=[]
        iconImage=[]
        table.reloadData()
        if UserDefaults.standard.bool(forKey: "hasChangedReward")==true{
            if UserDefaults.standard.bool(forKey: "english")==false{
                menuNameArray = ["Guide Map","Record","Woofy's file","Introduction","Knowledge","About","Contact us","Language","Restart"]
                iconImage = [UIImage(named:"ezgo")!,UIImage(named:"assignment")!,UIImage(named:"footprint")!,UIImage(named:"info")!,UIImage(named:"knowledge")!,UIImage(named:"contact")!,UIImage(named:"email")!,UIImage(named:"translate")!,UIImage(named:"change")!]
                print("英文")
            }else{
                menuNameArray = ["地圖導覽","闖關進度","旺哥小檔案","闖關說明","動物小知識","關於我們","問題與回饋","切換語言","再玩一次"]
                iconImage = [UIImage(named:"ezgo")!,UIImage(named:"assignment")!,UIImage(named:"footprint")!,UIImage(named:"info")!,UIImage(named:"knowledge")!,UIImage(named:"contact")!,UIImage(named:"email")!,UIImage(named:"translate")!,UIImage(named:"change")!]
                print("中文")
            }
            
            //print("側邊欄有新增")
        }else{
            if UserDefaults.standard.bool(forKey: "english")==false{
                menuNameArray = ["Guide Map","Record","Woofy's file","Introduction","Knowledge","About","Contact us","Language"]
                iconImage = [UIImage(named:"ezgo")!,UIImage(named:"assignment")!,UIImage(named:"footprint")!,UIImage(named:"info")!,UIImage(named:"knowledge")!,UIImage(named:"contact")!,UIImage(named:"email")!,UIImage(named:"translate")!]
                print("英文")
            }else{
                menuNameArray = ["地圖導覽","闖關進度","旺哥小檔案","闖關說明","動物小知識","關於我們","問題與回饋","切換語言"]
                iconImage = [UIImage(named:"ezgo")!,UIImage(named:"assignment")!,UIImage(named:"footprint")!,UIImage(named:"info")!,UIImage(named:"knowledge")!,UIImage(named:"contact")!,UIImage(named:"email")!,UIImage(named:"translate")!]
                print("中文")
            }
            //print("側邊欄沒新增")
        }
 
        //self.reloadInputViews()
    }

    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()
        table.reloadData()
        if UserDefaults.standard.bool(forKey: "hasChangedReward")==true{
            if UserDefaults.standard.bool(forKey: "english")==true{
                menuNameArray = ["Guide Map","Record","Woofy's file","Introduction","Knowledge","About","Contact us","Language","Restart"]
                iconImage = [UIImage(named:"ezgo")!,UIImage(named:"assignment")!,UIImage(named:"footprint")!,UIImage(named:"info")!,UIImage(named:"knowledge")!,UIImage(named:"contact")!,UIImage(named:"email")!,UIImage(named:"translate")!,UIImage(named:"change")!]
                print("英文")
            }else{
                menuNameArray = ["地圖導覽","闖關進度","旺哥小檔案","闖關說明","動物小知識","關於我們","問題與回饋","切換語言","再玩一次"]
                iconImage = [UIImage(named:"ezgo")!,UIImage(named:"assignment")!,UIImage(named:"footprint")!,UIImage(named:"info")!,UIImage(named:"knowledge")!,UIImage(named:"contact")!,UIImage(named:"email")!,UIImage(named:"translate")!,UIImage(named:"change")!]
                print("中文")
            }
            print("側邊欄有新增")
        }else{
            if UserDefaults.standard.bool(forKey: "english")==true{
                menuNameArray = ["Guide Map","Record","Woofy's file","Introduction","Knowledge","About","Contact us","Language"]
                iconImage = [UIImage(named:"ezgo")!,UIImage(named:"assignment")!,UIImage(named:"footprint")!,UIImage(named:"info")!,UIImage(named:"knowledge")!,UIImage(named:"contact")!,UIImage(named:"email")!,UIImage(named:"translate")!]
                print("英文")
            }else{
                menuNameArray = ["地圖導覽","闖關進度","旺哥小檔案","闖關說明","動物小知識","關於我們","問題與回饋","切換語言"]
                iconImage = [UIImage(named:"ezgo")!,UIImage(named:"assignment")!,UIImage(named:"footprint")!,UIImage(named:"info")!,UIImage(named:"knowledge")!,UIImage(named:"contact")!,UIImage(named:"email")!,UIImage(named:"translate")!]
                print("中文")
            }
            print("側邊欄沒新增")
        }
    }
 
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        menuNameArray=[]
        iconImage=[]
        
        if UserDefaults.standard.bool(forKey: "hasChangedReward")==true{
            if UserDefaults.standard.bool(forKey: "english")==true{
                menuNameArray = ["Guide Map","Record","Woofy's file","Introduction","Knowledge","About","Contact us","Language","Restart"]
                iconImage = [UIImage(named:"ezgo")!,UIImage(named:"assignment")!,UIImage(named:"footprint")!,UIImage(named:"info")!,UIImage(named:"knowledge")!,UIImage(named:"contact")!,UIImage(named:"email")!,UIImage(named:"translate")!,UIImage(named:"change")!]
                print("英文")
            }else{
                menuNameArray = ["地圖導覽","闖關進度","旺哥小檔案","闖關說明","動物小知識","關於我們","問題與回饋","切換語言","再玩一次"]
                iconImage = [UIImage(named:"ezgo")!,UIImage(named:"assignment")!,UIImage(named:"footprint")!,UIImage(named:"info")!,UIImage(named:"knowledge")!,UIImage(named:"contact")!,UIImage(named:"email")!,UIImage(named:"translate")!,UIImage(named:"change")!]
                print("中文")
            }
            //print("側邊欄有新增")
        }else{
            if UserDefaults.standard.bool(forKey: "english")==true{
                menuNameArray = ["Guide Map","Record","Woofy's file","Introduction","Knowledge","About","Contact us","Language"]
                iconImage = [UIImage(named:"ezgo")!,UIImage(named:"assignment")!,UIImage(named:"footprint")!,UIImage(named:"info")!,UIImage(named:"knowledge")!,UIImage(named:"contact")!,UIImage(named:"email")!,UIImage(named:"translate")!]
                print("英文")
            }else{
                menuNameArray = ["地圖導覽","闖關進度","旺哥小檔案","闖關說明","動物小知識","關於我們","問題與回饋","切換語言"]
                iconImage = [UIImage(named:"ezgo")!,UIImage(named:"assignment")!,UIImage(named:"footprint")!,UIImage(named:"info")!,UIImage(named:"knowledge")!,UIImage(named:"contact")!,UIImage(named:"email")!,UIImage(named:"translate")!]
                print("中文")
            }
            //print("側邊欄沒新增")
        }
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

    //每個側邊欄按下去的事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.viewDidLoad()
        //tableView.reloadData()
        let revealViewController:SWRevealViewController = self.revealViewController()
        
        let cell:MenuTableViewCell = tableView.cellForRow(at: indexPath) as! MenuTableViewCell
        //tableView.reloadData()
        if cell.lblMenuName.text! == "地圖導覽" || cell.lblMenuName.text! == "Guide Map"{
            let mainStoryboard:UIStoryboard = UIStoryboard(name:"Main",bundle:nil)
            let newViewcontroller = mainStoryboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            let newFrontViewController = UINavigationController.init(rootViewController:newViewcontroller)
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
            //tableView.reloadData()
        }
        if cell.lblMenuName.text! == "闖關進度" || cell.lblMenuName.text! == "Record"{
            let mainStoryboard:UIStoryboard = UIStoryboard(name:"Main",bundle:nil)
            let newViewcontroller = mainStoryboard.instantiateViewController(withIdentifier: "LessonViewController") as! LessonViewController
            let newFrontViewController = UINavigationController.init(rootViewController:newViewcontroller)
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
            //tableView.reloadData()
        }
        if cell.lblMenuName.text! == "旺哥小檔案" || cell.lblMenuName.text! == "Woofy's file"{
            let mainStoryboard:UIStoryboard = UIStoryboard(name:"Main",bundle:nil)
            let newViewcontroller = mainStoryboard.instantiateViewController(withIdentifier: "DogInfoViewController") as! DogInfoViewController
            let newFrontViewController = UINavigationController.init(rootViewController:newViewcontroller)
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
            //tableView.reloadData()
        }
        if cell.lblMenuName.text! == "闖關說明" || cell.lblMenuName.text! == "Introduction"{
            let mainStoryboard:UIStoryboard = UIStoryboard(name:"Main",bundle:nil)
            let newViewcontroller = mainStoryboard.instantiateViewController(withIdentifier: "GuideViewController") as! GuideViewController
            let newFrontViewController = UINavigationController.init(rootViewController:newViewcontroller)
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
            //tableView.reloadData()
        }
        if cell.lblMenuName.text! == "動物小知識" || cell.lblMenuName.text! == "Knowledge"{
            let mainStoryboard:UIStoryboard = UIStoryboard(name:"Main",bundle:nil)
            let newViewcontroller = mainStoryboard.instantiateViewController(withIdentifier: "KnowledgeViewController") as! KnowledgeViewController
            let newFrontViewController = UINavigationController.init(rootViewController:newViewcontroller)
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
            //tableView.reloadData()
        }
        if cell.lblMenuName.text! == "關於我們" || cell.lblMenuName.text! == "About"{
            let mainStoryboard:UIStoryboard = UIStoryboard(name:"Main",bundle:nil)
            let newViewcontroller = mainStoryboard.instantiateViewController(withIdentifier: "AboutViewController") as! AboutViewController
            let newFrontViewController = UINavigationController.init(rootViewController:newViewcontroller)
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
         //   tableView.reloadData()
        }
        if cell.lblMenuName.text! == "問題與回饋" || cell.lblMenuName.text! == "Contact us"{
            let mailComposeViewController = configuredMailComposeViewController()
            if MFMailComposeViewController.canSendMail(){
                self.present(mailComposeViewController, animated: true, completion: nil)
            }else{
                self.showSendMailErrorAlert()
            }
            //tableView.reloadData()
        }
        if cell.lblMenuName.text! == "切換語言" || cell.lblMenuName.text! == "Language"{
            // 建立一個提示框
            let alertController = UIAlertController(
                title: "切換語言",
                message: "Changing Language",
                preferredStyle: .alert)
            
            // 建立[取消]按鈕
            let chAction = UIAlertAction(
                title: "中文 Chinese",
                style: .default,
                handler: {
                    (action: UIAlertAction!) -> Void in
                    //tableView.reloadData()
                    UserDefaults.standard.set(false, forKey: "english")
                    //tableView.reloadData()
                    
                    let mainStoryboard:UIStoryboard = UIStoryboard(name:"Main",bundle:nil)
                    let newViewcontroller = mainStoryboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                    let newFrontViewController = UINavigationController.init(rootViewController:newViewcontroller)
                    revealViewController.pushFrontViewController(newFrontViewController, animated: true)
 
                    //tableView.reloadData()
            })
            alertController.addAction(chAction)
            
            let engAction = UIAlertAction(
                title: "英文 English",
                style: .default,
                handler: {
                    (action: UIAlertAction!) -> Void in
                    //tableView.reloadData()
                    UserDefaults.standard.set(true, forKey: "english")
                    //tableView.reloadData()
                    
                    let mainStoryboard:UIStoryboard = UIStoryboard(name:"Main",bundle:nil)
                    let newViewcontroller = mainStoryboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                    let newFrontViewController = UINavigationController.init(rootViewController:newViewcontroller)
                    revealViewController.pushFrontViewController(newFrontViewController, animated: true)
 
                    //tableView.reloadData()
            })
            alertController.addAction(engAction)
            
            //tableView.reloadData()
            // 顯示提示框
            self.present(
                alertController,
                animated: true,
                completion: nil)
        
        }
        if cell.lblMenuName.text! == "再玩一次" || cell.lblMenuName.text! == "Restart"{
            let mainStoryboard:UIStoryboard = UIStoryboard(name:"Main",bundle:nil)
            let newViewcontroller = mainStoryboard.instantiateViewController(withIdentifier: "RestartViewController") as! RestartViewController
            let newFrontViewController = UINavigationController.init(rootViewController:newViewcontroller)
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
            //tableView.reloadData()
        }
        
    }
    
    
    //mail 的東東
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
