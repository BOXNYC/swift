//
//  Designables.swift
//  Designables
//
//  Created by Joseph Weitzel on 2/6/17.
//  Copyright © 2017 Joseph Weitzel. All rights reserved.
//

import Foundation
import UIKit

// Expanding the IB Object's Custom Class
// is the only way to see the IB's preview. If you
// want to see the IBInspectable values changed in
// IB's preview, and if havn't set it's custom class,
// set the custom class to prepend "IB" in IB. For
// example, to preview UITextField IBInspectables,
// set the UITextfield's custom class to IBUITextField.
@IBDesignable class IBUIView: UIView {}
@IBDesignable class IBUITextField: UITextField {}
@IBDesignable class IBUIButton: UIButton {}

@IBDesignable
extension UITextField {
    
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(
                string:
                    self.placeholder != nil ?
                        self.placeholder! : "",
                attributes: [
                    NSForegroundColorAttributeName: newValue!
                ]
            )
        }
    }
    
}


@IBDesignable
extension UITextField {
    
    @IBInspectable var paddingLeftAndRight: CGFloat {
        get {
            return self.paddingLeftAndRight
        }
        set {
            self.leftView = UIView(
                frame: CGRect(
                    x: 0,
                    y: 0,
                    width: newValue,
                    height: self.frame.size.height
                )
            )
            self.leftViewMode = .always
            self.rightView = UIView(
                frame: CGRect(
                    x: 0,
                    y: 0,
                    width: newValue,
                    height: self.frame.size.height
                )
            )
            self.rightViewMode = .always
        }
        
    }
    
}


@IBDesignable
extension UIView {
    
    @IBInspectable var blurryBG: Bool {
        get { return self.blurryBG }
        set { _addBlurryView(withStyle: UIBlurEffectStyle.regular) }
    }
    
    @IBInspectable var prominentBlurryBG: Bool {
        get { return self.blurryBG }
        set { _addBlurryView(withStyle: UIBlurEffectStyle.prominent) }
    }
    
    @IBInspectable var darkBlurryBG: Bool {
        get { return self.darkBlurryBG }
        set { _addBlurryView(withStyle: UIBlurEffectStyle.dark) }
    }
    
    @IBInspectable var xLightBlurryBG: Bool {
        get { return self.xLightBlurryBG }
        set { _addBlurryView(withStyle: UIBlurEffectStyle.extraLight) }
    }
    
    /** NOT WORKING??? **/
    @IBInspectable var lightBlurryBG: Bool {
        get { return self.lightBlurryBG }
        set { _addBlurryView(withStyle: UIBlurEffectStyle.light) }
    }
    
    private func _addBlurryView(withStyle style: UIBlurEffectStyle) {
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.userInteractionEnabled = false
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [
            .flexibleWidth, .flexibleHeight
        ]
        self.clipsToBounds = true
        self.addSubview(blurEffectView)
        self.sendSubview(toBack: blurEffectView)
    }
    
}


// UIView Borders
//
// Sets a 1 pixel with border on the top,
// bottom, left, or right sides in the color
// you choose in IB.

@IBDesignable
extension UIView {
    
    @IBInspectable var topBorderColor: UIColor? {
        get {
            return self.topBorderColor
        }
        set {
            _addBorderView(color: newValue, borderSide: "top", size: CGFloat(0.5), update: "color")
        }
    }
    
    @IBInspectable var topBorderSize: CGFloat {
        get {
            return self.topBorderSize
        }
        set {
            _addBorderView(color: UIColor.black, borderSide: "top", size: newValue, update: "size")
        }
    }
    
    @IBInspectable var bottomBorderColor: UIColor? {
        get {
            return self.bottomBorderColor
        }
        set {
            _addBorderView(color: newValue, borderSide: "bottom", size: CGFloat(0.5), update: "color")
        }
    }
    
    @IBInspectable var bottomBorderSize: CGFloat {
        get {
            return self.bottomBorderSize
        }
        set {
            _addBorderView(color: UIColor.black, borderSide: "bottom", size: newValue, update: "size")
        }
    }
    
