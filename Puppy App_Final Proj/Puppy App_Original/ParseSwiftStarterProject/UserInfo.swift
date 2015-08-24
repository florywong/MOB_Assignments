//
//  UserInfo.swift
//  Puppy App
//
//  Created by Flora Wong on 8/8/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation
import Parse

class UserInfo {
    
    var email:String = ""
    var password:String = ""
    
    //coordinates of marked location
    var coordinates: PFGeoPoint = PFGeoPoint()
    
    //coordinates of current location fetched from parse
    var currentLocPoint: PFGeoPoint = PFGeoPoint()
}
