//
//  PopularChoiceView.swift
//  HappyFoodDeliveryApp
//
//  Created by Khin Yadanar Thein on 01/11/2020.
//

import SwiftUI
import SDWebImageSwiftUI

struct PopularChoiceView: View {
    
    var restaurant : RestaurantVO
    var cellWidth : CGFloat
    
    var body: some View {
        VStack (alignment: .leading){
            
            WebImage(url: URL(string: restaurant.photoURL ?? ""))
                .resizable()
                .indicator(.activity)
                .transition(.fade(duration: 0.5))
                .scaledToFit()
                .frame(width: cellWidth, height: 200, alignment: .center)
                .cornerRadius(15)
            
//            Image("cake-sample")
//                .resizable()
//                .frame(width: cellWidth, height: 200, alignment: .center)
//                .scaledToFill()
//                .cornerRadius(15)
            
            Text(restaurant.name ?? "")
                .foregroundColor(.black)
                .fontWeight(.bold)
                .font(.title3)
            
            HStack {
                Image(systemName: "star.fill")
                    .foregroundColor(.red)
                    .frame(width: 25, height: 30, alignment: .center)
                Text("\(restaurant.rating ?? 0)")
                    .foregroundColor(.red)
                Text("(\(restaurant.rateCount ?? 0) ratings)")
                    .foregroundColor(.gray)
                Text(restaurant.category ?? "")
                    .foregroundColor(.gray)
            }
        }
    }
}

struct PopularChoiceView_Previews: PreviewProvider {
    static var previews: some View {
        PopularChoiceView(restaurant: RestaurantVO(), cellWidth: 350)
    }
}
