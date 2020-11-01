//
//  CustomTextField.swift
//  HappyFoodDeliveryApp
//
//  Created by Khin Yadanar Thein on 31/10/2020.
//

import SwiftUI

struct CustomTextField: View {
    var placeHolder: String
    @Binding var value: String
    
    var lineColor: Color
    var width: CGFloat
    
    var body: some View {
        VStack {
            TextField(self.placeHolder, text: $value)
                .padding([.leading],10)
            
            Rectangle().frame(height: self.width)
                .padding(.horizontal, 10).foregroundColor(self.lineColor)
        }
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(placeHolder: "custom", value: .constant("custom"), lineColor: Color.gray, width: 2)
    }
}
