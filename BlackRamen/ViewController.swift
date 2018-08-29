//
//  ViewController.swift
//  BlackRamen
//
//  Created by LinuxPlus on 8/29/18.
//  Copyright © 2018 private. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var _curPerson: PersonModel!
    
    @IBOutlet weak var stkView1: UIStackView!
    @IBOutlet weak var xView: UIView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblPersonName: UILabel!
    
    @IBOutlet weak var lblUpVoteTotal: UILabel!
    
    @IBOutlet weak var lblDownVoteTotal: UILabel!
    
    
    @IBOutlet weak var lblOtherDescription: UILabel!
    
    @IBAction func btnUpVote(_ sender: Any) {
    
        let yesAction = UIAlertAction(title: "Yes Up Vote", style: .destructive) { (action) in
        
            print("You click Yes button")
            
            postPersonVote(personid: self._curPerson.personId  , downup: .UpVote , completed: { (mybool) in
                
                print("\(mybool)")
                
                GetSinglePerson(person: { person in
                    
                    self._curPerson = person
                    
                    self.populatePersonInfo(person: self._curPerson)

                })
            })
            
        }
        
        let noAction = UIAlertAction(title: "Cancel", style: .default) { (action) in
            
            print("You click No button")
            
        }
        
        let alertController = UIAlertController(title: "Up Vote Confirmation", message: "Are you sure you want to Up Vote this person, you may not able to counter vote him / her for today?", preferredStyle: .alert)
        
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        
        //presentationController(alertController, animated: true, completion: nil)
        
        present(alertController, animated: true, completion: nil)
        
    
    }
    
    @IBAction func btnDownVote(_ sender: Any) {
    
        let yesAction = UIAlertAction(title: "Down Vote!", style: .destructive) { (action) in
            
            print("You click downvote button")
            
            
            postPersonVote(personid: self._curPerson.personId  , downup: .DownVote , completed: { (mybool) in
                
                print("\(mybool)")
                
                GetSinglePerson(person: { person in
                    
                    self._curPerson = person
                    
                    self.populatePersonInfo(person: self._curPerson)
                    
                    
                })
            })
            
            
            
            
            
            
            
            
        }
        
        let noAction = UIAlertAction(title: "Cancel", style: .default) { (action) in
            
            print("You click No button")
            
        }
        
        let alertController = UIAlertController(title: "Down Vote Confirmation", message: "Are you sure you want to Down Vote this person", preferredStyle: .alert)
        
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        
        //presentationController(alertController, animated: true, completion: nil)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        GetSinglePerson(person: { person in
            
            
            self._curPerson = person
            
            self.populatePersonInfo(person: self._curPerson)
            
            
            })
        
       
        
        
        
        
//        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
//        backgroundImage.image = UIImage(named: "bg1")
//        backgroundImage.contentMode =  UIViewContentMode.scaleAspectFill
//        self.stkView1.insertSubview(backgroundImage, at: 0)
//
        
        
        
    }
    
    func populatePersonInfo(person: PersonModel
        ) -> Void {
        
        DispatchQueue.main.async
            {
//                self.imgProfile.layer.borderWidth = 2
//                self.imgProfile.layer.masksToBounds = false
//                self.imgProfile.layer.borderColor = UIColor.gray.cgColor
                
                print("\(self.imgProfile.frame.height)")
                print("\(self.imgProfile.frame.width)")
                
//                self.imgProfile.layer.cornerRadius = self.imgProfile.frame.height / 2
//                self.imgProfile.clipsToBounds = true
                
                self.lblPersonName.text = person.fullName
                
                self.lblUpVoteTotal.text = String(person.totalThumbsUpCount)
                
                self.lblDownVoteTotal.text = String(person.totalThumbsDownCount)
                
                
                //self.viewDidLoad()
                //self.viewWillAppear(true)
                
                self.viewWillAppear(true)
                
        }
    }
        
        


    
    //var _currentPerson = GetPersonList().first(where: {$0.personId == "10002"})
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    
        
    
    }


}

