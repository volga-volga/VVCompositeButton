//
//  CompositeButton.swift
//  Composite Button
//
//  Created by  Kostantin Zarubin on 10/12/2018.
//  Copyright © 2018  Kostantin Zarubin. All rights reserved.
//

import UIKit

protocol CompositeButtonDelegate: class {
    func firstButtonSelected()
    func secondButtonSelected()
    func thirdButtonSelected()
}

@IBDesignable public class CompositeButton: UIButton {
    var firstButton: CompositeButton?
    var secondButton: CompositeButton?
    var thirdButton: CompositeButton?
    weak var delegate: CompositeButtonDelegate?
    
    @IBInspectable var cornerRadius: CGFloat = 20 {
        didSet {
            refreshCorners(value: cornerRadius)
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 2 {
        didSet {
            refreshBorder(borderWidth: borderWidth)
        }
    }
    
    @IBInspectable var customBorderColor: UIColor = UIColor.init (red: 0, green: 122/255, blue: 255/255, alpha: 1){
        didSet {
            refreshBorderColor(colorBorder: customBorderColor)
        }
    }
    
    func refreshBorder(borderWidth: CGFloat) {
        layer.borderWidth = borderWidth
    }
    
    func refreshBorderColor(colorBorder: UIColor) {
        layer.borderColor = colorBorder.cgColor
    }
    
    func refreshCorners(value: CGFloat) {
        layer.cornerRadius = value
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.blue
        sharedInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    override func prepareForInterfaceBuilder() {
        sharedInit()
    }
    
    func sharedInit() {
        refreshCorners(value: cornerRadius)
        refreshBorderColor(colorBorder: customBorderColor)
        refreshBorder(borderWidth: borderWidth)
    }
    
    override open var isHighlighted: Bool {
        didSet {
            
            if isHighlighted {
                if isSelected {
                    UIView.animate(withDuration: 0.1) {
                        self.backgroundColor = UIColor(red: 0, green: 122/255, blue: 255/255, alpha: 0.3)
                    }
                } else {
                    UIView.animate(withDuration: 0.1) {
                        self.backgroundColor = UIColor(red: 0, green: 122/255, blue: 255/255, alpha: 0.8)
                    }
                }
            }
            else {
                UIView.animate(withDuration: 0.1) {
                    self.backgroundColor = UIColor(red: 0, green: 122/255, blue: 255/255, alpha: 1)
                }
            }
        }
    }
    
    @IBInspectable open var animatedScaleWhenSelected: CGFloat = 1.5
    @IBInspectable open var animatedScaleDurationWhenSelected: Double = 0.2
    
    override open var isSelected: Bool {
        didSet {
            guard animatedScaleWhenSelected != 1.0 else { return }
            
            UIView.animate(withDuration: animatedScaleDurationWhenSelected, animations: {
                self.transform = CGAffineTransform(scaleX: self.animatedScaleWhenSelected, y: self.animatedScaleWhenSelected)
            }) { (finished) in
                UIView.animate(withDuration: self.animatedScaleDurationWhenSelected, animations: {
                    self.transform = CGAffineTransform.identity
                    if self.isSelected {
                        UIView.animate(withDuration: 0.1) {
                            self.backgroundColor = UIColor.white
                        }
                        self.refreshBorderColor(colorBorder: UIColor.gray)
                    } else {
                        UIView.animate(withDuration: 0.1) {
                            self.backgroundColor = UIColor(red: 0, green: 122/255, blue: 255/255, alpha: 1)
                        }
                        self.refreshBorderColor(colorBorder: self.customBorderColor)
                    }
                })
            }
        }
    }
    
    @IBInspectable open var selectedState: Bool = false {
        didSet {
            if selectedState == true {
                self.setImage(unselectedImage, for: .normal)
                self.setImage(selectedImage, for: .selected)
                self.addTarget(self, action: #selector(buttonSelected), for: .touchUpInside)
            }
        }
    }
    
    @IBInspectable open var selectedImage: UIImage?
    @IBInspectable open var unselectedImage: UIImage?
    
    @objc func buttonSelected(sender:AnyObject) {
        self.isSelected = !self.isSelected
        if isSelected {
            addButtons()
            UIView.animate(withDuration: 0.25) {
                self.firstButton?.alpha = 1
                self.firstButton?.center.x = self.center.x-100
                self.secondButton?.alpha = 1
                self.secondButton?.center.x = self.center.x-70
                self.secondButton?.center.y = self.center.y-70
                self.thirdButton?.alpha = 1
                self.thirdButton?.center.y = self.center.y-100
            }
        } else {
            removeButtons()
        }
        
        if #available(iOS 10.0, *) {
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        }
    }
    
    //MARK:- Configure additional Buttons
    @IBInspectable open var firstButtonImage: UIImage?
    @IBInspectable open var secondButtonImage: UIImage?
    @IBInspectable open var thirdButtonImage: UIImage?
    
    func addButtons() {
        firstButton = CompositeButton(frame: CGRect(x: self.center.x, y: self.center.y-20, width: 40, height: 40))
        firstButton?.alpha = 0
        firstButton?.setImage(firstButtonImage, for: .normal)
        firstButton!.backgroundColor = UIColor(red: 0, green: 122/255, blue: 255/255, alpha: 1)
        firstButton!.addTarget(self, action: #selector(firstButtonAction), for: .touchUpInside)
        
        self.superview?.addSubview(firstButton!)
        
        secondButton = CompositeButton(frame: CGRect(x: self.center.x-20, y: self.center.y, width: 40, height: 40))
        secondButton?.alpha = 0
        secondButton?.setImage(secondButtonImage, for: .normal)
        secondButton!.backgroundColor = UIColor(red: 0, green: 122/255, blue: 255/255, alpha: 1)
        secondButton!.addTarget(self, action: #selector(secondButtonAction), for: .touchUpInside)
        
        self.superview?.addSubview(secondButton!)
        
        thirdButton = CompositeButton(frame: CGRect(x: self.center.x-20, y: self.center.y-20, width: 40, height: 40))
        thirdButton?.alpha = 0
        thirdButton?.setImage(thirdButtonImage, for: .normal)
        thirdButton!.backgroundColor = UIColor(red: 0, green: 122/255, blue: 255/255, alpha: 1)
        thirdButton!.addTarget(self, action: #selector(thirdButtonAction), for: .touchUpInside)
        
        self.superview?.addSubview(thirdButton!)
    }
    
    @objc func firstButtonAction(sender: UIButton!) {
        delegate?.firstButtonSelected()
    }
    
    @objc func secondButtonAction(sender: UIButton!) {
        delegate?.secondButtonSelected()
    }
    
    @objc func thirdButtonAction(sender: UIButton!) {
        delegate?.thirdButtonSelected()
    }
    
    func removeButtons() {
        UIView.animate(withDuration: 0.25, animations: {
            self.firstButton?.alpha = 0
            self.firstButton?.center.x = self.center.x
            self.secondButton?.alpha = 0
            self.secondButton?.center.x = self.center.x
            self.secondButton?.center.y = self.center.y-20
            self.thirdButton?.alpha = 0
            self.thirdButton?.center.y = self.center.y
        }, completion: { _ in
            self.firstButton?.removeFromSuperview()
        })
    }
}

