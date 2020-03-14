//
//  AppHelper.swift
//  MyApp
//
//  Created by Manh Pham on 3/14/20.
//

import Foundation

class AppHelper {
    
    class func convert<T: Codable>(_ object: T) -> String {
        guard let data = try? JSONEncoder().encode(object) else { return "" }
        guard let jsonString = String(data: data, encoding: .utf8) else { return "" }
        return jsonString
    }
    
    class func convert<T: Codable>(_ object: T) -> [String: Any]? {
        guard let data = try? JSONEncoder().encode(object) else { return nil }
        guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else { return nil }
        guard let json = jsonObject as? [String: Any] else { return nil }
        return json
    }
    
    class func showMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(closeAction)
        
        if let topViewController = AppHelper.topViewController() {
            topViewController.present(alert, animated: true, completion: nil)
        }
    }
    
    class func topViewController(_ viewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = viewController as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = viewController as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = viewController?.presentedViewController {
            return topViewController(presented)
        }
        return viewController
    }
    
}
