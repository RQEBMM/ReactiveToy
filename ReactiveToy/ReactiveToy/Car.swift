//
//  Car.swift
//  ReactiveToy
//
//  Created by Avtar Khalsa on 8/26/16.
//  Copyright © 2016 AB. All rights reserved.
//

import Foundation
class Car {
    
    var vin:String
    var model:String
    var trimId:String
    var dealershipId:String
    
    var trim:Trim?
    var dealership:Dealership?
    
    init(v:String, m:String, tid:String, did:String) {

        vin = v
        model = m
        trimId = tid
        dealershipId = did
    }
    
}