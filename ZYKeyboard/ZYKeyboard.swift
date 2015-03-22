//
//  ZYKeyboard.swift
//  keyboard
//
//  Created by leeey on 14/8/26.
//  Copyright (c) 2014年 leeey. All rights reserved.
//

import Foundation
import UIKit

protocol ZYKeyboardDelegate {
    func closekeyboard()
    
}

class ZYKeyboard : UIView {
    var delegate : ZYKeyboardDelegate?
    var txtResult : UITextField?
    var result: Double = 0
    var decimals: Bool = false
    var decimalPos: Double = 1
    var operand: Operand?
    var argument: Double = 0
    var start: Bool = true
    var shape:[String:CGFloat] = ["w":MYWIDTH()/4-1,"h":62.00]
    var isAlert =  false
    
    enum Operand {
        case Add //+
        case Sub //-
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        updateResult()
        keyboardView()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func output(value: Double) {
        if !check(value){
            btnClear()
            txtResult?.text = "￥0.00"
            return
        }
        txtResult?.text = String(format: "￥%.12g", value)
    }
    
    func updateResult() {
        output(operand == nil ? result : argument)
    }
    
    func append(value: Double, to: Double) -> Double {
        var result: Double = to
        let diff = to >= 0 ? value : -value
        if decimals {
            result += diff / pow(10.0, Double(decimalPos))
            decimalPos += 1
        } else {
            result = result * 10 + diff
        }
        return result
    }
    
    func calc(arg1: Double, withOp op: Operand, andArg arg2: Double) -> Double {
        switch op {
        case .Add: return arg1 + arg2
        case .Sub: return arg1 - arg2
        }
    }
    
    func btnNumber(sender: UIButton!){
        let inputInt = sender.titleLabel?.text?.toInt() //(sender.titleLabel?.text?.toInt()!)
        let input = Double(inputInt!)
        if start {
            result = input
            start = false
        } else {
            if operand == nil {
                result = append(input, to: result)
            } else {
                argument = append(input, to: argument)
            }
        }
        updateResult()
    }
    
    func btnClear() {
        result = 0
        argument = 0
        decimalPos = 1
        decimals = false
        operand = nil
        updateResult()
    }
    
    func check(number:Double)->Bool{
        if number >= 100000000 || number < 0 {
            shine()
            return false
        }
        return true
    }
    
    func btnOperand(sender: UIButton) {
        if operand != nil {
            result = calc(result, withOp: operand!, andArg: argument)
            output(result)
            
        }
        decimalPos = 1
        decimals = false
        argument = 0
        start = false
        if sender.titleLabel?.text == "+" {
            operand = .Add
        } else if sender.titleLabel?.text == "-" {
            operand = .Sub
        }else {
            operand = nil
            argument = 0
            start = true
        }
    }
    
    func btnPercent(sender : UIButton ){
        decimals = true
    }
    
//    func keyboardView(){
//        TICK
//        var w = MYWIDTH()
//        var h = 252
//        var borderH = 1
//        var borderW = 1
//        var btnW =  ( Float(w) - Float( borderW * 5) ) / Float(4)
//        var btnH =  ( Float(h) - Float( borderH * 5) ) / Float(4)
//        for i in 1 ... 16 {
//            var line  = ( i - 1 ) % 4
//            var row = ( i - 1 ) / 4
//            var xx = Double(btnW) * Double(line) + Double(borderW) * ( Double(line) + 1)
//            var yy = Double(btnH) * Double(row) + Double(borderH) * ( Double(row) + 1 )
//            var btn = UIButton( frame: CGRectMake(CGFloat(xx), CGFloat(yy) , CGFloat(btnW), CGFloat(btnH)) )
//            btn.titleLabel?.font = UIFont.systemFontOfSize(20)
//            btn.setTitle("\(xx),\(yy)",forState:.Normal);
//            switch i {
//            case 4:
//                btn.setTitle("☒",forState:.Normal)
//                btn.addTarget(self,action:"closekeyboard:",forControlEvents:.TouchUpInside)
//            case 8:
//                btn.setTitle("+",forState:.Normal)
//                btn.addTarget(self,action:"btnOperand:",forControlEvents:.TouchUpInside)
//            case 12:
//                btn.setTitle("-",forState:.Normal)
//                btn.addTarget(self,action:"btnOperand:",forControlEvents:.TouchUpInside)
//            case 16:
//                btn.setTitle("=",forState:.Normal)
//                btn.addTarget(self,action:"btnOperand:",forControlEvents:.TouchUpInside)
//            case 13:
//                btn.setTitle("C",forState:.Normal)
//                btn.addTarget(self,action:"btnClear",forControlEvents:.TouchUpInside)
//            case 14:
//                btn.setTitle("0",forState:.Normal)
//                btn.addTarget(self,action:"btnNumber:",forControlEvents:.TouchUpInside)
//            case 15:
//                btn.setTitle(".",forState:.Normal)
//                btn.addTarget(self,action:"btnPercent:",forControlEvents:.TouchUpInside)
//            default:
//                btn.setTitle(String((row)*3+line+1),forState:.Normal)
//                btn.addTarget(self,action:"btnNumber:",forControlEvents:.TouchUpInside)
//            }
//            btnColor(btn)
//            self.addSubview(btn)
//        }
//        TOCK
//    }
    
