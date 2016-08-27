//
//  Car.swift
//  ReactiveToy
//
//  Created by Avtar Khalsa on 8/26/16.
//  Copyright © 2016 AB. All rights reserved.
//

import Foundation
class Car{
    var vin:String
    var exteriorColor:String
    var interiorColor:String
    var trimId:String
    var dealershipId:String
    var trim:Trim?
    var dealership:Dealership?
    
    init(v:String, e:String, i:String, tid:String, did:String){
        vin = v
        exteriorColor = e
        interiorColor = i
        trimId = tid
        dealershipId = did
    }
}