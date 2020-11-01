//
//  RegisterViewModel.swift
//  HappyFoodDeliveryApp
//
//  Created by Khin Yadanar Thein on 30/10/2020.
//

import Foundation
import Combine

class RegisterViewModel: ObservableObject {
    @Published var mEmail : String = "";
    @Published var mPassword : String = "";
    @Published var mUserName : String = "";
    @Published var mPhone : String = "";
    
    @Published var isError : Bool = false;
    @Published var errorMessage: String = "";
    
    @Published var isNavigateToLoginScreen : Bool = false;
    @Published var isNavigateToHomeScreen : Bool = false;
    @Published var isSuccess : Bool = false;
  
    let mAuthenticationModel : AuthenticationModel = AuthenticationModelImpl()
    
    init() {
        
    }
    
    func onTapRegister(onSuccess : @escaping () -> Void){
        
        let userInfo = UserInfoVO()
        userInfo.email = mEmail
        userInfo.password = mPassword
        userInfo.name = mUserName
        userInfo.phone = mPhone
        
        mAuthenticationModel.register(userInfo: userInfo) {
            self.isSuccess = true
            self.mUserName = ""
            self.mEmail = ""
            self.mPhone = ""
            self.mPassword = ""
            
        } onFailure: { (error) in
            DispatchQueue.main.async {
                self.errorMessage = error
                self.isError = true
            }
        }
    }
}
