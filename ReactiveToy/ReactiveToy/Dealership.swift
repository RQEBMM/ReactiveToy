//
//  Dealership.swift
//  ReactiveToy
//
//  Created by Avtar Khalsa on 8/26/16.
//  Copyright © 2016 AB. All rights reserved.
//

import Foundation
import Gloss

class Dealership: Decodable {
    let name:String?
    let address:String?
    let latitude:Double?
    let longitude:Double?
    
    init(n:String, a:String, lat:Double, lng:Double){
        name = n
        address = a
        latitude = lat
        longitude = lng
    }
    required init?(json: JSON) {
        self.name = "name" <~~ json
        self.address = "address" <~~ json
        self.latitude = "latitude" <~~ json
        self.longitude = "longitude" <~~ json
        
        
    }
}