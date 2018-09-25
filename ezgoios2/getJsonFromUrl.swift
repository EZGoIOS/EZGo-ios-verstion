//
//  getJsonFromUrl.swift
//  ezgo1
//
//  Created by vickyliao on 2018/3/30.
//  Copyright © 2018年 vickyliao. All rights reserved.
//

import Foundation

enum ConnectionResult{
    case success(Data)
    case failure(Error)
}

//var uuid=""

public var question=[String](repeating:"0", count:18)
public var qdescription=[String](repeating:"0", count:18)
public var answer=[String](repeating:"0", count:18)
public var record_question_id=[String](repeating:"0", count:18)
public var option_question_id=[String]()
public var qOption=[String]()

public var hyena = [0,1,2]
public var bear = [3,4,5]
public var wolf = [6,7,8]
public var prairiedog = [9,10,11]
public var kookaburra = [12,13,14]
public var deer = [15,16,17]
public var options = [String:[Any]]()
public var showQ=[String](repeating:"0",count:3)
public var showId=[String](repeating:"0", count:3)
public var showAns=[String](repeating:"0", count:3)
public var showDescript=[String](repeating:"0", count:3)
public var qFileA=[String](repeating:"0", count:18)

public var recordFile = NSHomeDirectory() + "/Documents/record.txt"
public var optionFile = NSHomeDirectory() + "/Documents/option.txt"
public var showQFile = NSHomeDirectory() + "/Documents/showQFile.txt"
public var showOptFile = NSHomeDirectory() + "/Documents/showOptFile.txt"
public var showAnsFile = NSHomeDirectory() + "/Documents/showAnsFile.txt"
public var showDescriptFile = NSHomeDirectory() + "/Documents/showDescriptFile.txt"
public var questionIdFile = NSHomeDirectory() + "/Documents/questionIdFile"

public var w = 1
public var k = 0

public var recCut=""
public var recUse=[String](repeating:"0",count:18)
//user id
let userid = UserDefaults.standard.string(forKey: "user_id")

//the json file url 把userdefault裡面不必要的東西也去掉 才能接到網頁後面取資料
public var urlWorksheet = ""


