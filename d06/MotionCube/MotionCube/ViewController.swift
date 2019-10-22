//
//  ViewController.swift
//  MotionCube
//
//  Created by Ryan de Kwaadsteniet on 10/16/19.
//  Copyright © 2019 Ryan de Kwaadsteniet. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    var animator: UIDynamicAnimator?
    let motionManager = CMMotionManager()
    var gravity = UIGravityBehavior()
    var direction = CGVector()
    var boundries = UICollisionBehavior()
    var elesticity = UIDynamicItemBehavior()
    
    var shapes: [Shape] = []
    var selected: Shape? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = true
        
        setupAnimator()
        instantiateGestures()
    }
    
    func setupAnimator() {
        animator = UIDynamicAnimator(referenceView: self.view)
        direction = CGVector(dx: 0.0, dy: 1.0)
        gravity.gravityDirection = direction
        boundries.translatesReferenceBoundsIntoBoundary = true
        elesticity.elasticity = 0.5
        animator?.addBehavior(elesticity)
        animator?.addBehavior(boundries)
        animator?.addBehavior(gravity)
    }

    // Gesture Recogniser Functions //
    func instantiateGestures() {
        let tapShape = UITapGestureRecognizer(target: self, action: #selector(ViewController.tap))
        view.addGestureRecognizer(tapShape)
        let panShape = UIPanGestureRecognizer(target: self, action: #selector(ViewController.pan(_:)))
        view.addGestureRecognizer(panShape)
        let pinchShape = UIPinchGestureRecognizer(target: self, action: #selector(ViewController.pinch(_:)))
        view.addGestureRecognizer(pinchShape)
        let rotShape = UIRotationGestureRecognizer(target: self, action: #selector(ViewController.rot(_:)))
        view.addGestureRecognizer(rotShape)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if motionManager.isAccelerometerAvailable {
            motionManager.deviceMotionUpdateInterval = 0.01
            motionManager.startDeviceMotionUpdates(to: OperationQueue.main) { (data, error) in
            guard let data = data, error == nil else {
                return
            }
                let grav : CMAcceleration = data.gravity;
                
                let x = CGFloat(grav.x)
                let y = CGFloat(grav.y) * -1
                let v = CGVector(dx: x,dy: y)
                self.gravity.gravityDirection = v
            }
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        motionManager.stopDeviceMotionUpdates()
    }
    
    @objc func tap(_ sender: UIGestureRecognizer) {
        if sender.state == .ended {
            let shape = Shape()
            shape.translatesAutoresizingMaskIntoConstraints = true
            shape.bounds.size = CGSize(width: 100, height: 100)
            shape.center = sender.location(in: self.view)
            self.view.addSubview(shape)
            shapes.append(shape)
            boundries.addItem(shape)
            gravity.addItem(shape)
            elesticity.addItem(shape)
        }
    }
    
    @objc func pan(_ sender: UIPanGestureRecognizer) {
        if sender.state == .began {
            let touchLocation = sender.location(in: self.view)
            for shape in shapes {
                if (shape.layer.presentation()?.frame.contains(touchLocation))! {
                    selected = shape
                    break
                }
            }
            if selected != nil {
                gravity.removeItem(selected!)
                self.view.bringSubviewToFront(selected!)
            }
        } else if sender.state == .changed {
            if selected != nil {
                selected!.center = sender.location(in: self.view)
                animator?.updateItem(usingCurrentState: selected!)
            }
        } else {
            if selected != nil {
                gravity.addItem(selected!)
                selected = nil
            }
        }
    }
    
    @objc func pinch(_ sender: UIPinchGestureRecognizer) {
        var lastdist: CGFloat = 1
        if sender.state == .began {
            let touchLocation = sender.location(in: self.view)
            for shape in shapes {
                if (shape.layer.presentation()?.frame.contains(touchLocation))! {
                    selected = shape
                    break
                }
            }
            if selected != nil {
                gravity.removeItem(selected!)
                self.view.bringSubviewToFront(selected!)
                lastdist = sender.scale
            }
        } else if sender.state == .changed {
            if selected != nil {
                boundries.removeItem(selected!)
                //bug in UIDynamicBehavior
                //https://stackoverflow.com/questions/20631383/uidynamicitem-update-transform-manually
                //shapes.remove(at: shapes.firstIndex(of: selected!)!)
                selected!.bounds.size = CGSize(width: 100*(sender.scale/lastdist), height: 100*(sender.scale/lastdist))
                //shapes.append(selected!)
                animator?.updateItem(usingCurrentState: selected!)
                boundries.addItem(selected!)
            }
        } else {
            if selected != nil {
                gravity.addItem(selected!)
                selected = nil
            }
        }
    }
    
    @objc func rot(_ sender: UIRotationGestureRecognizer) {
        if sender.state == .began {
            let touchLocation = sender.location(in: self.view)
            for shape in shapes {
                if (shape.layer.presentation()?.frame.contains(touchLocation))! {
                    selected = shape
                    break
                }
            }
            if selected != nil {
                gravity.removeItem(selected!)
                self.view.bringSubviewToFront(selected!)
            }
        } else if sender.state == .changed {
            if selected != nil {
                selected!.transform = selected!.transform.rotated(by: sender.rotation)
                animator?.updateItem(usingCurrentState: selected!)
                sender.rotation = 0
            }
        } else {
            if selected != nil {
                gravity.addItem(selected!)
                selected = nil
            }
        }
    }
}

