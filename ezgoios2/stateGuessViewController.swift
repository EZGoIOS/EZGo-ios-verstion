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
    
    @IBOutlet var btnMenu: UIBarButtonItem!

    @IBOutlet weak var lblshow: UILabel!
    
    @IBOutlet weak var btnGuess: UIButton!
    @IBOutlet weak var btnPre: UIButton!
    @IBOutlet weak var btnWrite: UIButton!
    @IBAction func btnPre(_ sender: Any) {
        btnPre.setBackgroundImage(UIImage(named: "previousStatuses-pressed-btn" ), for: UIControlState.normal)
        btnGuess.setBackgroundImage(UIImage(named: "statusPredictions-btn" ), for: UIControlState.normal)

    }
    
    @IBAction func btnGuess(_ sender: Any) {
        btnPre.setBackgroundImage(UIImage(named: "previousStatuses-btn" ), for: UIControlState.normal)
        btnGuess.setBackgroundImage(UIImage(named: "statusPredictions-pressed-btn" ), for: UIControlState.normal)

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
        if distance<=10000 {yn = true}
        else{yn = false}
        return yn
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        //網頁內嵌
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        self.view.addSubview(webView)
        let myURL = URL(string:"http://ezgo.twjoin.com/statusPieChart")
        let myRequest = URLRequest(url: myURL!)
        webView.frame = CGRect(x: Int((fullScreenSize.width * 0.055)) , y:Int((fullScreenSize.height * 0.02)) , width: Int((fullScreenSize.width * 0.9)) , height: Int((fullScreenSize.height * 0.65)))
        webView.load(myRequest)
        
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.distanceFilter = CLLocationDistance(3); //表示移動3公尺再更新座標資訊
        if CLLocationManager.locationServicesEnabled(){
            
            locationManager.delegate = self as! CLLocationManagerDelegate
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            
        }
        
        //圖片遮色
        let origin = CIImage(image:UIImage(named: "ok-btn")!)
        let filter = CIFilter(name:"CIPhotoEffectMono")
        filter?.setDefaults()
        filter?.setValue(origin,forKey:kCIInputImageKey)
        
        //控制物件位置---------------------
        lblshow.text = String(whichOne)
        btnPre.frame = CGRect(x: Int((fullScreenSize.width * 0)) , y:Int((fullScreenSize.height * 0.83)) , width: Int((fullScreenSize.width * 0.5)) , height: Int((fullScreenSize.width * 0.17)))
        btnPre.setBackgroundImage(UIImage(named: "previousStatuses-btn" ), for: UIControlState.normal)
        
        btnGuess.frame = CGRect(x: Int((fullScreenSize.width * 0.5)) , y:Int((fullScreenSize.height * 0.83)) , width: Int((fullScreenSize.width * 0.5)) , height: Int((fullScreenSize.width * 0.17)))
        btnGuess.setBackgroundImage(UIImage(named: "statusPredictions-pressed-btn" ), for: UIControlState.normal)

        btnWrite.frame = CGRect(x: Int((fullScreenSize.width * 0.15)) , y:Int((fullScreenSize.height * 0.7)) , width: Int((fullScreenSize.width * 0.7)) , height: Int((fullScreenSize.width * 0.2)))
        btnWrite.setTitleColor(UIColor.white, for: UIControlState.normal)
        btnWrite.setBackgroundImage(UIImage(named: "pickStatus-btn" ), for: UIControlState.normal)
        if UserDefaults.standard.bool(forKey: "english"){
            btnWrite.setBackgroundImage(UIImage(named: "pickStatus-btn_eng" ), for: UIControlState.normal)
        }else{
            btnWrite.setBackgroundImage(UIImage(named: "pickStatus-btn" ), for: UIControlState.normal)
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first!
        //圖片遮色
        let origin = CIImage(image:UIImage(named: "ok-btn")!)
        let filter = CIFilter(name:"CIPhotoEffectMono")
        filter?.setDefaults()
        filter?.setValue(origin,forKey:kCIInputImageKey)
        
        var mylat,mylng:Double
        mylat=location.coordinate.latitude
        mylng=location.coordinate.longitude
        howLong(whichOne: whichOne, mylat: mylat, mylng: mylng)
        if distanceIs(distance: howLong(whichOne: whichOne, mylat: mylat, mylng: mylng)){
            if let output = filter?.outputImage{
                let tmp = CIContext().createCGImage(output, from: output.extent)
                //btnWrite.setImage(UIImage(cgImage:tmp!), for: UIControlState.normal)
            }
        }
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
