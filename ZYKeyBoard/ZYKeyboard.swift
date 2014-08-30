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
    func done()
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
    var shape:[String:CGFloat] = ["w":79.00,"h":53.00]

    
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
        txtResult?.text = String(format: "%.15g", value)
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
        let input = Double(sender.titleLabel.text.toInt()!)
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
    
    func btnClear(sender: UIButton) {
        result = 0
        argument = 0
        decimalPos = 1
        decimals = false
        operand = nil
        updateResult()
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
        if sender.titleLabel.text == "+" {
            operand = .Add
        } else if sender.titleLabel.text == "-" {
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

    func keyboardView(){
        for i in 0...9 {
            self.addSubview(numBtn(String(i)))
        }
        
        var operand = UIButton(frame: CGRectMake(shape["w"]!*3+3, shape["h"]!*3+4, shape["w"]!+1 ,shape["h"]!))
        operand.backgroundColor = UIColor.whiteColor();
        operand.addTarget(self,action:"btnOperand:",forControlEvents:.TouchUpInside);
        operand.titleLabel.font = UIFont.boldSystemFontOfSize(25)
        operand.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        operand.setTitle("=",forState:.Normal);
        self.addSubview(operand)
        
        var add = UIButton(frame: CGRectMake(shape["w"]!*3+3, shape["h"]!*1+2, shape["w"]!+1 ,shape["h"]!))
        add.backgroundColor = UIColor.whiteColor();
        add.addTarget(self,action:"btnOperand:",forControlEvents:.TouchUpInside);
        add.titleLabel.font = UIFont.boldSystemFontOfSize(22)
        add.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        add.setTitle("+",forState:.Normal);
        self.addSubview(add)
        
        var sub = UIButton(frame: CGRectMake(shape["w"]!*3+3, shape["h"]!*2+3, shape["w"]!+1 ,shape["h"]!))
        sub.backgroundColor = UIColor.whiteColor();
        sub.addTarget(self,action:"btnOperand:",forControlEvents:.TouchUpInside);
        sub.titleLabel.font = UIFont.boldSystemFontOfSize(22)
        sub.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        sub.setTitle("-",forState:.Normal);
        self.addSubview(sub)
        
        var done = UIButton(frame: CGRectMake(shape["w"]!*3+3, shape["h"]!*0+1, shape["w"]!+1 ,shape["h"]!))
        done.backgroundColor = UIColor.whiteColor();
        done.addTarget(self,action:"done:",forControlEvents:.TouchUpInside);
        done.titleLabel.font = UIFont.boldSystemFontOfSize(18)
        done.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        done.setTitle("☒",forState:.Normal);
        self.addSubview(done)
        
        var btc = UIButton(frame: CGRectMake(shape["w"]!*0, shape["h"]!*3+4, shape["w"]! ,shape["h"]!))
        btc.backgroundColor = UIColor.whiteColor();
        btc.addTarget(self,action:"btnClear:",forControlEvents:.TouchUpInside);
        btc.titleLabel.font = UIFont.boldSystemFontOfSize(16)
        btc.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        btc.setTitle("C",forState:.Normal);
        self.addSubview(btc)
        
        var btp = UIButton(frame: CGRectMake(shape["w"]!*2+2, shape["h"]!*3+4, shape["w"]! ,shape["h"]!))
        btp.backgroundColor = UIColor.whiteColor();
        btp.addTarget(self,action:"btnPercent:",forControlEvents:.TouchUpInside);
        btp.titleLabel.font = UIFont.boldSystemFontOfSize(18)
        btp.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        btp.setTitle(".",forState:.Normal);
        self.addSubview(btp)
    }
    
    func numBtn(number:String)->UIButton {
        var numInt = number.toInt()!
        var button = UIButton()
        var line = (numInt-1)/3
        var row = (numInt-3*line) - 1
        var x  = Int(shape["w"]!) * row + row
        var y  = Int(shape["h"]!) * line + line + 1
        switch numInt {
            case 1...9:
                button = UIButton(frame: CGRectMake(CGFloat(x), CGFloat(y), shape["w"]! ,shape["h"]!))
            default:button = UIButton(frame: CGRectMake(shape["w"]!*1+1, shape["h"]!*3+4, shape["w"]! ,shape["h"]!))
        }
        button.addTarget(self,action:"btnNumber:",forControlEvents:.TouchUpInside);
        button.titleLabel.font = UIFont.boldSystemFontOfSize(18)
        button.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        button.setTitle(number,forState:.Normal);
        button.backgroundColor = UIColor.whiteColor();
        return button
    }
    
    func done( sender: UIButton ){
        delegate?.done()
    }

    
}