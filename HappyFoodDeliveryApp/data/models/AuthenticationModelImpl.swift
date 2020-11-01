//
//  AuthenticationModelImpl.swift
//  HappyFoodDeliveryApp
//
//  Created by Khin Yadanar Thein on 01/11/2020.
//

import Foundation

class AuthenticationModelImpl : AuthenticationModel{
    
    let mAuth : AuthManager = FirebaseAuthManagerImpl()
    
    func login(email: String, password: String, onSuccess: @escaping () -> Void, onFailure: @escaping (String) -> Void) {
        mAuth.login(email: email, password: password, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    func register(userInfo: UserInfoVO, onSuccess: @escaping () -> Void, onFailure: @escaping (String) -> Void) {
        mAuth.register(userInfo: userInfo, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    func getUserInfo() -> UserInfoVO {
        return mAuth.getUserInfo()
    }
    
    func updateProfile(imageData: Data, info: UserInfoVO, success: @escaping (String) -> Void, fail: @escaping (String) -> Void) {
        mAuth.updateUserInfo(imageData: imageData, info: info, success: success, fail: fail)
    }
}
