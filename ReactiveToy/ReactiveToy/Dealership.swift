//
//  Dealership.swift
//  ReactiveToy
//
//  Created by Avtar Khalsa on 8/26/16.
//  Copyright © 2016 AB. All rights reserved.
//

import Foundation
class Dealership{
    var name:String
    var address:String
    var latitude:Double
    var longitude:Double
    
    init(n:String, a:String, lat:Double, lng:Double){
        name = n
        address = a
        latitude = lat
        longitude = lng
    }
}