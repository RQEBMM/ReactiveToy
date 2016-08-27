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
    var id:String
    
    var trim:Trim?
    var dealership:Dealership?
    
    init(v:String, m:String, tid:String, did:String, server_id:String) {
        vin = v
        model = m
        trimId = tid
        dealershipId = did
        self.id = server_id
    }
    
    required init?(json: JSON, server_id:String) {
        self.vin = "vin" <~~ json
        self.model = "model" <~~ json
        self.trimId = "trim_id" <~~ json
        self.dealershipId = "dealership_id" <~~ json
        self.id = server_id
        
    }
    
}