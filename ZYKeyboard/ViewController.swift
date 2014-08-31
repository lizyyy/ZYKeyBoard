//
//  ViewController.swift
//  ZYKeyboard
//
//  Created by leeey on 14/8/31.
//  Copyright (c) 2014年 leeey. All rights reserved.
//

import UIKit

class ViewController: UIViewController,ZYKeyboardDelegate {
    var money =  UITextField(frame: CGRectMake(50, 100, 350, 100))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        money.attributedPlaceholder = NSAttributedString(  string: "0.00",attributes: [NSForegroundColorAttributeName: UIColor(hex:0x5eb420,alpha:1)])
        money.textColor = UIColor(hex:0x5eb420,alpha:1)
        var zykeyboard = ZYKeyboard(frame: CGRectMake(0,  480 - 44 - 216, 320, 216))
        money.inputView = zykeyboard
        zykeyboard.delegate = self
        zykeyboard.txtResult = money
        money.font = UIFont.boldSystemFontOfSize(40)
        money.becomeFirstResponder()
        self.view.addSubview(money)
    }
    
    func done(){
        money .resignFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}