//
//  Car.swift
//  ReactiveToy
//
//  Created by Avtar Khalsa on 8/26/16.
//  Copyright © 2016 AB. All rights reserved.
//

import Foundation
import Gloss


class Car {
    
    var vin:String?
    var model:String?
    var trimId:String?
    var dealershipId:String?
    
    var trim:Trim?
    var dealership:Dealership?
    
    init(v:String, m:String, tid:String, did:String) {
        vin = v
        model = m
        trimId = tid
        dealershipId = did
    }
    
    required init?(json: JSON) {
        self.vin = "vin" <~~ json
        self.model = "model" <~~ json
        self.trimId = "trim_id" <~~ json
        self.dealershipId = "dealership_id" <~~ json
    }
    
}