    func keyboardView(){
        TICK
        var w = MYWIDTH()
        var h = 252
        var borderH = 1
        var borderW = 1
        var btnW =  ( Float(w) - Float( borderW * 5) ) / Float(4)
        var btnH =  ( Float(h) - Float( borderH * 5) ) / Float(4)
  
        var queue = dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)
        dispatch_apply(17, queue, {(i:Int) -> Void in
            var line  = ( i - 1 ) % 4
            var row = ( i - 1 ) / 4
            var xx = Double(btnW) * Double(line) + Double(borderW) * ( Double(line) + 1)
            var yy = Double(btnH) * Double(row) + Double(borderH) * ( Double(row) + 1 )
            var btn = UIButton( frame: CGRectMake(CGFloat(xx), CGFloat(yy) , CGFloat(btnW), CGFloat(btnH)) )
            btn.titleLabel?.font = UIFont.systemFontOfSize(20)
            btn.setTitle("\(xx),\(yy)",forState:.Normal);
            switch i {
            case 4:
                btn.setTitle("☒",forState:.Normal)
                btn.addTarget(self,action:"closekeyboard:",forControlEvents:.TouchUpInside)
            case 8:
                btn.setTitle("+",forState:.Normal)
                btn.addTarget(self,action:"btnOperand:",forControlEvents:.TouchUpInside)
            case 12:
                btn.setTitle("-",forState:.Normal)
                btn.addTarget(self,action:"btnOperand:",forControlEvents:.TouchUpInside)
            case 16:
                btn.setTitle("=",forState:.Normal)
                btn.addTarget(self,action:"btnOperand:",forControlEvents:.TouchUpInside)
            case 13:
                btn.setTitle("C",forState:.Normal)
                btn.addTarget(self,action:"btnClear",forControlEvents:.TouchUpInside)
            case 14:
                btn.setTitle("0",forState:.Normal)
                btn.addTarget(self,action:"btnNumber:",forControlEvents:.TouchUpInside)
            case 15:
                btn.setTitle(".",forState:.Normal)
                btn.addTarget(self,action:"btnPercent:",forControlEvents:.TouchUpInside)
            default:
                btn.setTitle(String((row)*3+line+1),forState:.Normal)
                btn.addTarget(self,action:"btnNumber:",forControlEvents:.TouchUpInside)
            }
            self.btnColor(btn)
            self.addSubview(btn)
         })
        TOCK
    }
    
    
    func btnColor(button:UIButton){
        button.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Highlighted)
        button.setBackgroundImage(createImageWithColor(UIColor.whiteColor()), forState: UIControlState.Normal)
        button.setBackgroundImage(createImageWithColor(UIColor.grayColor()), forState: UIControlState.Highlighted)
    }
    
    func shine() {
        UIView.animateWithDuration(0.2, animations: { self.alphaup()
            }, completion: {
                (Bool completion) in
                if completion {
                    self.alphaDown()
                    UIView.animateWithDuration(0.1, animations: { self.alphaup()
                        }, completion: {
                            (Bool completion) in
                            if completion {
                                self.alphaDown()
                            }
                    })
                }
        })
    }
    
    func alphaup(){
        self.txtResult?.alpha = 0
    }
    
    func alphaDown(){
        self.txtResult?.alpha = 1
    }
    
    func closekeyboard( sender: UIButton ){
        delegate?.closekeyboard()
    }
}