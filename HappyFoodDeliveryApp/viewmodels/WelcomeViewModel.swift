//
//  WelcomeViewModel.swift
//  HappyFoodDeliveryApp
//
//  Created by Khin Yadanar Thein on 31/10/2020.
//

import Foundation
import SwiftUI
import Combine

class WelcomeViewModel: ObservableObject {
    @Published var mEmail : String = "";
    @Published var mPassword : String = "";
    
    @Published var isError : Bool = false;
    @Published var errorMessage: String = "";
    
    @Published var isNavigateToRegisterScreen : Bool = false;
    @Published var isNavigateToLoginScreen : Bool = false;
  
}
