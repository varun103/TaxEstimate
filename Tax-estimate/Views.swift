//
//  Views.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 3/9/17.
//  Copyright © 2017 Varun Ajmera. All rights reserved.
//

import UIKit


class Views:UIView {
    
    func drawLine() -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 5.0, y:250.0))
        path.addLine(to: CGPoint(x: 400.0, y: 250.0))
        path.close()
        path.stroke()
        path.fill()
        
       return path
    }

}
