//
//  CartViewModel.swift
//  HappyFoodDeliveryApp
//
//  Created by Khin Yadanar Thein on 02/11/2020.
//

import Foundation

class CartViewModel: ObservableObject {
    
    @Published var totalCartVO = TotalCartVO()
    @Published var isSuccessCheckout : Bool = false;
    
    var userInfo = UserInfoVO()
    let mModel : DataModel = DataModelImpl()
    let mAuthenticationModel : AuthenticationModel = AuthenticationModelImpl()
    
    init() {
        userInfo = mAuthenticationModel.getUserInfo()
    }
}
