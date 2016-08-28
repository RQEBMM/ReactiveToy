//
//  Dealership.swift
//  ReactiveToy
//
//  Created by Avtar Khalsa on 8/26/16.
//  Copyright © 2016 AB. All rights reserved.
//

import Foundation
import Gloss

class Dealership {
    let name:String?
    let address:String?
    let latitude:Double?
    let longitude:Double?
    let id:String
    
    init(n:String, a:String, lat:Double, lng:Double, id:String){
        name = n
        address = a
        latitude = lat
        longitude = lng
        self.id = id
    }
    required init?(json: JSON, server_id:String) {
        self.name = "name" <~~ json
        self.address = "address" <~~ json
        self.latitude = "latitude" <~~ json
        self.longitude = "longitude" <~~ json
        self.id = server_id
        
    }
}