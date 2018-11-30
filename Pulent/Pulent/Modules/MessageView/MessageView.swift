//
//  MessageView.swift
//  Pulent
//
//  Created by Matías Contreras Selman on 11/29/18.
//  Copyright © 2018 Matías Contreras. All rights reserved.
//

import UIKit
import Lottie

struct MessageData{
    let message: String
    let animationName: String
}

enum MessageType{
    case noConnection
    case genericError
    case noSearchResults
    case loading
    
    func getData() -> MessageData{
        switch self{
        case .noConnection:
            return MessageData(message: "Sin conexión a internet", animationName: "no-connection")
        case .genericError:
            return MessageData(message: "Ups.. Ocurrió un error inesperado", animationName: "generic-error")
        case .noSearchResults:
            return MessageData(message: "No se encontraron resultados", animationName: "empty-results")
        case .loading:
            return MessageData(message: "Un segundo...", animationName: "loading")
        }
    }
}

class MessageView: UIView {
    
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var animationCanvas: UIView!
    @IBOutlet weak var errorMessageLbl: UILabel!
    var messageType: MessageType = .genericError {
        didSet{
            self.errorMessageLbl.text = messageType.getData().message
            self.addAnimation(named: messageType.getData().animationName)
        }
    }
    var loopAnimation: Bool = false
    var action: (() -> ())? {
        didSet{
            actionButton.isHidden = false
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        fromNib()
        self.messageType = .genericError
    }
    
    func addAnimation(named: String){
        debugPrint(self.loopAnimation)
        removeAllAnimationsFromCanvas()
        let animationView = LOTAnimationView(name: named)
        animationView.frame = animationCanvas.frame
        animationView.frame.origin = CGPoint.zero
        animationView.contentMode = .scaleAspectFit
        //animationView.backgroundColor = .clear
        //animationView.shadowColor = .clear
        //animationView.tintColor = .clear
        //animationCanvas.backgroundColor = .clear
        self.addSubview(animationView)
        animationCanvas.addSubview(animationView)
        animationView.layoutAttachAll(to: animationCanvas)
        animationView.loopAnimation = loopAnimation
        animationView.play()
    }
    
    func removeAllAnimationsFromCanvas(){
        for view in animationCanvas.subviews{
            view.removeFromSuperview()
        }
    }
    
    @IBAction func actionButton(_ sender: Any) {
        self.action?()
    }
}
