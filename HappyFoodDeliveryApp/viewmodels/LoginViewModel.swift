//
//  LoginViewModel.swift
//  HappyFoodDeliveryApp
//
//  Created by Khin Yadanar Thein on 30/10/2020.
//

import Foundation
import SwiftUI
import Combine


class LoginViewModel: ObservableObject {
    @Published var mEmail : String = "";
    @Published var mPassword : String = "";
    
    @Published var isError : Bool = false;
    @Published var errorMessage: String = "";
    
    @Published var isNavigateToRegisterScreen : Bool = false;
    @Published var isNavigateToHomeScreen : Bool = false;
  
    let mAuthenticationModel : AuthenticationModel = AuthenticationModelImpl()
    
    func onTapLogin() {
        mAuthenticationModel.login(email: mEmail, password: mPassword) {
            self.isNavigateToHomeScreen = true
            
        } onFailure: { (error) in
            DispatchQueue.main.async {
                self.errorMessage = error
                self.isError = true
            }
        }

    }
}
