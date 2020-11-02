//
//  DataModel.swift
//  HappyFoodDeliveryApp
//
//  Created by Khin Yadanar Thein on 01/11/2020.
//

import Foundation
import CoreData

protocol DataModel {
    
    func getCategories(success : @escaping ([CategoryVO]) -> Void, fail : @escaping (String) -> Void)
    func getRestaurants(success : @escaping ([RestaurantVO]) -> Void, fail : @escaping (String) -> Void)
    func addToCart(cartData : CartVO,success : @escaping (String) -> Void, fail : @escaping (String) -> Void)
    func getTotalCart(cartData : CartVO,success : @escaping (TotalCartVO) -> Void, fail : @escaping (String) -> Void)
    func updateTotalCart(cartData : CartVO,success : @escaping (String) -> Void, fail : @escaping (String) -> Void)
    func deleteCartFood(cartData : CartVO,success : @escaping (String) -> Void, fail : @escaping (String) -> Void)
    func checkoutCartFood(cartData : TotalCartVO,success : @escaping (String) -> Void, fail : @escaping (String) -> Void)
    
    func setupRemoteConfigDefaultVlaues()
    func fetchRemoteConfigs()
    func getListStyle() -> Int

}
