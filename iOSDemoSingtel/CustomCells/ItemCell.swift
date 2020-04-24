//
//  ItemCell.swift
//  iOSDemoSingtel
//
//  Created by Sandeep Mukherjee on 24/04/20.
//  Copyright © 2020 Sandeep Mukherjee. All rights reserved.
//

import UIKit

class ItemCell: UICollectionViewCell {
    
    @IBOutlet weak var textLabel: UILabel!
    var flipped : Bool = false
    var flippedColor = UIColor( red: CGFloat(0/255.0), green: CGFloat(164/255.0), blue: CGFloat(237/255.0), alpha: CGFloat(1.0) )
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor =  self.flippedColor
        self.backgroundColor = UIColor.clear
        self.contentView.layer.cornerRadius = 5.0
        self.contentView.layer.borderColor = UIColor.white.cgColor
        self.contentView.layer.borderWidth = 4.0
        self.textLabel.alpha = 0
        // Initialization code
    }
    func setFlip(isFlipped:Bool)
    {
        self.flipped = isFlipped
    }
    func setData(text: String) {
        self.textLabel.text = text
        
    }
    
    func forceFlip()
    {
        let transitionOptions = UIView.AnimationOptions.transitionFlipFromRight
        self.textLabel.alpha = 0
        self.alpha = 0.9
        
        UIView.transition(with: self.contentView, duration: 0.5, options: transitionOptions, animations: {
            self.alpha = 0.3
            self.contentView.backgroundColor = self.flippedColor
            
        }, completion: { finished in
            self.alpha = 1.0
            self.flipped = false
        })
    }
    
    func flip() {
        if(!self.flipped){
            self.alpha = 0.9
            let transitionOptions = UIView.AnimationOptions.transitionFlipFromLeft
            UIView.transition(with: self.contentView, duration: 0.5, options: transitionOptions, animations: {
                self.alpha = 0.3
                self.textLabel.alpha = 1
                self.contentView.backgroundColor =  UIColor.white
                
                
            }, completion: { finished in
                self.alpha = 1.0
                self.flipped = true
            })
        }
        else {
            let transitionOptions = UIView.AnimationOptions.transitionFlipFromRight
            self.textLabel.alpha = 0
            self.alpha = 0.9
            UIView.transition(with: self.contentView, duration: 0.5, options: transitionOptions, animations: {
                self.alpha = 0.3
                self.contentView.backgroundColor = self.flippedColor
                
            }, completion: { finished in
                self.alpha = 1.0
                self.flipped = false
            })
            
        }
    }
}
