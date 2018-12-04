//
//  ViewController.swift
//  ezgo1
//
//  Created by vickyliao on 2017/10/31.
//  Copyright © 2017年 vickyliao. All rights reserved.
//

import UIKit
import MapKit
//import ezgo1
public var latAni0: Double? {
    return UserDefaults.standard.double(forKey: "斑點鬣狗"+"lat")
}
public var latAni1: Double? {
    return UserDefaults.standard.double(forKey: "臺灣黑熊"+"lat")
}
public var latAni2: Double? {
    return UserDefaults.standard.double(forKey: "北美灰狼"+"lat")
}
public var latAni3: Double? {
    return UserDefaults.standard.double(forKey: "笑翠鳥"+"lat")
}
public var latAni4: Double? {
    return UserDefaults.standard.double(forKey: "黑尾草原犬鼠"+"lat")
}
public var latAni5: Double? {
    return UserDefaults.standard.double(forKey: "遊客中心_前廣場"+"lat")
}
public var latAni6: Double? {
    return UserDefaults.standard.double(forKey: "山羌"+"lat")
}
public var lngAni0: Double? {
    return UserDefaults.standard.double(forKey: "斑點鬣狗"+"lng")
}
public var lngAni1: Double? {
    return UserDefaults.standard.double(forKey: "臺灣黑熊"+"lng")
}
public var lngAni2: Double? {
    return UserDefaults.standard.double(forKey: "北美灰狼"+"lng")
}
public var lngAni3: Double? {
    return UserDefaults.standard.double(forKey: "笑翠鳥"+"lng")
}
public var lngAni4: Double? {
    return UserDefaults.standard.double(forKey: "黑尾草原犬鼠"+"lng")
}
public var lngAni5: Double? {
    return UserDefaults.standard.double(forKey: "遊客中心_前廣場"+"lng")
}
public var lngAni6: Double? {
    return UserDefaults.standard.double(forKey: "山羌"+"lng")
}

class ViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {
    var timer:Timer!
    var abc:Bool=false
    var timeArray = [String](repeating:"0",count:60)
    var latArray = [Double](repeating:0.0,count:60)
    var lngArray = [Double](repeating:0.0,count:60)
    var postAniName = String()
    
    
    @IBOutlet weak var lblshow: UILabel!
    let locationManager = CLLocationManager()
    let uuid = UserDefaults.standard.string(forKey: "user_id")
    
    
    @IBOutlet var btnMenu: UIBarButtonItem!
    @IBOutlet var mapView: MKMapView!
    var aa:Int = 0
    let anns = [MKPointAnnotation(),MKPointAnnotation(),MKPointAnnotation(),MKPointAnnotation(),MKPointAnnotation(),MKPointAnnotation(),MKPointAnnotation()]
    public var tileRenderer: MKTileOverlayRenderer!
    //public parameters=[:]
    override func viewDidLoad() {
        var myDoubleTapGestureRecognizer: UIPanGestureRecognizer?
        let fullScreenSize = UIScreen.main.bounds.size
        
        
        //navigation上面的bar顏色設定
        let navigationBarAppearnce = UINavigationBar.appearance()
        navigationBarAppearnce.tintColor = UIColor.white
        navigationBarAppearnce.barTintColor = UIColor(red: 127.0/255.0, green: 191.0/255.0, blue: 63.0/255.0, alpha: 0/9)

        super.viewDidLoad()
        if UserDefaults.standard.bool(forKey: "hasViewedGuide"){
            getWorksheet()
            getRecordDone()
            downloadRec(userid:String((UserDefaults.standard.string(forKey: "user_id"))!).replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "\n", with: "")){
                ConnectionResult7 in
                switch ConnectionResult7{
                case .failure(let error):
                    print(error)
                    
                case .success( _):
                    print("success")
                }
            }
        }
       // getNowMM()
        //setupTileRenderer()
        // Do any additional setup after loading the view, typically from a nib.
        btnMenu.target = revealViewController()
        btnMenu.action = #selector(SWRevealViewController.revealToggle(_:))
        myDoubleTapGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(gestureRecognizer(_:shouldRecognizeSimultaneouslyWith:)))
        mapView.addGestureRecognizer(revealViewController().panGestureRecognizer())
        
        
        let location = CLLocationCoordinate2DMake(24.995, 121.584167)
        //設置地圖範圍（越小越精準）
        let span = MKCoordinateSpanMake(0.01, 0.01)
        
        //設置顯示區域
        let region = MKCoordinateRegionMake(location, span)
        
        mapView.setRegion(region , animated: true)
        print("finish map setup")
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Taipei Zoo"
        annotation.subtitle = "Welcome!"
        //self.mapView.addAnnotation(annotation)
        //print("finish set pin")
        
        self.mapView.showsUserLocation = true
        print("show location")
        
        //可以在 mapView　中畫出一些額外的東西
        self.mapView.delegate = self
        print("set delegate")
        
        //虎的maker
