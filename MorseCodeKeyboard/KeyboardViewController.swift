//
//  KeyboardViewController.swift
//  MorseCodeKeyboard
//
//  Created by Andrei Puni on 16/06/14.
//  Copyright (c) 2014 Andrei Puni. All rights reserved.
//

import UIKit


class KeyboardViewController: UIInputViewController {
    
    var nextKeyboardButton: UIButton!
    var dotButton: UIButton!
    var dashButton: UIButton!
    var deleteButton: UIButton!
    var hideKeyboardButton: UIButton!
    
    var customInterface: UIView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        let nib = UINib(nibName: "CustomKeyBoard", bundle: nil)
        let objects = nib.instantiate(withOwner: self, options: nil)
        customInterface = objects[0] as! UIView
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(customInterface)
        
        addKeyboardButtons()
    }
    
    func addKeyboardButtons() {
        addDot()
        addDash()
        
        addDelete()
        
        addNextKeyboardButton()
        addHideKeyboardButton()
    }
    
    func addNextKeyboardButton() {
        nextKeyboardButton = UIButton(type: .system) as UIButton
        
        nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), for: .normal)
        nextKeyboardButton.sizeToFit()
        nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        
        nextKeyboardButton.addTarget(self, action: #selector(advanceToNextInputMode), for: .touchUpInside)
        
        view.addSubview(nextKeyboardButton)
        
        
        
        let nextKeyboardButtonLeftSideConstraint = NSLayoutConstraint(item: nextKeyboardButton, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: +10.0)
        let nextKeyboardButtonBottomConstraint = NSLayoutConstraint(item:nextKeyboardButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: -10.0)
        view.addConstraints([nextKeyboardButtonLeftSideConstraint, nextKeyboardButtonBottomConstraint])
    }
    
    func addHideKeyboardButton() {
        hideKeyboardButton = UIButton(type: .system) as UIButton
        
        hideKeyboardButton.setTitle("Hide Keyboard", for: .normal)
        hideKeyboardButton.sizeToFit()
        hideKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        
        hideKeyboardButton.addTarget(self, action: #selector(dismissKeyboard), for: .touchUpInside)
        
        view.addSubview(hideKeyboardButton)
        
        let rightSideConstraint = NSLayoutConstraint(item: hideKeyboardButton, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: -10.0)
        let bottomConstraint = NSLayoutConstraint(item: hideKeyboardButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: -10.0)
        view.addConstraints([rightSideConstraint, bottomConstraint])
    }
    
    func addDot() {
        dotButton = UIButton(type: .system) as UIButton
        dotButton.setTitle(".", for: .normal)
        dotButton.sizeToFit()
        dotButton.translatesAutoresizingMaskIntoConstraints = false
        dotButton.addTarget(self, action: #selector(didTapDot), for: .touchUpInside)
        
        dotButton.titleLabel!.font = UIFont.systemFont(ofSize: 32)
        
        dotButton.backgroundColor = UIColor(white: 0.9, alpha: 1)
        dotButton.layer.cornerRadius = 5
        
        view.addSubview(dotButton)
        
        let dotcenterYConstraint = NSLayoutConstraint(item: dotButton, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: 0)
        let dotcenterXConstraint = NSLayoutConstraint(item: dotButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: -50)
        
        view.addConstraints([dotcenterXConstraint, dotcenterYConstraint])
    }
    
    func addDash() {
        dashButton = UIButton(type: .system) as UIButton
        dashButton.setTitle("_", for: .normal)
        dashButton.sizeToFit()
        dashButton.translatesAutoresizingMaskIntoConstraints = false
        dashButton.addTarget(self, action: #selector(didTapDash), for: .touchUpInside)
        
        dashButton.titleLabel!.font = UIFont.systemFont(ofSize: 32)
        
        dashButton.backgroundColor = UIColor(white: 0.9, alpha: 1)
        dashButton.layer.cornerRadius = 5
        
        view.addSubview(dashButton)
        
        let dashcenterYConstraint = NSLayoutConstraint(item: dashButton, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: 0)
        let dashcenterXConstraint = NSLayoutConstraint(item: dashButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: +50)
        
        view.addConstraints([dashcenterXConstraint, dashcenterYConstraint])
    }
    
    func addDelete() {
        deleteButton = UIButton(type: .system) as UIButton
        deleteButton.setTitle(" Delete ", for: .normal)
        deleteButton.sizeToFit()
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.addTarget(self, action: #selector(didTapDelete), for: .touchUpInside)
        
        deleteButton.backgroundColor = UIColor(white: 0.9, alpha: 1)
        deleteButton.layer.cornerRadius = 5
        
        view.addSubview(deleteButton)
        
        let rightSideConstraint = NSLayoutConstraint(item: deleteButton, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: -10.0)
        let topConstraint = NSLayoutConstraint(item: deleteButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: +10.0)
        view.addConstraints([rightSideConstraint, topConstraint])
    }
    
    @objc func didTapDot() {
        let proxy = textDocumentProxy as UITextDocumentProxy
        
        proxy.insertText(".")
    }
    
    @objc func didTapDash() {
        let proxy = textDocumentProxy as UITextDocumentProxy
        
        proxy.insertText("_")
    }
    
    @objc func didTapDelete() {
        let proxy = textDocumentProxy as UITextDocumentProxy
        
        proxy.deleteBackward()
    }
    
    @IBAction func didTapWeheartSwift() {
        let proxy = textDocumentProxy as UITextDocumentProxy
        
        proxy.insertText("We ❤ Swift")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        var textColor: UIColor
        let proxy = textDocumentProxy as UITextDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
        nextKeyboardButton.setTitleColor(textColor, for: .normal)
    }
    
}