    @IBInspectable var leftBorderColor: UIColor? {
        get {
            return self.leftBorderColor
        }
        set {
            _addBorderView(color: newValue, borderSide: "left", size: CGFloat(0.5), update: "color")
        }
    }
    
    @IBInspectable var leftBorderSize: CGFloat {
        get {
            return self.leftBorderSize
        }
        set {
            _addBorderView(color: UIColor.black, borderSide: "left", size: newValue, update: "size")
        }
    }
    
    @IBInspectable var rightBorderColor: UIColor? {
        get {
            return self.rightBorderColor
        }
        set {
            _addBorderView(color: newValue, borderSide: "right", size: CGFloat(0.5), update: "color")
        }
    }
    
    @IBInspectable var rightBorderSize: CGFloat {
        get {
            return self.rightBorderSize
        }
        set {
            _addBorderView(color: UIColor.black, borderSide: "right", size: newValue, update: "size")
        }
    }
    
    // borderSize
    //
    // Sets teh border size of all sides.
    // Bug: Only sets is colors are all set prior
    @IBInspectable var borderSize: CGFloat {
        get {
            return self.borderSize
        }
        set {
            for subView in self.subviews {
                if(subView.tag == 10001) {
                    subView.frame = _createBorderFrame(borderSide: "top", weight: newValue)
                } else if(subView.tag == 10002) {
                    subView.frame = _createBorderFrame(borderSide: "bottom", weight: newValue)
                } else if(subView.tag == 10003) {
                    subView.frame = _createBorderFrame(borderSide: "left", weight: newValue)
                } else if(subView.tag == 10004) {
                    subView.frame = _createBorderFrame(borderSide: "right", weight: newValue)
                }
            }
        }
    }
    
    private func _addBorderView(color: UIColor?, borderSide:String, size: CGFloat, update: String) {
        var borderView: UIView!
        var existed = false
        for subView in subviews {
            if
                subView.tag == 10001 && borderSide == "top" ||
                subView.tag == 10002 && borderSide == "bottom" ||
                subView.tag == 10003 && borderSide == "left" ||
                subView.tag == 10004 && borderSide == "right"
            {
                borderView = subView
                existed = true
                break
            }
        }
        if !existed {
            borderView = UIView()
        }
        if update == "color" || (update == "size" && !existed) {
            borderView.backgroundColor = color
        }
        if update == "size" || (update == "color" && !existed) {
            borderView.frame = _createBorderFrame(borderSide: borderSide, weight: size)
        }
        if existed {
            return
        }
        if borderSide == "top" || borderSide == "bottom" {
            borderView.autoresizingMask = [.flexibleWidth]
            if borderSide == "top" {
                borderView.tag = 10001
            } else if(borderSide == "bottom") {
                borderView.tag = 10002
            }
        } else if borderSide == "left" || borderSide == "right" {
            borderView.autoresizingMask = [.flexibleHeight]
            if borderSide == "left" {
                borderView.tag = 10003
            } else if borderSide == "right" {
                borderView.tag = 10004
            }
        }
        borderView.userInteractionEnabled = false
        self.addSubview(borderView)
        self.sendSubview(toBack: borderView)
    }
    
    private func _createBorderFrame(borderSide:String, weight: CGFloat) ->CGRect {
        switch(borderSide) {
            case "top" :
                return CGRect(
                    x: 0,
                    y: 0,
                    width: self.frame.size.width,
                    height: weight
                )
            case "bottom" :
                return CGRect(
                    x: 0,
                    y: self.frame.size.height - weight,
                    width: self.frame.size.width,
                    height: weight
                )
            case "left" :
                return CGRect(
                    x: 0,
                    y: 0,
                    width: weight,
                    height: self.frame.size.height
                )
            case "right" :
                return CGRect(
                    x: self.frame.size.width - weight,
                    y: 0,
                    width: weight,
                    height: self.frame.size.height
                )
            default : return CGRect()
        }
    }
    
}

// UIView Gradient
//
// Adds a gradient to any UIView.

@IBDesignable
extension UIView {
    
    @IBInspectable var gradientStart:UIColor {
        get { return self.gradientStart }
        set { _addGradientView(andSet:"startColor", to: newValue) }
    }
    
