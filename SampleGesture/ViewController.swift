//
//  ViewController.swift
//  SampleGesture
//
//  Created by Van Ho Si on 9/27/17.
//  Copyright © 2017 Van Ho Si. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController, UIGestureRecognizerDelegate {

    var audioPlayer: AVAudioPlayer?
    var tagItem = 1000
    var imageChoose = UIImage(named: "1460541878_christmas_6.png")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //them anh nen chinh
//        self.addBackground()
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction(sender:)))
        tapGesture.numberOfTapsRequired = 1//so lan tap vao man hinh
        tapGesture.numberOfTouchesRequired = 1//so ngon tay cham vao man hinh
        self.view.addGestureRecognizer(tapGesture)
        
        self.playSong()
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func addBackground(){
        //anh nen chinh
        let bgMain = UIImageView(image: UIImage(named: "bgMain.png"))
        bgMain.contentMode = .scaleAspectFill
        bgMain.frame = self.view.bounds
        self.view.addSubview(bgMain)
        
        //anh cay thong
        let bgPine = UIImageView(image: UIImage(named: "BG.png"))
        bgPine.center = CGPoint(x: self.view.bounds.size.width * 0.5, y: self.view.bounds.size.height * 0.5)
        self.view.addSubview(bgPine)
    }
    
    @IBAction func actionClear(_ sender: UIButton) {
        
        for index in 1000...tagItem{
            let view = self.view.viewWithTag(index)
            view?.removeFromSuperview()
        }
        tagItem = 1000
    }
    
    
    @IBAction func actionItemChoose(_ sender: UIButton) {
        
        
        for index in 100...104{
            let view = self.view.viewWithTag(index)
            if(index == sender.tag){
                view?.alpha = 1
                imageChoose = sender.backgroundImage(for: .normal)!
                
            }else{
                view?.alpha = 0.6
            }
            
        }
        
        
        
        
    }
    
    
    
    @objc func panAction(sender: UIPanGestureRecognizer){
//        if(sender.state == .began){
//            print("pan began")
//        }else if(sender.state == .changed){
//            print("pan changed")
//        }else if(sender.state == .ended){
//            print("pan ended")
//        }
        
        if(sender.state != .failed && sender.state != .ended){
//            sender.view?.center = sender.location(in: sender.view?.superview)
            sender.view?.center = sender.location(in: self.view)
        }
    }
    
    
    
    @objc func tapAction(sender: UITapGestureRecognizer){
        
        let point = sender.location(in: self.view)
        let x = point.x
        let y = point.y
        
        self.addItem(x: x, y: y)
    }
    
    func addItem(x: CGFloat, y: CGFloat){
        print("addItem")
//        let imageView = UIImageView(image: UIImage(named: "1460541878_christmas_6.png"))
        let imageView = UIImageView(image: imageChoose)
        imageView.frame.size.width = 100
        imageView.frame.size.height = 113
        imageView.center = CGPoint(x: x, y: y)
        imageView.isUserInteractionEnabled = true
        imageView.isMultipleTouchEnabled = true
        tagItem = tagItem + 1
        imageView.tag = tagItem
        self.view.addSubview(imageView)
        
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(onPan(panGesture:)))
        imageView.addGestureRecognizer(panGesture)
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(onPinch(pinchGesture:)))
        imageView.addGestureRecognizer(pinchGesture)
        
        let rotateGesture = UIRotationGestureRecognizer(target: self, action: #selector(onRotate(rotateGesture:)))
        rotateGesture.delegate = self
        imageView.addGestureRecognizer(rotateGesture)
    }
    
    @objc func onPan(panGesture: UIPanGestureRecognizer){
//        print("onPan")
        if(panGesture.state == .began || panGesture.state == .changed){
            let point = panGesture.location(in: self.view)
            panGesture.view?.center = point
        }
    }
    
    @objc func onPinch(pinchGesture: UIPinchGestureRecognizer){
        if let view = pinchGesture.view{
            view.transform = view.transform.scaledBy(x: pinchGesture.scale, y: pinchGesture.scale)
            pinchGesture.scale = 1
        }
    }
    
    @objc func onRotate(rotateGesture: UIRotationGestureRecognizer){
        
        if let view = rotateGesture.view{
            view.transform = view.transform.rotated(by: rotateGesture.rotation)
            rotateGesture.rotation = 0
            
        }
    }
    
    func playSong(){
        let path = Bundle.main.path(forResource: "Jingle Bells - Christmas Carol.mp3", ofType: nil)!
        let url = URL(fileURLWithPath: path)
        
        audioPlayer = try! AVAudioPlayer(contentsOf: url)
        audioPlayer?.numberOfLoops = -1
        audioPlayer?.prepareToPlay()
        audioPlayer?.play()
    }
    
    
}

