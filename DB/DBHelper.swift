//
//  DBHelper.swift
//  BlackRamen
//
//  Created by LinuxPlus on 8/29/18.
//  Copyright © 2018 private. All rights reserved.
//

import Foundation
import UIKit

func GetPersonList() -> [PersonModel]
{
    var _personList = [PersonModel]()
    
    
    _personList.append(PersonModel(personId: "10001", name: "Ryan", lastName: "Robles", imageProfile: "10001.jpg", totalThumbsUpCount: 100, totalThumbsDownCount: 20, otherDescrption: nil))
    
    _personList.append(PersonModel(personId: "10002", name: "Wilmer", lastName: "Diaz", imageProfile: "10002.jpg", totalThumbsUpCount: 100, totalThumbsDownCount: 20, otherDescrption: nil))
    
    _personList.append(PersonModel(personId: "10003", name: "Jay", lastName: "Robles", imageProfile: "10003.jpg", totalThumbsUpCount: 120, totalThumbsDownCount: 10, otherDescrption: nil))
    
    
    
    
    
    return _personList
   
    
}

func doSomething(flag:Bool, completionHandler: @escaping (Bool) -> Void ) {
    completionHandler(true)
}


func GetSinglePerson(person: @escaping (PersonModel) -> Void)
{
    //var _person = PersonModel(personId: "", name: "", lastName: "", imageProfile: "", totalThumbsUpCount: 0,)

    let url = NSURL(string: "http://192.168.8.100/VoteCasting.WebUI/home/GetRanDomPerson")
    
    //fetching the data from the url
    URLSession.shared.dataTask(with: (url as URL?)!, completionHandler: {(data, response, error) -> Void in
        
        if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
            
            //printing the json in console
            print(jsonObj!.value(forKey: "person")!)
            
            //getting the avengers tag array from json and converting it to NSArray
//            if let personArrary = jsonObj!.value(forKey: "person") as? NSArray {
//                //looping through all the elements
//                for person in personArrary{
            
                    //converting the element to a dictionary
                    if let perDict = jsonObj!.value(forKey: "person") as? NSDictionary {
                        
                        //getting the name from the dictionary
                       // if let name = perDict.value(forKey: "FirstName") {
                        
                        
                        let _person = PersonModel(personId: perDict.value(forKey: "PersonId") as! String,
                                                  name: perDict.value(forKey: "FirstName") as! String,
                                                  lastName: perDict.value(forKey: "LastName") as! String,
                                                  imageProfile: perDict.value(forKey: "ImageFileName") as? String,
                                                  totalThumbsUpCount: perDict.value(forKey: "TotalThumbsUpCount") as! Int,
                                                  totalThumbsDownCount: perDict.value(forKey: "TotalThumbsDownCount") as! Int,
                                                  otherDescrption: perDict.value(forKey: "OtherDescription") as? String)
                        
                        
                      person(_person)
                        
            }
            
            

        }
        
        
        
       
        
        
    }).resume()
    
    
    
    
}

func postPersonVote(personid: String, downup: VoteName, completed: @escaping (Bool) -> Void)
{
    //let url = NSURL(string: "http://192.168.8.100/VoteCasting.WebUI/home/GetRanDomPerson")
    
    let url = URL(string: "http://192.168.8.100/VoteCasting.WebUI/home/UpdatePersonVote")!
    var request = URLRequest(url: url)
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "POST"
    let postString = "personid=\(personid)&vote=\(downup.rawValue)"
    
    request.httpBody = postString.data(using: .utf8)
    
    let task = URLSession.shared.dataTask(with: request)
    { data, response, error in
        guard let data = data, error == nil else {
            // check for fundamental networking error
            print("error=\(error!)")
            return
        }
        
        if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
            print("statusCode should be 200, but is \(httpStatus.statusCode)")
            print("response = \(response!)")
        }
        
        let responseString = String(data: data, encoding: .utf8)
        
        print("responseString = \(responseString!)")
        
        completed(true)
    }
    
    
    
    task.resume()
}


func downloadImageFromURL(imageFileName: String, imageDataCompleted: @escaping (UIImage) -> Void)
    {
    
    let personURL = URL(string: "http://192.168.8.100/VoteCasting.WebUI/personImages/\(imageFileName)")
      //let personURL = URL(string: "http://192.168.8.100/VoteCasting.WebUI/PersonImages/1001.jpg")
        
        //print("\(personURL)")
        
    let session = URLSession(configuration: .default)
     
        let downloadPicTask = session.dataTask(with: personURL!) { (data, response, error
            ) in
            
            if let e = error
            {
                print("Error downloading person picture \(e)")
            }
            else
            {
                if let res = response as? HTTPURLResponse
                {
                    print("Downloaded person picuture with response code \(res.statusCode)")
                    
                    
                    if let imageData = data
                    {
                        let image = UIImage(data: imageData)
                        
                        imageDataCompleted(image!)
                        
                    }
                    else
                    {
                        print("Could not get image: Image is nil")
                    }
                }
                else
                {
                    print("Could get response code for some reason")
                }
            }
            
        }
        
        downloadPicTask.resume()
        
    }
