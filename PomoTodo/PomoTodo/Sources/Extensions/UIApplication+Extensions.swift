//
//  View Extensions.swift
//  PomoTodo
//
//  Created by 심근웅 on 2/18/25.
//

import Foundation
import SwiftUI

extension UIApplication: @retroactive UIGestureRecognizerDelegate {
  public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    return false
  }
}

extension UIApplication {
  func hideKeyboard() {

    let scenes = UIApplication.shared.connectedScenes
    let windowScene = scenes.first as? UIWindowScene
    guard let window = windowScene?.windows.first else { return }
    let tapRecognizer = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))
    tapRecognizer.cancelsTouchesInView = false
    tapRecognizer.delegate = self
    window.addGestureRecognizer(tapRecognizer)
  }
}
