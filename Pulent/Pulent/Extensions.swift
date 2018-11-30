//
//  Extensions.swift
//  Pulento
//
//  Created by Matías Contreras Selman on 11/28/18.
//  Copyright © 2018 Matias Contreras. All rights reserved.
//
import UIKit
import Foundation

//extension for loading the NIBs into a frame
extension UIView {
    @discardableResult
    func fromNib<T : UIView>() -> T? {
        debugPrint(String(describing: type(of: self)))
        guard let contentView = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? T else {
            debugPrint("No se pudo cargar el nib: \(String(describing: type(of: self)))")
            return nil
        }
        self.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.layoutAttachAll(to: self)
        return contentView
    }
    
    public func layoutAttachAll(to parentView:UIView)
    {
        var constraints = [NSLayoutConstraint]()
        self.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(NSLayoutConstraint(item: self, attribute: .left, relatedBy: .equal, toItem: parentView, attribute: .left, multiplier: 1.0, constant: 0))
        constraints.append(NSLayoutConstraint(item: self, attribute: .right, relatedBy: .equal, toItem: parentView, attribute: .right, multiplier: 1.0, constant: 0))
        constraints.append(NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: parentView, attribute: .top, multiplier: 1.0, constant: 0))
        constraints.append(NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: parentView, attribute: .bottom, multiplier: 1.0, constant: 0))
        parentView.addConstraints(constraints)
    }
    
    /*for showing the messages*/
    func showMessage(type: MessageType, loopAnimation: Bool? = false, action: (() -> Void)? = nil){
        //check if there is another error message on screen with the same message
        for view in self.subviews{
            if let view = view as? MessageView, view.messageType == type{
                return
            }
        }
        
        let messageView = MessageView()
        if let action = action{
            messageView.action = action
        }
        
        messageView.loopAnimation = loopAnimation!
        messageView.messageType = type
        self.addSubview(messageView)
        messageView.layoutAttachAll(to: self)
    }
    
    func showMessage(error: NSError, loopAnimation: Bool? = false, action: (() -> Void)? = nil){
        //special for showing error messages
        var errorType = MessageType.genericError
        debugPrint(error.code)
        switch error.code{
        case -1009:
            errorType = .noConnection
        default:
            break
        }
        self.showMessage(type: errorType, loopAnimation: loopAnimation, action: action)
    }
    
    func removeMessage(){
        for view in self.subviews{
            if view is MessageView{
                view.removeFromSuperview()
            }
        }
    }
}

/*DESIGNABLE EXTENSIONS*/
extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}

/*EXTENSION FOR TRANSFORMING CODABLE INTO DATA*/
extension Encodable {
    func encode() throws -> Data {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        return try encoder.encode(self)
    }
    
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}

