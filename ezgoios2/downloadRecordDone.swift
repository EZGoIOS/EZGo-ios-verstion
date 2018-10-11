//
//  downloadRecordDone.swift
//  Unity-iPhone
//
//  Created by vickyliao on 2018/7/6.
//

import Foundation
enum ConnectionResult7{
    case success(Data)
    case failure(Error)
}
func downloadRec(userid:String,completion: @escaping(ConnectionResult7) -> ()){
    guard let url = URL(string:"http://ezgo.twjoin.com/downloadRewardDone/" + userid)else{return}
    var request = URLRequest(url:url)
    request.httpMethod = "GET"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let session = URLSession.shared
    
    session.dataTask(with: request){(data,response,error) in
        if let response = response{
            print(response)
        }
        if let data = data{
            do{
                let json = try JSONSerialization.jsonObject(with: data, options:[.allowFragments]) as? NSDictionary
                //print(json)
                let val = String(describing: ((json!.value(forKey: "reward")!) as! NSObject).value(forKey: "done")!).replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: "\r\n", with: "")
                print("是否完成兌獎",val)
                if val=="1"{
                    UserDefaults.standard.set(true, forKey: "hasChangedReward")
                }else{
                    UserDefaults.standard.set(false, forKey: "hasChangedReward")
                }
                print(UserDefaults.standard.bool(forKey: "hasChangedReward"))
            }catch{
                print(error)
            }
        }
        }.resume()
}
