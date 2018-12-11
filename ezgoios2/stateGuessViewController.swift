//
//  stateGuessViewController.swift
//  Unity-iPhone
//
//  Created by Administrator on 2018/9/18.
//

import UIKit
import MapKit
import CoreLocation
import WebKit

class stateGuessViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate,WKUIDelegate {
    let fullScreenSize = UIScreen.main.bounds.size
    var whichOne = Int()
    let locationManager = CLLocationManager()
    var webView: WKWebView!
    var arrive:Bool = false
    var animal = String()
    @IBOutlet var btnMenu: UIBarButtonItem!
    @IBOutlet weak var lblshow: UILabel!
    @IBOutlet weak var btnGuess: UIButton!
    @IBOutlet weak var btnPre: UIButton!
    @IBOutlet weak var btnWrite: UIButton!
    
    @IBAction func write(_ sender: Any) {
        if arrive{
            performSegue(withIdentifier: "guegotoSelect", sender: self)
        }else{
            if UserDefaults.standard.bool(forKey: "english")==true{
                let alert = UIAlertView()
                alert.title = "Notice！"
                alert.message = "You have not arrived yet!"
                alert.addButton(withTitle: "OK")
                alert.show()
            }else{
                let alert = UIAlertView()
                alert.title = "注意！"
                alert.message = "您尚未到達！"
                alert.addButton(withTitle: "OK")
                alert.show()
            }
        }
    }
    @IBAction func btnPre(_ sender: Any) {
        if UserDefaults.standard.bool(forKey: "english")==true{
            btnPre.setBackgroundImage(UIImage(named: "previousStatuses-pressed-btn_eng" ), for: UIControlState.normal)
            btnGuess.setBackgroundImage(UIImage(named: "statusPredictions-btn_eng" ), for: UIControlState.normal)
        }else{
            btnPre.setBackgroundImage(UIImage(named: "previousStatuses-pressed-btn" ), for: UIControlState.normal)
            btnGuess.setBackgroundImage(UIImage(named: "statusPredictions-btn" ), for: UIControlState.normal)
        }
    }
    
    @IBAction func btnGuess(_ sender: Any) {
        if UserDefaults.standard.bool(forKey: "english")==true{
            btnPre.setBackgroundImage(UIImage(named: "previousStatuses-btn_eng" ), for: UIControlState.normal)
            btnGuess.setBackgroundImage(UIImage(named: "statusPredictions-pressed-btn_eng" ), for: UIControlState.normal)
        }else{
            btnPre.setBackgroundImage(UIImage(named: "previousStatuses-btn" ), for: UIControlState.normal)
            btnGuess.setBackgroundImage(UIImage(named: "statusPredictions-pressed-btn" ), for: UIControlState.normal)
        }
    }
    func getNowMM()->Int{                 //取得目前時間的分數
        let now = Date()
        let dformatter = DateFormatter()
        dformatter.dateFormat = "mm"
        let time:Int = Int(dformatter.string(from: now))!
        //print("目前分鐘數：" + String(time))
        return time
    }
    func howLong(whichOne:Int,mylat:Double,mylng:Double) -> Double {                              //計算距離
        var distance:Double
//        var AniL = AnimalLocationClass()
        switch whichOne {
            
        case 1: distance = xx(lat1:mylat,lng1:mylng,lat2:latAni0!, lng2:lngAni0!) * 1000
        case 2: distance = xx(lat1:mylat,lng1:mylng,lat2:latAni1!, lng2:lngAni1!) * 1000
        case 3: distance = xx(lat1:mylat,lng1:mylng,lat2:latAni2!, lng2:lngAni2!) * 1000
        case 4: distance = xx(lat1:mylat,lng1:mylng,lat2:latAni4!, lng2:lngAni4!) * 1000
        case 5: distance = xx(lat1:mylat,lng1:mylng,lat2:latAni3!, lng2:lngAni3!) * 1000
        case 6: distance = xx(lat1:mylat,lng1:mylng,lat2:latAni6!, lng2:lngAni6!) * 1000
            
        default: distance = 0.0
        }
        return distance
    }
    func rad(d:Double)->Double{                                             //距離演算法
        return (d * 3.14159265358979) / 180.0
    }
    func xx (lat1:Double,lng1:Double,lat2:Double,lng2:Double)->Double{      //距離演算法
        let earthRadius:Double=6378.137
        
        let radLat1:Double = rad(d:lat1)
        let radLat2:Double = rad(d:lat2)
        let a:Double = radLat1 - radLat2
        let b:Double = rad(d:lng1) - rad(d:lng2)
        var s:Double = 2 * asin(sqrt(pow(sin(a/2),2) + cos(radLat1) * cos(radLat2) * pow(sin(b/2),2)))
        s = s * earthRadius
        s = round(s*10000) / 10000
        return s
        
    }
    
