//
//  RestaurantDetailView.swift
//  HappyFoodDeliveryApp
//
//  Created by Khin Yadanar Thein on 01/11/2020.
//

import SwiftUI
import SDWebImageSwiftUI

struct RestaurantDetailView: View {
    
    var restaurant : RestaurantVO
    
    @ObservedObject var mViewModel = DetailViewModel()
    
    var body: some View {
        
        GeometryReader { geometry in
            NavigationView {
                ScrollView {
                    VStack (spacing:20){
                        VStack (alignment : .center, spacing : -20){
                            
                            WebImage(url: URL(string: restaurant.photoURL ?? ""))
                                .resizable()
                                .indicator(.activity)
                                .transition(.fade(duration: 0.5))
                                .frame(width: geometry.size.width, height: 300, alignment: .center)
                                .scaledToFit()
                                
    //                        Image("cake-sample")
    //                            .resizable()
    //                            .background(Color.white)
    //                            .frame(width: geometry.size.width, height: 300, alignment: .center)
    //                            .scaledToFill()
                            
                            VStack {
                                VStack (alignment : .leading, spacing : 10){
                                    
                                    HStack {
                                        Text(restaurant.name ?? "Burger")
                                            .foregroundColor(Color.pink)
                                            .fontWeight(.bold)
                                            .font(.system(size: 35))
                                            .lineLimit(nil)
                                        
                                        Spacer()
                                        Image(systemName: "heart")
                                            .foregroundColor(.red)
                                            .frame(width: 25, height: 30, alignment: .center)
                                        
                                    }
                                    
                                    HStack {
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.red)
                                            .frame(width: 25, height: 30, alignment: .center)
                                        Text(String(format: "%.1f", restaurant.rating ?? 0))
                                            .foregroundColor(.red)
                                        Text("(\(restaurant.rateCount ?? 0) ratings)")
                                            .foregroundColor(.gray)
                                        Text(restaurant.category ?? "")
                                            .foregroundColor(.gray)
                                    }
                                    
                                    HStack {
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.red)
                                            .frame(width: 25, height: 30, alignment: .center)
                                        Text(restaurant.address ?? "")
                                            .foregroundColor(.gray)
                                    }
                                    
                                    //Spacer()
                                }
                                .frame(width :geometry.size.width - 30)
                                .padding(.top,20)
                                
                                VStack (alignment : .leading){
                                    Text("Popular Choice")
                                        .foregroundColor(Color.black)
                                        .fontWeight(.bold)
                                        .font(.system(size: 25))
                                        .lineLimit(nil)
                                        .padding(.leading)
                                    
                                    ScrollView (.horizontal) {
                                        LazyHGrid(rows: [GridItem(.flexible())]){
                                            ForEach((restaurant.foodList ?? []), id: \.id){ food in
                                           // ForEach(0..<10) { food in
                                                
                                                VStack (alignment: .leading){
                                                    
                                                    WebImage(url: URL(string: food.photoURL ?? ""))
                                                        .resizable()
                                                        .indicator(.activity)
                                                        .transition(.fade(duration: 0.5))
                                                        .frame(width: 150, height: 150, alignment: .center)
                                                        .scaledToFit()
                                                        
    //                                                Image("food-sample")
    //                                                    .resizable()
    //                                                    .frame(width: 150, height: 150, alignment:.center)
    //                                                    .scaledToFill()
                                                    
                                                    Text(food.name ?? "")
                                                    //Text("Tea")
                                                        .foregroundColor(.black)
                                                        .fontWeight(.bold)
                                                        .font(.title3)
                                                        .lineLimit(nil)
                                                    
                                                    Text(String(format: "%.1f", food.price ?? 0.0))
                                                    //Text("$1000")
                                                        .foregroundColor(.black)
                                                }
                                                
                                            }
                                        }.frame(height: 250, alignment: .center)
                                        .padding([.leading, .trailing])
                                    }
                                    //.frame(width: geometry.size.width, alignment: .center)
                                    .padding([.leading, .trailing])
                                    //Spacer()
                                }
                                .padding([.top,.bottom])
                                .background(Color.init(UIColor.systemGray5))
                                .cornerRadius(20)
                                
                            }
                            .padding([.top])
                            .background(Color.init(UIColor.systemGray5))
                            .cornerRadius(20)
                            
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                        .background(Color.white)
                        .cornerRadius(30)
                        
                        
                        VStack {
                            LazyVGrid(columns: [GridItem(.flexible())] , spacing: 20) {
                                ForEach(restaurant.foodList ?? [], id: \.id){ food in
                                //ForEach(0..<10) { food in
                                    Button(action: {
                                        mViewModel.onTapFood(food: food, restaurant: restaurant)
                                    }, label: {
                                        
                                        FoodInfoView(food: food)
                                    })
                                    
                                }
                            }
                            .frame(width:geometry.size.width - 30,alignment: .leading)
                            .background(Color.init(UIColor.systemGray5))
                            
                            //Spacer()
                            
                            NavigationLink(
                                destination: CartInfoView(restaurant: restaurant),
                                isActive: $mViewModel.isNavigateToCartScreen) {
                                Button(action: {
                                    
                                    self.mViewModel.isNavigateToCartScreen = true
                                    
                                }, label: {
                                    Text("View My Cart")
                                })
                                .frame(width: geometry.size.width, height: 45, alignment: .center)
                                .accentColor(.white)
                                .background(Color.pink)
                                .addBorder(Color.white, width: 1, cornerRadius: 20)
                                
                            }
                            
                        }
                    }.background(Color.init(UIColor.systemGray5))
                    
                }
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                //.edgesIgnoringSafeArea([.top, .bottom])
                .navigationBarHidden(true)
            }
            
        }
    }
}

struct RestaurantDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantDetailView(restaurant: RestaurantVO())
    }
}

struct FoodInfoView: View {
    
    var food : FoodVO
    
    var body: some View {
        VStack (alignment:.leading, spacing: 10){
            HStack {
                Text(food.name ?? "")
                    //Text("Tea")
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                    .font(.title3)
                    .lineLimit(nil)
                Spacer()
                Text("\(food.currency ?? "Ks")\(String(format: "%.1f", food.price ?? 0.0))")
                    //Text("$100")
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                    .font(.title3)
                
            }
            HStack {
                Text(food.ingredients ?? "")
                    //Text("Sugar")
                    .foregroundColor(.gray)
                    .lineLimit(nil)
                Spacer()
                Image(systemName: food.popularFlag ?? false ? "star.fill" : "star")
                    .foregroundColor(.red)
                    .frame(width: 25, height: 30, alignment: .center)
                Text("Popular")
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
    }
}
