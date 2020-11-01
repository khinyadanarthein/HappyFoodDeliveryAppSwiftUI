//
//  DetailViewModel.swift
//  HappyFoodDeliveryApp
//
//  Created by Khin Yadanar Thein on 01/11/2020.
//

import Foundation
class DetailViewModel: ObservableObject {
    
    @Published var popularChoices : [FoodVO] = []
    @Published var detailInfo = RestaurantVO()
    
    var userInfo = UserInfoVO()
    @Published var isNavigateToCartScreen : Bool = false;
    
    let mModel : DataModel = DataModelImpl()
    let mAuthenticationModel : AuthenticationModel = AuthenticationModelImpl()
    
    init() {
        userInfo = mAuthenticationModel.getUserInfo()
    }
    
    func onTapFood(food : FoodVO, restaurant: RestaurantVO) {
        let cart = CartVO()
        cart.restaurant = restaurant
        cart.userId = "\(userInfo.email ?? "")"
        cart.deliveryFee = 0.0
        cart.isCheckout = false
        
        let cartFood = CartFoodVO()
        cartFood.name = food.name
        cartFood.price = food.price ?? 0.0
        cartFood.quantity = 1
        cart.cartFood = cartFood
        
        mModel.addToCart(cartData: cart) { (message) in
            print("success add cart")
            
        } fail: { (error) in
            print(error)
        }

        
    }
    
}
