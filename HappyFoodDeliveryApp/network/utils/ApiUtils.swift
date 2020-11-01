//
//  ApiUtils.swift
//  HappyFoodDeliveryApp
//
//  Created by Khin Yadanar Thein on 01/11/2020.
//

import Foundation

class ApiUtils {
    static let shared : ApiUtils = ApiUtils()
    
    private init() {}
    
    func getFoodList(foodDic : [String : AnyObject]) -> FoodVO {
        let food = FoodVO()
        food.id = foodDic["id"] as? Int ?? 0
        food.name = foodDic["name"] as? String ?? ""
        food.ingredients = foodDic["ingredients"] as? String ?? ""
        food.price = foodDic["price"] as? Double ?? 0.0
        food.currency = foodDic["currency"] as? String ?? ""
        food.type = foodDic["type"] as? String ?? ""
        food.popularFlag = foodDic["popular_flag"] as? Bool ?? false
        food.photoURL = foodDic["photo_url"] as? String ?? ""
        
        return food
    }
    
    func getRestaurant(resDic : [String:Any], food : [FoodVO]) -> RestaurantVO {
        let restaurant = RestaurantVO()
        restaurant.id = resDic["id"] as? String ?? ""
        restaurant.name = resDic["name"] as? String ?? ""
        restaurant.address = resDic["address"] as? String ?? ""
        restaurant.category = resDic["category"] as? String ?? ""
        restaurant.popularFlag = resDic["popular_flag"] as? Bool ?? false
        restaurant.rating = resDic["rating"] as? Double ?? 0.0
        restaurant.rateCount = resDic["rate_count"] as? Int ?? 0
        restaurant.photoURL = resDic["photo_url"] as? String ?? ""
        restaurant.foodList = food
        
        return restaurant
    }
    
   
}
