//
//  Item.swift
//  SampleGesture
//
//  Created by Van Ho Si on 9/29/17.
//  Copyright © 2017 Van Ho Si. All rights reserved.
//

import Foundation
import UIKit

class Item: UIImageView, UIGestureRecognizerDelegate{
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.setup()
    }
    
    func setup(){
        self.isUserInteractionEnabled = true
        self.isMultipleTouchEnabled = true
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(onPan(panGesture:)))
        self.addGestureRecognizer(panGesture)
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(onPinch(pinchGesture:)))
        self.addGestureRecognizer(pinchGesture)
        
        let rotateGesture = UIRotationGestureRecognizer(target: self, action: #selector(onRotate(rotateGesture:)))
        rotateGesture.delegate = self
        self.addGestureRecognizer(rotateGesture)
    }
    
    
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    @objc func onPan(panGesture: UIPanGestureRecognizer){
        if(panGesture.state == .began || panGesture.state == .changed){
            let point = panGesture.location(in: self.superview)
            self.center = point
        }
    }
    
    @objc func onPinch(pinchGesture: UIPinchGestureRecognizer){
//        print("pinchGesture")
        if let view = pinchGesture.view{
//            view.transform = CGAffineTransform.init(scaleX: pinchGesture.scale, y: pinchGesture.scale)
            
            view.transform = view.transform.scaledBy(x: pinchGesture.scale, y: pinchGesture.scale)
            pinchGesture.scale = 1
        }
    }
    
    @objc func onRotate(rotateGesture: UIRotationGestureRecognizer){
//        print("onRotate")
        if let view = rotateGesture.view{
//            view.transform = CGAffineTransform.init(rotationAngle: rotateGesture.rotation)
            
            view.transform = view.transform.rotated(by: rotateGesture.rotation)
            rotateGesture.rotation = 0
            
        }
    }
    
    func addItem(width: CGFloat, height: CGFloat, positionX: CGFloat, positionY: CGFloat){
        self.image = UIImage(named: "snowflake.png")
        self.frame.size.width = width
        self.frame.size.height = height


        self.center = CGPoint(x: positionX, y: positionY)
        self.superview?.addSubview(self)
        
    }
    
}