    func distanceIs(distance:Double)->Bool{                                  //判斷距離是否到達
        var yn:Bool
        if distance<=100000000 {yn = true}
        else{yn = false}
        return yn
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if whichOne == 1{
            animal = "斑點鬣狗"
        }else if whichOne == 2{
            animal = "臺灣黑熊"
        }else if whichOne == 3{
            animal = "北美灰狼"
        }else if whichOne == 4{
            animal = "黑尾草原犬鼠"
        }else if whichOne == 5{
            animal = "笑翠鳥"
        }else if whichOne == 6{
            animal = "山羌"
        }
        
        //網頁內嵌
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        
        let animalURL = "http://ezgo.twjoin.com/status/pieChart?whichAnimal=" + animal
        print("**********",animalURL)
        let myURL = URL(string: animalURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
        let request = URLRequest(url: myURL!)
        
        webView.frame = CGRect(x: Int((fullScreenSize.width * 0.055)) , y:Int((fullScreenSize.height * 0.12)) , width: Int((fullScreenSize.width * 0.9)) , height: Int((fullScreenSize.height * 0.65)))
        webView.load(request)
        self.view.addSubview(webView)
        print("is it running?????",webView.isLoading)
        
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.distanceFilter = CLLocationDistance(3); //表示移動3公尺再更新座標資訊
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self as CLLocationManagerDelegate
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            
        }
        
        //控制物件位置---------------------
        btnPre.frame = CGRect(x: Int((fullScreenSize.width * 0.066)) , y:Int((fullScreenSize.height * 0.885)) , width: Int((fullScreenSize.width * 0.4)) , height: Int((fullScreenSize.height * 0.085)))
        btnGuess.frame = CGRect(x: Int((fullScreenSize.width * 0.533)) , y:Int((fullScreenSize.height * 0.885)) , width: Int((fullScreenSize.width * 0.4)) , height: Int((fullScreenSize.height * 0.085)))
        btnWrite.frame = CGRect(x: Int((fullScreenSize.width * 0.15)) , y:Int((fullScreenSize.height * 0.78)) , width: Int((fullScreenSize.width * 0.7)) , height: Int((fullScreenSize.height * 0.1)))
        if UserDefaults.standard.bool(forKey: "english"){
            btnPre.setBackgroundImage(UIImage(named: "previousStatuses-btn_eng" ), for: UIControlState.normal)
            btnGuess.setBackgroundImage(UIImage(named: "statusPredictions-pressed-btn_eng" ), for: UIControlState.normal)
        }else{
            btnPre.setBackgroundImage(UIImage(named: "previousStatuses-btn" ), for: UIControlState.normal)
            btnGuess.setBackgroundImage(UIImage(named: "statusPredictions-pressed-btn" ), for: UIControlState.normal)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first!
        var mylat,mylng:Double
        mylat=location.coordinate.latitude
        mylng=location.coordinate.longitude
        if distanceIs(distance: howLong(whichOne: whichOne, mylat: mylat, mylng: mylng)){
            arrive = true
            if UserDefaults.standard.bool(forKey: "english")==true{
                btnWrite.setBackgroundImage(UIImage(named: "pickStatus-btn_eng" ), for: UIControlState.normal)
            }else{
                btnWrite.setBackgroundImage(UIImage(named: "pickStatus-btn" ), for: UIControlState.normal)
            }
        }else{
            arrive = false
            if UserDefaults.standard.bool(forKey: "english")==true{
                btnWrite.setBackgroundImage(UIImage(named: "pickStatus-btn_eng-gray" ), for: UIControlState.normal)
            }else{
                btnWrite.setBackgroundImage(UIImage(named: "pickStatus-btn-gray" ), for: UIControlState.normal)
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "guegotoSelect"{
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