    @IBInspectable var gradientEnd:UIColor {
        get { return self.gradientEnd }
        set { _addGradientView(andSet:"endColor", to: newValue) }
    }
    
    @IBInspectable var gradientStartLocation: Double {
        get { return self.gradientStartLocation }
        set { _addGradientView(andSet:"startLocation", to: newValue) }
    }
    
    @IBInspectable var gradientEndLocation: Double {
        get { return self.gradientEndLocation }
        set { _addGradientView(andSet:"endLocation", to: newValue) }
    }
    
    @IBInspectable var gradientHorizontal: Bool {
        get { return self.gradientHorizontal }
        set { _addGradientView(andSet:"horizontalMode", to: newValue) }
    }
    
    @IBInspectable var gradientDiagonal: Bool {
        get { return self.gradientDiagonal }
        set { _addGradientView(andSet:"diagonalMode", to: newValue) }
    }
    
    private func _addGradientView(andSet prop: String, to value:Any) {
        var gradientViewInstance:UIGradientView!
        for subView in self.subviews {
            if ((subView as? UIGradientView) != nil) {
                gradientViewInstance = subView as? UIGradientView
                break
            }
        }
        let gradientViewAdded:Bool = (gradientViewInstance != nil)
        let gradientView = gradientViewAdded ? gradientViewInstance : UIGradientView()
        if(prop == "startColor") { gradientView?.startColor = value as! UIColor }
        if(prop == "endColor") { gradientView?.endColor = value as! UIColor }
        if(prop == "startLocation") { gradientView?.startLocation = value as! Double }
        if(prop == "endLocation") { gradientView?.endLocation = value as! Double }
        if(prop == "horizontalMode") { gradientView?.horizontalMode = value as! Bool }
        if(prop == "diagonalMode") { gradientView?.diagonalMode = value as! Bool }
        if(gradientViewAdded) {
            return
        }
        gradientView?.frame = self.bounds
        gradientView?.autoresizingMask = [
            .flexibleWidth, .flexibleHeight
        ]
        //self.clipsToBounds = true
        self.addSubview(gradientView!)
        self.sendSubview(toBack: gradientView!)
    }
    
}

// UIView Gradient class
//
// UIView inherited class used as a util for
// the UIView extention. Can also be used as
// a class override in IB.

@IBDesignable
class UIGradientView: UIView {
    
    @IBInspectable var startColor:   UIColor = .black {
        didSet { updateColors() }
    }
    
    @IBInspectable var endColor:     UIColor = .white {
        didSet { updateColors() }
    }
    
    @IBInspectable var startLocation: Double =   0.05 {
        didSet { updateLocations() }
    }
    
    @IBInspectable var endLocation:   Double =   0.95 {
        didSet { updateLocations() }
    }
    
    @IBInspectable var horizontalMode:  Bool =  false {
        didSet { updatePoints() }
    }
    
    @IBInspectable var diagonalMode:    Bool =  false {
        didSet { updatePoints() }
    }
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    var gradientLayer: CAGradientLayer {
        return layer as! CAGradientLayer
    }
    
    func updatePoints() {
        if horizontalMode {
            gradientLayer.startPoint = diagonalMode ? CGPoint(x: 1, y: 0) : CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint   = diagonalMode ? CGPoint(x: 0, y: 1) : CGPoint(x: 1, y: 0.5)
        } else {
            gradientLayer.startPoint = diagonalMode ? CGPoint(x: 0, y: 0) : CGPoint(x: 0.5, y: 0)
            gradientLayer.endPoint   = diagonalMode ? CGPoint(x: 1, y: 1) : CGPoint(x: 0.5, y: 1)
        }
    }
    
    func updateLocations() {
        gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
    }
    
    func updateColors() {
        gradientLayer.colors    = [startColor.cgColor, endColor.cgColor]
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updatePoints()
        updateLocations()
        updateColors()
    }
}

// UIButton corderRadius
//
// Set the ammount of corder radius to any
// UIButton. Note: To have a perfect circle,
// use half the height or with of the UIButton
// for it's value.

@IBDesignable
extension UIButton {
    
    @IBInspectable
    public var cornerRadius :CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
}
