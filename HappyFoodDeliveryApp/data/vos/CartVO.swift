//
//  CartVO.swift
//  HappyFoodDeliveryApp
//
//  Created by Khin Yadanar Thein on 02/11/2020.
//

import Foundation
class CartVO: Identifiable {
    var userId : String?
    var totalPrice : Double?
    var deliveryFee : Double?
    var isCheckout : Bool?
    var restaurant : RestaurantVO?
    var cartFood : CartFoodVO?
    
}

class CartFoodVO : Identifiable {
    var id : String?
    var name : String?
    var price : Double?
    var quantity : Int?
}

class TotalCartVO : Identifiable {
    var id : String?
    var totalPrice : Double?
    var deliveryFee : Double?
    var isCheckout : Bool?
    var restaurantName : String?
    var restaurantAddress : String?
    var restaurantRating : Double?
    var restaurantCount : Int?
    var cartFoodList : [CartFoodVO]?
}
