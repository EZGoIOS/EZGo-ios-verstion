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

class ViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {
    var timer:Timer!
    var abc:Bool=false
    var timeArray = [String](repeating:"0",count:60)
    var latArray = [Double](repeating:0.0,count:60)
    var lngArray = [Double](repeating:0.0,count:60)
    
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
        
        super.viewDidLoad()
        if UserDefaults.standard.bool(forKey: "hasViewedGuide"){
            getWorksheet()
            getRecordDone()
        }
        getNowMM()
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
        
        
        anns[0].coordinate = CLLocationCoordinate2D(latitude: 24.9946605, longitude: 121.5887605)
        anns[0].title = "斑點鬣狗"
        
        anns[1].coordinate = CLLocationCoordinate2D(latitude: 24.9975801, longitude: 121.5799735)
        anns[1].title = "臺灣黑熊"
        
        anns[2].coordinate = CLLocationCoordinate2D(latitude: 24.9932772, longitude: 121.5900815)
        anns[2].title = "北美灰狼"
        
        anns[3].coordinate = CLLocationCoordinate2D(latitude: 24.9921553, longitude: 121.5890408)
        anns[3].title = "黑尾草原犬鼠"
        
        anns[4].coordinate = CLLocationCoordinate2D(latitude: 24.995106, longitude: 121.583514)
        anns[4].title = "笑翠鳥"
        
        anns[5].coordinate = CLLocationCoordinate2D(latitude: 24.9978621, longitude: 121.5818524)
        anns[5].title = "教育中心"
        
        anns[6].coordinate = CLLocationCoordinate2D(latitude: 24.9977223, longitude: 121.5810719)
        anns[6].title = "山羌"
        
        mapView.addAnnotations(anns)
        
        
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
            //   performSegue(withIdentifier: "aaaa", sender: self)
            //performSegue(withIdentifier: "aaaa", sender: Any?.self)
            aa = 1
            performSegue(withIdentifier: "gotoDetail", sender: self)
            
        }
        else if sender.tag == 123{
            performSegue(withIdentifier: "gotoM1", sender: self)

        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoDetail"{
            var xx:KnowledgeDetailViewController = segue.destination as! KnowledgeDetailViewController
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
        if (annotation.title)! == "斑點鬣狗" {
            annView?.image = UIImage(named:"circle_hyena")
            annView?.canShowCallout = true
            
            annView?.rightCalloutAccessoryView = rightButton
            rightButton.addTarget(self,action: #selector(self.clickbutton),for: .touchUpInside)
            rightButton.tag = 1
        }
        else if (annotation.title)! == "臺灣黑熊"{
            annView?.image = UIImage(named:"circle_bear")
        }
        else if (annotation.title)! == "北美灰狼"{
            annView?.image = UIImage(named:"circle_wolf")
        }
        else if (annotation.title)! == "黑尾草原犬鼠"{
            annView?.image = UIImage(named:"circle_prairiedog")
        }
        else if (annotation.title)! == "笑翠鳥"{
            annView?.image = UIImage(named:"circle_kookaburra")
        }
        else if (annotation.title)! == "教育中心"{
            annView?.image = UIImage(named:"gift")
        }
        else if (annotation.title)! == "山羌"{
            annView?.image = UIImage(named:"circle_deer")
        }
        
        annView?.canShowCallout = true
        
        return annView
    }
    
    func getNowMM()->Int{                 //取得目前時間的分數
        let now = Date()
        let dformatter = DateFormatter()
        dformatter.dateFormat = "mm"
        var time:Int = Int(dformatter.string(from: now))!
        //print("目前分鐘數：" + String(time))
        return time
    }
    func getNowSS()->Int{                 //取得目前時間的秒數
        let now = Date()
        let dformatter = DateFormatter()
        dformatter.dateFormat = "ss"
        var time:Int = Int(dformatter.string(from: now))!
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
        print("timeArray",timeArray)
        print("lngArray", lngArray)
        print("latArray", latArray)
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
        print("進入locationManager")
        if abc == true{
            abc = false
            let location = locations.first!
            var mylat,mylng:Double
            mylat=location.coordinate.latitude
            mylng=location.coordinate.longitude
            print("AQAQAQAQaQ")
            print(mylng)
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

