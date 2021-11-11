//
//  Constains.swift
//  Mars
//
//  Created by 董静 on 11/5/21.
//

import Foundation
import UIKit

class utilities {
    
    func textHeight(text:String, fontSize:CGFloat, width: CGFloat) -> CGFloat {
        return text.boundingRect(with:CGSize(width: width, height:CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [.font:UIFont.systemFont(ofSize: fontSize)], context:nil).size.height
    }
}

