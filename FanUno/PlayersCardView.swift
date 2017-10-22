//
//  PlayersCardViewController.swift
//  FanUno
//
//  Created by Rekha Manju Kiran on 21/10/2017.
//  Copyright © 2017 Rekha Manju Kiran. All rights reserved.
//

import UIKit
import Foundation
import SDWebImage
import Koloda

class PlayersCardView: UIView {
    
    @IBOutlet weak var leftChoicePlayerView : UIView!
    @IBOutlet weak var leftChoicePlayerImageView : UIImageView!
    @IBOutlet weak var leftChoicePlayerName : UILabel!
    
    @IBOutlet weak var rightChoicePlayerView : UIView!
    @IBOutlet weak var rightChoicePlayerImageView : UIImageView!
    @IBOutlet weak var rightChoicePlayerName : UILabel!
    
    @IBOutlet weak var leftWidthConstraint : NSLayoutConstraint!
    @IBOutlet weak var stackView : UIStackView!
    @IBOutlet weak var stackViewTopMargin : NSLayoutConstraint!

    weak var leftPlayer:Player!
    weak var rightPlayer:Player!
    
    func configureViewWith(leftPlayer : Player, rightPlayer: Player){
        if let leftPlayerImageURL = leftPlayer.imageUrl.first?.url {
            if let url = URL(string: leftPlayerImageURL) {
                self.leftChoicePlayerImageView.sd_setImage(with: url, completed:nil)
            }
        }
        self.leftChoicePlayerName.text = leftPlayer.firstName + " " + leftPlayer.lastName
        
        if let rightPlayerImageURL = rightPlayer.imageUrl.first?.url{
            if let url = URL(string: rightPlayerImageURL) {
                self.rightChoicePlayerImageView.sd_setImage(with: url, completed:nil)
            }
        }
        self.rightChoicePlayerName.text = rightPlayer.firstName + " " + rightPlayer.lastName

        self.updateLabelWithShadow(label: self.leftChoicePlayerName, color: UIColor.white, radius: 1.0)
        self.updateLabelWithShadow(label: self.rightChoicePlayerName, color: UIColor.white, radius: 1.0)
        
    }
    
    func updateViewProportions(factor : CGFloat, choice: SwipeResultDirection){
        var realFactor:CGFloat
        if(factor == 1)
        {
           realFactor = (choice == .left) ? (1-0.99) : 1/(1-0.99)
        }else{
            realFactor = (choice == .left) ? (1-factor) : 1/(1-factor)
        }
        self.leftWidthConstraint = self.leftWidthConstraint.setMultiplier(multiplier: CGFloat(realFactor))
    }

    func updateLabelWithShadow(label: UILabel, color: UIColor, radius:Double)
    {
        label.layer.shadowOpacity = 1.0
        label.layer.shadowRadius = CGFloat(radius);
        label.layer.shadowColor = color.cgColor;
        label.layer.shadowOffset = CGSize.init(width: 0.0, height: -1.0)

    }
}
