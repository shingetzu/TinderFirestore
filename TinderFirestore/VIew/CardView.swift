//
//  CardView.swift
//  TinderFirestore
//
//  Created by Jonathan Go on 2018/12/28.
//  Copyright © 2018 Appdelight. All rights reserved.
//

import UIKit

class CardView: UIView {

  fileprivate let imageView = UIImageView(image: #imageLiteral(resourceName: "lady5c").withRenderingMode(.alwaysOriginal))
  
  //Configurations
  fileprivate let threshold: CGFloat = 80
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    //backgroundColor = .red
    layer.cornerRadius = 10
    clipsToBounds = true
    
    addSubview(imageView)
    imageView.fillSuperview()
    
    let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
    addGestureRecognizer(panGesture)
    
  }
  
  @objc fileprivate func handlePan(gesture: UIPanGestureRecognizer) {
    switch gesture.state {
    case .changed:
      handleChanged(gesture)
    case .ended:
      handleEnded(gesture)
    default:
      ()
    }
  }
  
  fileprivate func handleChanged(_ gesture: UIPanGestureRecognizer) {
    
    let translation = gesture.translation(in: nil)
    
    //rotation
    let degrees: CGFloat = translation.x / 20
    let angle = degrees * .pi / 180
    
    let rotationTransformation = CGAffineTransform(rotationAngle: angle)
    self.transform = rotationTransformation.translatedBy(x: translation.x, y: translation.y)
    
    //self.transform = CGAffineTransform(translationX: translation.x, y: translation.y)
  }
  
  fileprivate func handleEnded(_ gesture: UIPanGestureRecognizer) {
    let translationDirection: CGFloat = gesture.translation(in: nil).x > 0 ? 1 : -1
    let shouldDismissCard = abs(gesture.translation(in: nil).x) > threshold
    
    UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
      if shouldDismissCard {
        self.frame = CGRect(x: 1000 * translationDirection, y: 0, width: self.frame.width, height: self.frame.height)
//        self.transform = offScreenTransform
      } else {
        self.transform = .identity
      }
    }) { (_) in
      self.transform = .identity
      self.frame = CGRect(x: 0, y: 0, width: self.superview!.frame.width, height: self.superview!.frame.height)
    }
  }
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
