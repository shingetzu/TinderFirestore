//
//  CustomTextField.swift
//  TinderFirestore
//
//  Created by Jonathan Go on 2019/01/09.
//  Copyright © 2019 Appdelight. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
  let padding: CGFloat
  let height: CGFloat
  
  init(padding: CGFloat, height: CGFloat) {
    self.padding = padding
    self.height = height
    super.init(frame: .zero)
    layer.cornerRadius = height / 2
    
  }
  
  override func textRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.insetBy(dx: padding, dy: 0)
  }
  
  override func editingRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.insetBy(dx: padding, dy: 0)
  }
  override var intrinsicContentSize: CGSize {
    return .init(width: 0, height: height)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

