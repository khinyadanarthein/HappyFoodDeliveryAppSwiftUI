//
//  FirebaseApi.swift
//  HappyFoodDeliveryApp
//
//  Created by Khin Yadanar Thein on 01/11/2020.
//

import Foundation

protocol FirebaseApi {
    func getCategories(success : @escaping ([CategoryVO]) -> Void, fail : @escaping (String) -> Void)
    func getRestaurants(success : @escaping ([RestaurantVO]) -> Void, fail : @escaping (String) -> Void)
    func addCart(cartData : CartVO, success : @escaping (String) -> Void, fail : @escaping (String) -> Void)
    func getTotalCartVO(success : @escaping (TotalCartVO) -> Void, fail : @escaping (String) -> Void)
    
}
