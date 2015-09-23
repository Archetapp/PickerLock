//
//  CGFloatExtension.swift
//  PickerLock
//
//  Created by Jared Davidson on 9/22/15.
//  Copyright © 2015 Archetapp. All rights reserved.
//

import Foundation
import CoreGraphics

public extension CGFloat{
    
    public static func random() -> CGFloat{
        
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    public static func random(min min : CGFloat, max : CGFloat) -> CGFloat{
        
        return CGFloat.random() * (max - min) + min
    }
    
}