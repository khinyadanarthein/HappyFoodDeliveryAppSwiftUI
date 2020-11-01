//
//  AuthenticationModel.swift
//  HappyFoodDeliveryApp
//
//  Created by Khin Yadanar Thein on 01/11/2020.
//

import Foundation

protocol AuthenticationModel {
    func login(email: String, password: String, onSuccess: @escaping () -> Void, onFailure: @escaping (String) -> Void)
    func register(userInfo: UserInfoVO, onSuccess: @escaping  () -> Void, onFailure: @escaping (String) -> Void)
    func getUserInfo() -> UserInfoVO
    func updateProfile(imageData : Data, info : UserInfoVO,success : @escaping (String) -> Void, fail : @escaping (String) -> Void)
}
