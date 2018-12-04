//
//  getAnimalPosition.swift
//  Unity-iPhone
//
//  Created by  Anthea on 2018/11/29.
//

import Foundation

enum ConnectionResult5{
    case success(Data)
    case failure(Error)
}

func getAnimalPosition(animal:String, completion: @escaping(ConnectionResult5) -> ()){
    let parameters = ["whichAnimal":animal]
    print("getAnimalPosition.swift 的parameters參數：",parameters)
    guard let url = URL(string:"http://ezgo.twjoin.com/status/coordinate")else{return}
    var request = URLRequest(url:url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [.prettyPrinted])else{return}
    request.httpBody = httpBody
    
    let session = URLSession.shared
    
    session.dataTask(with: request){(data,response,error) in
        if let response = response{
            //print(response)
        }
        if let data = data{
            do{
                let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? NSDictionary
                print(json!)
                
                let lat = (((json!.value(forKey: animal)!)) as AnyObject).value(forKey: "lat")!
                print(String(describing: lat))
                UserDefaults.standard.set(String(describing: lat), forKey: (animal+"lat"))
                print(animal,"經度",UserDefaults.standard.value(forKey: (animal+"lat")))
                print(UserDefaults.standard.value(forKey: "北美灰狼"+"lat")!)
                print("^_^")
                let lng = (((json!.value(forKey: animal)!)) as AnyObject).value(forKey: "lng")!
                print(String(describing: lng))
                UserDefaults.standard.set(String(describing: lng), forKey: (animal+"lng"))
                print(animal,"緯度",UserDefaults.standard.value(forKey: (animal+"lng")))
                
//                let ani = json?.value(forKey: animal)
//                UserDefaults.standard.set(ani, forKey: animal)
//                print(animal,"這裡這裡這裡",UserDefaults.standard.value(forKey: animal))
//                let select = UserDefaults.standard.value(forKey: animal)
//
            }catch{
                print(error)
            }
        }
        }.resume()
}
