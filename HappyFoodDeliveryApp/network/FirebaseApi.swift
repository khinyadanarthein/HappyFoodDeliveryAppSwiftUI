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
    func getTotalCartVO(cartInfo: CartVO,success : @escaping (TotalCartVO) -> Void, fail : @escaping (String) -> Void)
    func updateTotalCartVO(cartData: CartVO,success : @escaping (String) -> Void, fail : @escaping (String) -> Void)
    func deleteCartFoodItem(cartData: CartVO,success : @escaping (String) -> Void, fail : @escaping (String) -> Void)
    func updateCheckoutCart(cartData: TotalCartVO,success : @escaping (String) -> Void, fail : @escaping (String) -> Void)
}
