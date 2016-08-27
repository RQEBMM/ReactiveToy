//
//  Trim.swift
//  ReactiveToy
//
//  Created by Avtar Khalsa on 8/26/16.
//  Copyright © 2016 AB. All rights reserved.
//

import Foundation
import Gloss
class Trim:Decodable{
    var msrp:Double?
    var engine:String?
    var gasMileage:Double?
    var name:String?
    
    init(m:Double, e:String, mpg:Double, n:String ){
        msrp = m
        engine = e
        gasMileage = mpg
        name = n 
    }
    required init?(json: JSON) {
        self.msrp = "msrp" <~~ json
        self.engine = "engine" <~~ json
        self.gasMileage = "mpg" <~~ json
        self.name = "name" <~~ json
        
        
    }
}