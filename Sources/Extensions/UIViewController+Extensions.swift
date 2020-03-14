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
    
    static func instantiate() -> Self {
        return .init(nibName: String(describing: self), bundle: Bundle(for: self))
    }
    
}
