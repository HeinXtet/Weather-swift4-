//
//  GradientView.swift
//  Weather
//
//  Created by HeinHtet on 9/15/18.
//  Copyright © 2018 HeinHtet. All rights reserved.
//

import UIKit

@IBDesignable
class GradientView: UIView {
    
    @IBInspectable var topColor :UIColor = #colorLiteral(red: 0.262745098, green: 0.6745098039, blue: 0.7882352941, alpha: 1){
        didSet{
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var BottompColor :UIColor = #colorLiteral(red: 0.4509803922, green: 0.7607843137, blue: 0.8431372549, alpha: 1){
        didSet{
            self.setNeedsLayout()
        }
    }
    
    override func layoutSubviews() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor,BottompColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1 ,y: 1)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
    
}