//        var i = 1;
        for  i in 0...6{
            if i == 0{
                postAniName="斑點鬣狗"
                print("hahaha")
                print(postAniName)
                print("hohoho")
                getAnimalPosition(animal: postAniName, completion: {
                    ConnectionResult5 in
                    switch ConnectionResult5{
                    case .failure(let error):
                        print(error)
                        
                    case .success( _):
                        print("success 存取動物經緯度")
                    }
                })
                
            }else if i == 1{
                postAniName="臺灣黑熊"
                print("hahaha")
                print(postAniName)
                print("hohoho")

                getAnimalPosition(animal: postAniName, completion: {
                    ConnectionResult5 in
                    switch ConnectionResult5{
                    case .failure(let error):
                        print(error)
                        
                    case .success( _):
                        print("success 存取動物經緯度")
                    }
                })
            }else if i == 2{
                postAniName="北美灰狼"
                getAnimalPosition(animal: postAniName, completion: {
                    ConnectionResult5 in
                    switch ConnectionResult5{
                    case .failure(let error):
                        print(error)
                        
                    case .success( _):
                        print("success 存取動物經緯度")
                    }
                })
            }else if i == 3{
                postAniName="笑翠鳥"
                getAnimalPosition(animal: postAniName, completion: {
                    ConnectionResult5 in
                    switch ConnectionResult5{
                    case .failure(let error):
                        print(error)
                        
                    case .success( _):
                        print("success 存取動物經緯度")
                    }
                })
            }else if i == 4{
                postAniName="黑尾草原犬鼠"
                getAnimalPosition(animal: postAniName, completion: {
                    ConnectionResult5 in
                    switch ConnectionResult5{
                    case .failure(let error):
                        print(error)
                        
                    case .success( _):
                        print("success 存取動物經緯度")
                    }
                })
            }else if i == 5{
                postAniName="遊客中心_前廣場"
                getAnimalPosition(animal: postAniName, completion: {
                    ConnectionResult5 in
                    switch ConnectionResult5{
                    case .failure(let error):
                        print(error)
                        
                    case .success( _):
                        print("success 存取動物經緯度")
                    }
                })
            }else if i == 6{
                postAniName="山羌"
                getAnimalPosition(animal: postAniName, completion: {
                    ConnectionResult5 in
                    switch ConnectionResult5{
                    case .failure(let error):
                        print(error)
                        
                    case .success( _):
                        print("success 存取動物經緯度")
                    }
                })
            }
        }

        if UserDefaults.standard.bool(forKey: "english")==true{
            anns[0].coordinate = CLLocationCoordinate2D(latitude: latAni0!, longitude: lngAni0!)
            anns[0].title = "Spotted hyena"
            
            anns[1].coordinate = CLLocationCoordinate2D(latitude: latAni1!, longitude: lngAni1!)
            anns[1].title = "Formosan black bear"
            
            anns[2].coordinate = CLLocationCoordinate2D(latitude: latAni2! , longitude: lngAni2!)
            anns[2].title = "North American gray wolf"
            
            anns[3].coordinate = CLLocationCoordinate2D(latitude: latAni3!, longitude: lngAni3!)
            anns[3].title = "Black-tailed prairie dog"
            
            anns[4].coordinate = CLLocationCoordinate2D(latitude: latAni4!, longitude: lngAni4!)
            anns[4].title = "Laughing kookaburra"
            
            anns[5].coordinate = CLLocationCoordinate2D(latitude: latAni5!, longitude: lngAni5!)
            anns[5].title = "Visitor Center"
            
            anns[6].coordinate = CLLocationCoordinate2D(latitude: latAni6!, longitude: lngAni6!)
            anns[6].title = "Reeves's muntjac"
            
            mapView.addAnnotations(anns)
        }else{
            anns[0].coordinate = CLLocationCoordinate2D(latitude: latAni0!, longitude: lngAni0!)
            anns[0].title = "斑點鬣狗"
        
            anns[1].coordinate = CLLocationCoordinate2D(latitude: latAni1!, longitude: lngAni1!)
            anns[1].title = "臺灣黑熊"
            
            anns[2].coordinate = CLLocationCoordinate2D(latitude: latAni2! , longitude: lngAni2!)
            anns[2].title = "北美灰狼"
            
            anns[3].coordinate = CLLocationCoordinate2D(latitude: latAni3!, longitude: lngAni3!)
            anns[3].title = "黑尾草原犬鼠"
            
            anns[4].coordinate = CLLocationCoordinate2D(latitude: latAni4!, longitude: lngAni4!)
            anns[4].title = "笑翠鳥"
            
            anns[5].coordinate = CLLocationCoordinate2D(latitude: latAni5!, longitude: lngAni5!)
            anns[5].title = "服務中心"
            
            anns[6].coordinate = CLLocationCoordinate2D(latitude: latAni6!, longitude: lngAni6!)
            anns[6].title = "山羌"
            
            mapView.addAnnotations(anns)
        }
        //mapView.addAnnotations(anns)
        //device id 確認
        //let defaults = UserDefaults.standard
        //let name = defaults.string(forKey: "device id")
        //print("====device id 確定相同？：",name!)
        
        
        //map的設定
        
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.distanceFilter = kCLLocationAccuracyBestForNavigation; //表示移動3公尺再更新座標資訊
        if CLLocationManager.locationServicesEnabled(){
            
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            
        }
        mapView.delegate=self
        mapView.showsScale=true
        mapView.showsPointsOfInterest=true
        mapView.showsUserLocation=true
        // 启用计时器，控制每秒执行一次tickDown方法
        timer = Timer.scheduledTimer(timeInterval: 30,target:self,selector:#selector(self.tickDown30s),userInfo:nil,repeats:true)
        timer = Timer.scheduledTimer(timeInterval: 60,target:self,selector:#selector(self.tickDown30m),userInfo:nil,repeats:true)
        let btnM:UIButton = UIButton()
        btnM.frame = CGRect(x: Int((fullScreenSize.width * 0.025)) , y:Int((fullScreenSize.height * 0.125)) , width: Int((fullScreenSize.width * 0.15)) , height: Int((fullScreenSize.width * 0.15)))
        btnM.setBackgroundImage(UIImage(named: "house" ), for: UIControlState.normal)
        btnM.addTarget(self,action: #selector(self.clickbutton),for: .touchUpInside)
        view.addSubview(btnM)
        btnM.tag = 123
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    /*
     func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
     shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
     print("gesture")
     if ((gestureRecognizer == revealViewController().panGestureRecognizer()) && (otherGestureRecognizer is UIPanGestureRecognizer)) {
     let otherTapGestureRecognizer = otherGestureRecognizer as! UIPanGestureRecognizer
     return false
     }
     return true
     }*/
    
    func mapView(_ mapkitView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        print("mapview")
        
        return tileRenderer
    }
    @IBAction func clickbutton(sender: UIButton){
        if sender.tag == 1{//hyena
            print("success")
            aa = 1
            performSegue(withIdentifier: "gotoDetail", sender: self)
            
        }else if sender.tag == 123{
            performSegue(withIdentifier: "gotoM1", sender: self)
            
        }else if sender.tag == 2{
            aa = 2
            performSegue(withIdentifier: "gotoDetail", sender: self)
        }else if sender.tag == 3{
            aa = 3
            performSegue(withIdentifier: "gotoDetail", sender: self)
        }else if sender.tag == 4{
            aa = 4
            performSegue(withIdentifier: "gotoDetail", sender: self)
        }else if sender.tag == 5{
            aa = 5
            performSegue(withIdentifier: "gotoDetail", sender: self)
        }else if sender.tag == 6{
            aa = 6
            performSegue(withIdentifier: "gotoDetail", sender: self)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoDetail"{
            let xx:KnowledgeDetailViewController = segue.destination as! KnowledgeDetailViewController
            xx.whichOne = self.aa
        }
    }
    
    //虎的func
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) ->MKAnnotationView?{
        if annotation is MKUserLocation{
            //如果標記是user所在位置，就不做處理
            return nil
        }
        
        var annView = mapView.dequeueReusableAnnotationView(withIdentifier: "Pin")
        if annView == nil {
            annView = MKAnnotationView(annotation: annotation, reuseIdentifier:"Pin")
            //dequeueReusableAnnotationView 是用來配置記憶體池位置的  當pin有在螢幕顯示範圍內 再顯示 避免浪費記憶體資源
        }
        let rightButton = UIButton(type: .detailDisclosure)
        rightButton.tag = annotation.hash
        if (annotation.title)! == "斑點鬣狗" || (annotation.title)!=="Spotted hyena" {
            annView?.image = UIImage(named:"circle_hyena")
            annView?.canShowCallout = true
            
            annView?.rightCalloutAccessoryView = rightButton
            rightButton.addTarget(self,action: #selector(self.clickbutton),for: .touchUpInside)
            rightButton.tag = 1
        }
        else if (annotation.title)! == "臺灣黑熊" || (annotation.title)!=="Formosan black bear"{
            annView?.image = UIImage(named:"circle_bear")
            
            annView?.rightCalloutAccessoryView = rightButton
            rightButton.addTarget(self,action: #selector(self.clickbutton),for: .touchUpInside)
            rightButton.tag = 2
        }
        else if (annotation.title)! == "北美灰狼" || (annotation.title)!=="North American gray wolf"{
            annView?.image = UIImage(named:"circle_wolf")
            
            annView?.rightCalloutAccessoryView = rightButton
            rightButton.addTarget(self,action: #selector(self.clickbutton),for: .touchUpInside)
            rightButton.tag = 3
        }
        else if (annotation.title)! == "黑尾草原犬鼠" || (annotation.title)!=="Black-tailed prairie dog"{
            annView?.image = UIImage(named:"circle_prairiedog")
            
            annView?.rightCalloutAccessoryView = rightButton
            rightButton.addTarget(self,action: #selector(self.clickbutton),for: .touchUpInside)
            rightButton.tag = 4
        }
        else if (annotation.title)! == "笑翠鳥" || (annotation.title)!=="Laughing kookaburra"{
            annView?.image = UIImage(named:"circle_kookaburra")
            
            annView?.rightCalloutAccessoryView = rightButton
            rightButton.addTarget(self,action: #selector(self.clickbutton),for: .touchUpInside)
            rightButton.tag = 5
        }
        else if (annotation.title)! == "服務中心" || (annotation.title)!=="Visitor Center"{
            annView?.image = UIImage(named:"gift")
        }
        else if (annotation.title)! == "山羌" || (annotation.title)!=="Reeves's muntjac"{
            annView?.image = UIImage(named:"circle_deer")
            
            annView?.rightCalloutAccessoryView = rightButton
            rightButton.addTarget(self,action: #selector(self.clickbutton),for: .touchUpInside)
            rightButton.tag = 6
        }
        
        annView?.canShowCallout = true
        
        return annView
    }
    
    func getNowMM()->Int{                 //取得目前時間的分數
        let now = Date()
        let dformatter = DateFormatter()
        dformatter.dateFormat = "mm"
        let time:Int = Int(dformatter.string(from: now))!
        //print("目前分鐘數：" + String(time))
        return time
    }
    func getNowSS()->Int{                 //取得目前時間的秒數
        let now = Date()
        let dformatter = DateFormatter()
        dformatter.dateFormat = "ss"
        let time:Int = Int(dformatter.string(from: now))!
        //print("目前秒數：" + String(time))
        return time
    }
    func timeDifference(uuid:String)->Int{  //取得userId的時間差
        
        var timeDiff:Int
        var id:String
        id = uuid
        timeDiff = Int((uuid.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "\n", with: "")))! % 30           //30分鐘為一單位
        return timeDiff
    }
    @objc func tickDown30s(){
        abc=true
    }
    @objc func tickDown30m(){
        //上傳
        //print("timeArray",timeArray)
        //print("lngArray", lngArray)
        //print("latArray", latArray)
        //postLocation(time: timeArray, lng: lngArray, lat: latArray)
        //        if getNowMM() % 30 == timeDifference(uuid: uuid!){
        //            //            //上傳
        //            //            print("timeArray",timeArray)
        //            //            print("lngArray", lngArray)
        //            //            print("latArray", latArray)
        //            //            postLocation(time: timeArray, lng: lngArray, lat: latArray)
        //            for i in 0...59{
        //                //timeArray[i]     三個要丟給家豪
        //                //lngArray[i]
        //                //latArray[i]
        //            }
        //        }
    }
    var x:Int = 0
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //print("進入locationManager")
        if abc == true{
            abc = false
            let location = locations.first!
            var mylat,mylng:Double
            mylat=location.coordinate.latitude
            mylng=location.coordinate.longitude
            //print("AQAQAQAQaQ")
            //print(mylng)
            timeArray[x] = String(getNowMM())
            lngArray[x] = mylng
            latArray[x] = mylat
            x = x + 1
            lblshow.text = String(mylat) + String(mylng)
        }
    }
    
    var swich:Bool = true
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 首次使用 向使用者詢問定位自身位置權限
        if CLLocationManager.authorizationStatus()
            == .notDetermined {
            // 取得定位服務授權
            locationManager.requestAlwaysAuthorization()
            
            // 開始定位自身位置
            locationManager.startUpdatingLocation()
        }
            // 使用者已經拒絕定位自身位置權限
        else if CLLocationManager.authorizationStatus()
            == .denied {
            // 提示可至[設定]中開啟權限
            let alertController = UIAlertController(
                title: "定位權限已關閉",
                message:
                "如要變更權限，請至 設定 > 隱私權 > 定位服務 開啟",
                preferredStyle: .alert)
            let okAction = UIAlertAction(
                title: "確認", style: .default, handler:nil)
            alertController.addAction(okAction)
            self.present(
                alertController,
                animated: true, completion: nil)
        }
            // 使用者已經同意定位自身位置權限
        else if CLLocationManager.authorizationStatus()
            == .authorizedWhenInUse {
            // 開始定位自身位置
            locationManager.startUpdatingLocation()
        }
        
        if UserDefaults.standard.bool(forKey: "hasViewedGuide") {
            return
        }
        
        if let pageViewController = storyboard?.instantiateViewController(withIdentifier: "GuideController") as? GuidePageViewController {
            
            present(pageViewController, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        locationManager.stopUpdatingLocation()
    }
}

