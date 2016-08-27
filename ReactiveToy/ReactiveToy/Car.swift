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
    
    init(aVin:String, aModel:String, aTrimId:String, aDealershipId:String) {
        vin = aVin
        model = aModel
        trimId = aTrimId
        dealershipId = aDealershipId
    }
    
}