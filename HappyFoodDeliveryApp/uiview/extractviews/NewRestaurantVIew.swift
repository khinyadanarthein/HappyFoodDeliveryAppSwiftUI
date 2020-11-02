//
//  NewRestaurantVIew.swift
//  HappyFoodDeliveryApp
//
//  Created by Khin Yadanar Thein on 01/11/2020.
//

import SwiftUI
import SDWebImageSwiftUI

struct NewRestaurantView: View {
    
    var restaurant : RestaurantVO
    
    var body: some View {
        VStack (alignment: .leading){
            
            HStack (alignment:.top){
                
                WebImage(url: URL(string: restaurant.photoURL ?? ""))
                    .resizable()
                    .indicator(.activity)
                    .transition(.fade(duration: 0.5))
                    .scaledToFill()
                    .frame(width: 150, height: 150, alignment: .center)
                    .cornerRadius(15)
                
//                Image("cake-sample")
//                    .resizable()
//                    .frame(width: 150, height: 150, alignment: .center)
//                    .scaledToFill()
//                    .cornerRadius(15)
                
                VStack (alignment: .leading){
                    Text(restaurant.name ?? "Burger")
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                        .font(.title3)
                    
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(.red)
                            .frame(width: 25, height: 30, alignment: .center)
                        Text(String(format: "%.1f", restaurant.rating ?? 0.0))
                            .foregroundColor(.red)
                        Text("(\(restaurant.rateCount ?? 0) ratings)")
                            .foregroundColor(.gray)
                    }
                    HStack {
                        Text(restaurant.category ?? "cafe")
                            .foregroundColor(.gray)
                    }
                }
            }
        }
    }
}

struct NewRestaurantView_Previews: PreviewProvider {
    static var previews: some View {
        NewRestaurantView(restaurant:RestaurantVO())
    }
}
