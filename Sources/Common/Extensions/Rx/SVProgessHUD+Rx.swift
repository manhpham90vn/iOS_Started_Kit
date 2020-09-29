//
//  SVProgessHUD+Rx.swift
//  MyApp
//
//  Created by Manh Pham on 3/14/20.
//

import SVProgressHUD

extension Reactive where Base: SVProgressHUD {

    static var isAnimating: Binder<Bool> {
      return Binder(UIApplication.shared) {_, isVisible in
         if isVisible {
            SVProgressHUD.show()
         } else {
            SVProgressHUD.dismiss()
         }
      }
   }
    
}

