//
//  NetworkIndicatorPlugin.swift
//  MyApp
//
//  Created by Manh Pham on 3/27/20.
//

import Foundation

enum NetworkIndicatorPlugin {
    
    static func indicatorPlugin() -> NetworkActivityPlugin {
        return NetworkActivityPlugin(networkActivityClosure: { (change, _) in
            DispatchQueue.main.async {
                switch change {
                case .began:
                    UIApplication.shared.isNetworkActivityIndicatorVisible = true
                case .ended:
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            }
        })
    }
    
}
