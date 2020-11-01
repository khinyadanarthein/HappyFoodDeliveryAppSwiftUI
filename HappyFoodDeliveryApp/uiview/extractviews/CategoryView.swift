//
//  CategoryView.swift
//  HappyFoodDeliveryApp
//
//  Created by Khin Yadanar Thein on 01/11/2020.
//

import SwiftUI
import SDWebImageSwiftUI

struct CategoryView: View {
    
    var data : CategoryVO
    
    var body: some View {
        VStack {
            WebImage(url: URL(string: data.image ?? ""))
                .resizable()
                .indicator(.activity)
                .transition(.fade(duration: 0.5))
                .scaledToFit()
                .frame(width: 150, height: 150, alignment: .center)
            
//            Image("food-sample")
//                .resizable()
//                .frame(width: 150, height: 150, alignment: .center)
//                .scaledToFill()
            
            Text(data.name ?? "").foregroundColor(.black)
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(data: CategoryVO())
    }
}
