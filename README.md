ZYKeyBoard
==========

swift 自定义价格键盘，支持加法计算，带小数点

使用方法：



                var money =  UITextField(frame: CGRectMake(50, 100, 350, 100))
                var zykeyboard = ZYKeyboard(frame: CGRectMake(0,  480 - 44 - 216, 320, 216))
                money.inputView = zykeyboard
                zykeyboard.delegate = self
                zykeyboard.txtResult = money
                
                
                
                
![github](https://raw.githubusercontent.com/lizyyy/ZYKeyBoard/master/1.png "github")
