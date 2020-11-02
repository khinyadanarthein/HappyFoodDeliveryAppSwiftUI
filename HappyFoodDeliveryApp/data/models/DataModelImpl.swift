//
//  DataModelImpl.swift
//  HappyFoodDeliveryApp
//
//  Created by Khin Yadanar Thein on 01/11/2020.
//

import Foundation
import CoreData
import FirebaseRemoteConfig

class DataModelImpl: DataModel {
    
    let firebaseRemoteConfig : FirebaseRemoteConfigManager = FirebaseRemoteConfigManager.shared
    let api : FirebaseApi = FirebaseApiClient()
    
    func setupRemoteConfigDefaultVlaues() {
        firebaseRemoteConfig.setUpRemoteConfigWithDefaultValues()
    }
    
    func fetchRemoteConfigs() {
        firebaseRemoteConfig.fetchRemoteConfig()
    }
    
    func getListStyle() -> Int {
        return firebaseRemoteConfig.getListStyle()
    }
    
    func getCategories(success: @escaping ([CategoryVO]) -> Void, fail: @escaping (String) -> Void) {
        api.getCategories(success: success, fail: fail)
    }
    
    func getRestaurants(success: @escaping ([RestaurantVO]) -> Void, fail: @escaping (String) -> Void) {
        api.getRestaurants(success: success, fail: fail)
    }
    
    func addToCart(cartData: CartVO, success: @escaping (String) -> Void, fail: @escaping (String) -> Void) {
        api.addCart(cartData: cartData, success: success, fail: fail)
    }
    
    func getTotalCart(cartData : CartVO,success: @escaping (TotalCartVO) -> Void, fail: @escaping (String) -> Void) {
        api.getTotalCartVO(cartInfo: cartData, success: success, fail: fail)
    }
    
    func updateTotalCart(cartData: CartVO, success: @escaping (String) -> Void, fail: @escaping (String) -> Void) {
        api.updateTotalCartVO(cartData: cartData, success: success, fail: fail)
    }
    
    func deleteCartFood(cartData: CartVO, success: @escaping (String) -> Void, fail: @escaping (String) -> Void) {
        api.deleteCartFoodItem(cartData: cartData, success: success, fail: fail)
    }
    
    func checkoutCartFood(cartData: TotalCartVO, success: @escaping (String) -> Void, fail: @escaping (String) -> Void) {
        api.updateCheckoutCart(cartData: cartData, success: success, fail: fail)
    }
}
