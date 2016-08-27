//
//  Trim.swift
//  ReactiveToy
//
//  Created by Avtar Khalsa on 8/26/16.
//  Copyright © 2016 AB. All rights reserved.
//

import Foundation

class Trim{
    var msrp:Double
    var engine:String
    var gasMileage:Double
    var name:String
    
    init(m:Double, e:String, mpg:Double, n:String ){
        msrp = m
        engine = e
        gasMileage = mpg
        name = n 
    }
}