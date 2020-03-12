//
//  UIViewController+Extensions.swift
//  MyApp
//
//  Created by Manh Pham on 3/12/20.
//

import Foundation
import UIKit

extension UIViewController {
    
    func logDeinit() {
        LogInfo("\(type(of: self)): Deinited")
    }
    
}
