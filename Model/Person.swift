//
//  Person.swift
//  BlackRamen
//
//  Created by LinuxPlus on 8/29/18.
//  Copyright © 2018 private. All rights reserved.
//

import Foundation

enum VoteName: String {
    case UpVote = "UpVote"
    case DownVote = "DownVote"
}


struct PersonModel {
    
    var personId: String
    var name: String
    var lastName: String
    var imageProfile: String?
    var totalThumbsUpCount: Int = 0
    var totalThumbsDownCount: Int = 0
    var otherDescrption: String?
    
    var fullName : String
    {
        get
        {
            return "\(name) \(lastName)"
            
        }
    }
    
}
