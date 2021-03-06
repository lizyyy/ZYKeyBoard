import UIKit

extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0xFF00) >> 8) / 255.0
        let blue = CGFloat((hex & 0xFF)) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
}

func createImageWithColor(color:UIColor) ->UIImage {
    var rect  = CGRectMake(0, 0, 1, 1)
    UIGraphicsBeginImageContext(rect.size)
    var context = UIGraphicsGetCurrentContext()
    CGContextSetFillColorWithColor(context,color.CGColor)
    CGContextFillRect(context,rect)
    var theImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return theImage
}



func MYWIDTH()->CGFloat{
    return UIScreen.mainScreen().bounds.width
}

func MYHEIGHT()->CGFloat{
    return UIScreen.mainScreen().bounds.height
}


let TICK  = NSDate().timeIntervalSince1970
let TOCK: () =  println(NSDate().timeIntervalSince1970 - TICK)

 