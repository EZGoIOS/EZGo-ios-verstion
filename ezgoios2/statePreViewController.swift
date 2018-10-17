//
//  statePreViewController.swift
//  Unity-iPhone
//
//  Created by Administrator on 2018/9/18.
//

import UIKit
import MapKit
import CoreLocation
import WebKit

class statePreViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate,WKUIDelegate {
    let fullScreenSize = UIScreen.main.bounds.size
    var whichOne = Int()
    let locationManager = CLLocationManager()
    var webView: WKWebView!
    var boxView = UIView()
    var animal = String()
    var urlString = String()
    var arrive:Bool = false
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var btnMenu: UIBarButtonItem!
    @IBOutlet weak var btnWrite: UIButton!
    @IBOutlet weak var btnPre: UIButton!
    @IBOutlet weak var btnGuess: UIButton!
    @IBOutlet weak var lblshow: UILabel!
    @IBOutlet weak var lblshow2: UILabel!
    @IBAction func write(_ sender: Any) {
        if arrive{
            performSegue(withIdentifier: "pregotoSelect", sender: self)
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
            btnGuess.setBackgroundImage(UIImage(named: "statusPredictions-pressed_eng" ), for: UIControlState.normal)
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
        switch whichOne {
        case 1: distance = xx(lat1:mylat,lng1:mylng,lat2:24.9946605, lng2:121.5887605) * 1000
        case 2: distance = xx(lat1:mylat,lng1:mylng,lat2:24.9975801, lng2:121.5799735) * 1000
        case 3: distance = xx(lat1:mylat,lng1:mylng,lat2:24.9932772, lng2:121.5900815) * 1000
        case 4: distance = xx(lat1:mylat,lng1:mylng,lat2:24.9921553, lng2:121.5890408) * 1000
        case 5: distance = xx(lat1:mylat,lng1:mylng,lat2:24.995106, lng2:121.583514) * 1000
        case 6: distance = xx(lat1:mylat,lng1:mylng,lat2:24.9977223, lng2:121.5810719) * 1000
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
        if distance<=25 {yn = true}
        else{yn = false}
        return yn
    }
    
    func webViewDidStartLoad(webView_Pages: WKWebView) {
        //        activityIndicator.startAnimating()
        //        // Box config:
        boxView = UIView(frame: CGRect(x: Int((fullScreenSize.width * 0.055)) , y:Int((fullScreenSize.height * 0.02)) , width: Int((fullScreenSize.width * 0.9)) , height: Int((fullScreenSize.height * 0.7))))
        boxView.backgroundColor = UIColor.black
        boxView.alpha = 0.9
        boxView.layer.cornerRadius = 10
        // Spin config:
        let activityView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        activityView.frame = CGRect(x: Int((fullScreenSize.width * 0.055)) , y:Int((fullScreenSize.height * 0.02)) , width: Int((fullScreenSize.width * 0.9)) , height: Int((fullScreenSize.height * 0.7)))
        activityView.startAnimating()
        // Text config:
        let textLabel = UILabel(frame: CGRect(x: Int((fullScreenSize.width * 0.055)) , y:Int((fullScreenSize.height * 0.02)) , width: Int((fullScreenSize.width * 0.9)) , height: Int((fullScreenSize.height * 0.7))))
        textLabel.textColor = UIColor.white
        textLabel.textAlignment = .center
        textLabel.font = UIFont(name: textLabel.font.fontName, size: 13)
        textLabel.text = "Loading..."
        //        // Activate:
        boxView.addSubview(activityView)
        boxView.addSubview(textLabel)
        view.addSubview(boxView)
    }
    
    func webViewDidFinishLoad(webView_Pages: WKWebView) {
        
        // Removes it:
        boxView.removeFromSuperview()
        //activityIndicator.stopAnimating()
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
        
        let animalURL = "http://ezgo.twjoin.com/statusStackedColumnChart?whichAnimal=" + animal
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
            
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            
        }
        
        //控制物件位置---------------------
        btnPre.frame = CGRect(x: Int((fullScreenSize.width * 0.066)) , y:Int((fullScreenSize.height * 0.885)) , width: Int((fullScreenSize.width * 0.4)) , height: Int((fullScreenSize.height * 0.085)))
        btnGuess.frame = CGRect(x: Int((fullScreenSize.width * 0.533)) , y:Int((fullScreenSize.height * 0.885)) , width: Int((fullScreenSize.width * 0.4)) , height: Int((fullScreenSize.height * 0.085)))
        btnWrite.frame = CGRect(x: Int((fullScreenSize.width * 0.15)) , y:Int((fullScreenSize.height * 0.78)) , width: Int((fullScreenSize.width * 0.7)) , height: Int((fullScreenSize.height * 0.1)))
        if UserDefaults.standard.bool(forKey: "english"){
            btnPre.setBackgroundImage(UIImage(named: "previousStatuses-pressed-btn_eng" ), for: UIControlState.normal)
            btnGuess.setBackgroundImage(UIImage(named: "statusPredictions-btn_eng" ), for: UIControlState.normal)
        }else{
            btnPre.setBackgroundImage(UIImage(named: "previousStatuses-pressed-btn" ), for: UIControlState.normal)
            btnGuess.setBackgroundImage(UIImage(named: "statusPredictions-btn" ), for: UIControlState.normal)
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
        if segue.identifier == "pregotoSelect"{
            let xx:State_select = segue.destination as! State_select
            xx.whichOne = whichOne
        }else{
            let xx:stateGuessViewController = segue.destination as! stateGuessViewController
        xx.whichOne = whichOne
        }
    }
    

}
