//
//  Extension.swift
//  HappyFoodDeliveryApp
//
//  Created by Khin Yadanar Thein on 29/10/2020.
//

import Foundation
import UIKit
import SwiftUI

extension View {
     public func addBorder<S>(_ content: S, width: CGFloat = 1, cornerRadius: CGFloat) -> some View where S : ShapeStyle {
         let roundedRect = RoundedRectangle(cornerRadius: cornerRadius)
         return clipShape(roundedRect)
              .overlay(roundedRect.strokeBorder(content, lineWidth: width))
     }
 }