//this function is fetching the json from URL
func getJsonFromUrl(whichAnimal:Int, completion: @escaping(ConnectionResult) -> ()){
    if UserDefaults.standard.bool(forKey: "english")==true{
        urlWorksheet = "http://ezgo.twjoin.com/showQuest_en/\((String((UserDefaults.standard.string(forKey: "user_id"))!).replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "\n", with: "")))"
    }else{
        urlWorksheet = "http://ezgo.twjoin.com/showQuest/\((String((UserDefaults.standard.string(forKey: "user_id"))!).replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "\n", with: "")))"
    }
    print("為啥咪全部都是梅花鹿ＱＡＱ")
    print(whichAnimal)
    question=[String](repeating:"0", count:18)
    qdescription=[String](repeating:"0", count:18)
    answer=[String](repeating:"0", count:18)
    record_question_id=[String](repeating:"0", count:18)
    option_question_id=[String]()
    qOption=[String]()
    
    hyena = [0,1,2]
    bear = [3,4,5]
    wolf = [6,7,8]
    prairiedog = [9,10,11]
    kookaburra = [12,13,14]
    deer = [15,16,17]
    options = [String:[Any]]()
    showQ=[String](repeating:"0",count:3)
    showId=[String](repeating:"0", count:3)
    showAns=[String](repeating:"0", count:3)
    showDescript=[String](repeating:"0", count:3)
    qFileA=[String](repeating:"0", count:18)
    
    recordFile = NSHomeDirectory() + "/Documents/record.txt"
    optionFile = NSHomeDirectory() + "/Documents/option.txt"
    showQFile = NSHomeDirectory() + "/Documents/showQFile.txt"
    showOptFile = NSHomeDirectory() + "/Documents/showOptFile.txt"
    showAnsFile = NSHomeDirectory() + "/Documents/showAnsFile.txt"
    showDescriptFile = NSHomeDirectory() + "/Documents/showDescriptFile.txt"
    questionIdFile = NSHomeDirectory() + "/Documents/questionIdFile"
    
    w = 1
    k = 0
    
    recCut=""
    recUse=[String](repeating:"0",count:18)
    //creating a NSURL
    let url = NSURL(string: urlWorksheet)
    //var returnArray = [String](repeating:"1", count:18)
    
    //completion(false)
    //fetching the data from the url
    URLSession.shared.dataTask(with: (url as URL?)!, completionHandler: {(data, response, error) in
        
        if let error = error {
            completion(.failure(error))
        }else{
            completion(.success(data!))
            
            let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary
            //print(jsonObj??.value(forKey: "record")! as Any)
            print(jsonObj??.value(forKey: "option")! as Any)
            
            //處理字典轉成的字串
            let question_String = String(describing: ((jsonObj!?.value(forKey: "record")!) as! NSObject).value(forKey: "question")!).replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: "\r\n", with: "")
            let answer_String = String(describing: ((jsonObj!?.value(forKey: "record")!) as! NSObject).value(forKey: "answer")!).replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: "\r\n", with: "")
            let qdescription_String = String(describing: ((jsonObj!?.value(forKey: "record")!) as! NSObject).value(forKey: "description")!).replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: "\r\n", with: "")
            let rec_qid_String = String(describing: ((jsonObj!?.value(forKey: "record")!) as! NSObject).value(forKey: "question_id")!).replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: "\r\n", with: "")
            print("OAOAOAOAOOAOAOAOAOAO")
            print(question_String)
            //將處理過的字串分割後變成陣列
            let question_Seperate = question_String.components(separatedBy: ",")
            let answer_Seperate = answer_String.components(separatedBy: ",")
            let qdescription_Seperate = qdescription_String.components(separatedBy: ",")
            _ = rec_qid_String.components(separatedBy: ",")
            print("========================")
            print(question_Seperate)
            //把分割搞定的陣列移回去原本宣告的陣列
            question = question_Seperate
            answer = answer_Seperate
            qdescription = qdescription_Seperate
            
            do{
                try ((jsonObj!?.value(forKey: "record")!) as AnyObject).write(toFile: recordFile, atomically: true)
                try ((jsonObj!?.value(forKey: "option")!) as AnyObject).write(toFile: optionFile, atomically: true)
                question = ((((jsonObj!?.value(forKey: "record")!) as AnyObject).value(forKey:"question")! as AnyObject)) as! [String]
                answer = ((((jsonObj!?.value(forKey: "record")!) as AnyObject).value(forKey:"answer")! as AnyObject)) as! [String]
                qdescription = ((((jsonObj!?.value(forKey: "record")!) as AnyObject).value(forKey:"description")! as AnyObject)) as! [String]
                record_question_id = ((((jsonObj!?.value(forKey: "record")!) as AnyObject).value(forKey:"question_id")! as AnyObject)) as! [String]
                //self.option_question_id = [(NumberFormatter().number(from: ((((jsonObj!.value(forKey: "option")!) as! NSObject).value(forKey:"question_id")! as! NSObject)) as! String)) as! Int]
                option_question_id = ((((jsonObj!?.value(forKey: "option")!) as! NSObject).value(forKey:"question_id")! as AnyObject)) as! [String]
                qOption = ((((jsonObj!?.value(forKey: "option")!) as AnyObject).value(forKey:"qOption")! as AnyObject)) as! [String]
                
            }catch{
                print("Not save correctly")
            }
            
            //=======選項處理=======
            _ = qOption.count
            w = 0
            print("GGGGGGGGGGGGGGG")
            print(option_question_id)
            var xxxxxxx:Array<String> = []
            xxxxxxx = option_question_id
            xxxxxxx.append("517")
            print(qOption)
            for i in 1...18{
                //print(w)
                var x = 1
                var optArr=[String]()
                for j in k...100{
                    if j==option_question_id.count{
                        
                        break
                    }else{
                        if xxxxxxx[j] == xxxxxxx[j+1]{
                            x = x+1
                            k = k+1
                        }else{
                            k = k+1
                            for m in stride(from: x, to: 0, by: -1){
                                optArr.append(qOption[k-m])
                            }
                            break
                        }
                    }
                }
                
                options[String(i)] = optArr
            }
            print(options)
            //先寫按到哪個按鈕對應到哪個動物，然後用那個動物指過去他的陣列
            var y:Int
            //print("=========================================================================================")
            //print("whichAnimal"+String(whichAnimal))
            if whichAnimal == 1{
                y = hyena[0]
                //print(String(y))
            }else if whichAnimal == 2{
                y = bear[0]
                //print(String(y))
                
            }else if whichAnimal == 3{
                y = wolf[0]
                //print(String(y))
                
            }else if whichAnimal == 4{
                y = prairiedog[0]
                //print(String(y))
                
            }else if whichAnimal == 5{
                y = kookaburra[0]
                //print(String(y))
                
            }else {
                y = deer[0]
                //print(String(y))
                
            }
            //print("=========================================================================================")
            
            for x in 0...2{
                showQ[x] = question[y]
                showId[x] = record_question_id[y]
                showAns[x] = answer[y]
                showDescript[x] = qdescription[y]
                y = y+1
            }
            for i in 0...2{
                showQ[i] = showQ[i].replacingOccurrences(of: "\n", with: "")
                
            }
            
            
            
            do{
                let writev = showQ.joined(separator: "\n")
                let writeId = showId.joined(separator: "\n")
                let writeAns = showAns.joined(separator: "\n")
                let writeDes = showDescript.joined(separator: "\n")
                //forKey會是變數喔！
                var writeo = "love555\n" + (((options as NSDictionary).value(forKey: String(whichAnimal * 3 - 2))!) as! NSArray).componentsJoined(by: "\n")
                writeo = writeo + "\nlove666\n" + (((options as NSDictionary).value(forKey: String(whichAnimal * 3 - 1))!) as! NSArray).componentsJoined(by: "\n")
                writeo = writeo + "\nlove777\n" + (((options as NSDictionary).value(forKey: String(whichAnimal * 3))!) as! NSArray).componentsJoined(by: "\n") + "\nlove888"
                print("為啥咪全部都是梅花鹿ＱＡＱ2")
                
                print(writeo)
                try (writev).write(toFile: showQFile, atomically: true, encoding: .utf8)
                try (writeo).write(toFile: showOptFile, atomically: true, encoding: .utf8)
                try (writeId).write(toFile: questionIdFile, atomically: true, encoding: .utf8)
                try (writeAns).write(toFile: showAnsFile, atomically: true, encoding: .utf8)
                try (writeDes).write(toFile: showDescriptFile, atomically: true, encoding: .utf8)
                _ = (try NSString(contentsOfFile: showQFile, encoding: String.Encoding.utf8.rawValue) as String)
                //print("in file",recString)
                //print("showQFile:",showQFile)
                print(questionIdFile)
            }catch{
            }
            
        }
    }).resume()
}

