//
//  CardViewModel.swift
//  TinderFirestore
//
//  Created by Jonathan Go on 2018/12/29.
//  Copyright © 2018 Appdelight. All rights reserved.
//

import UIKit

protocol ProducesCardViewModel {
  //associatedtype ModelData
  //associatedtype Advertiser
  static func userToCardViewModel(user: User) -> CardViewModel
  static func advertiserToCardViewModel(advertiser: Advertiser) -> CardViewModel
}

class CardViewModel: ProducesCardViewModel {

  //properties that our card will display/render out
  let imageNames: [String]
  let attributedString: NSAttributedString
  let textAlignment: NSTextAlignment
  
  init(imageNames: [String], attributedString: NSAttributedString, textAlignment: NSTextAlignment) {
    self.imageNames = imageNames
    self.attributedString = attributedString
    self.textAlignment = textAlignment
  }

  fileprivate var imageIndex = 0 {
    didSet {
      let imageName = imageNames[imageIndex]
      let image = UIImage(named: imageName)
      imageIndexObserver?(imageIndex, image)
    }
  }
  
  //reactive programming
  var imageIndexObserver: ((Int, UIImage?) -> ())?
  
  func advanceToNextPhoto() {
    imageIndex = min(imageIndex + 1, imageNames.count - 1)
  }
  
  func goToPreviousPhoto() {
    imageIndex = max(0, imageIndex - 1)
  }
  
  static func userToCardViewModel(user: User) -> CardViewModel {
    let attributedText = NSMutableAttributedString(string: user.name, attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy)])
    attributedText.append(NSAttributedString(string: " \(user.age)", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .regular)]))
    attributedText.append(NSAttributedString(string: "\n\(user.profession)", attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .regular)]))
    
    return CardViewModel(imageNames: user.imageNames, attributedString: attributedText, textAlignment: .left)
  }
  
  static func advertiserToCardViewModel(advertiser: Advertiser) -> CardViewModel {
    let attributedText = NSMutableAttributedString(string: advertiser.title, attributes: [.font: UIFont.systemFont(ofSize: 34, weight: .heavy)])
    attributedText.append(NSAttributedString(string: "\n\(advertiser.brandName)", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .bold)]))
    
    return CardViewModel(imageNames: [advertiser.posterPhotoName], attributedString: attributedText, textAlignment: .center)
  }
}

