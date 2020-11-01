//
//  RestaurantVO.swift
//  HappyFoodDeliveryApp
//
//  Created by Khin Yadanar Thein on 01/11/2020.
//

import Foundation

// MARK: - RestaurantVO
class RestaurantVO: Identifiable {
    var id, name, address, category: String?
    var popularFlag: Bool?
    var rating: Double?
    var rateCount: Int?
    var photoURL: String?
    var foodList: [FoodVO]?
}

// MARK: - FoodVO
class FoodVO: Identifiable {
    var id: Int?
    var name, ingredients: String?
    var price: Double?
    var currency: String?
    var type: String?
    var popularFlag: Bool?
    var photoURL: String?

}

enum Currency: String, Codable {
    case ks = "Ks"
    case usd = "$"
}
