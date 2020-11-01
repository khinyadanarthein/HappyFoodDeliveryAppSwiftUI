//
//  ProfileViewModel.swift
//  HappyFoodDeliveryApp
//
//  Created by Khin Yadanar Thein on 31/10/2020.
//

import Foundation
import SwiftUI
import Combine
import CoreData

class ProfileViewModel: ObservableObject {
    @Published var mEmail : String = "";
    @Published var mPassword : String = "";
    @Published var mUserName : String = "";
    @Published var mPhone : String = "";
    @Published var photo : UIImage = UIImage(named: "default-profile")!
    @Published var showImageloading : Bool = true
    @Published var isShowingImage : Bool = false
    
    @Published var isError : Bool = false;
    @Published var errorMessage: String = "";
    
    @Published var isNavigateToRegisterScreen : Bool = false;
    @Published var isNavigateToHomeScreen : Bool = false;
    
    @Published var showIndicator : Bool = false;
    
    let mAuthenticationModel : AuthenticationModel = AuthenticationModelImpl()
    
    init() {
//        let context = PersistentCloudKitContainer.persistentContainer.viewContext
//        let info = mDataModel.getUserProfile(context: context)
        
        let info = mAuthenticationModel.getUserInfo()
        self.mEmail = info.email ?? ""
        self.mPassword = info.password ?? ""
        self.mUserName = info.name ?? ""
        self.photo = UIImage(named: "default-profile")!
        self.showImageloading = false
        //print(info.image)
        DispatchQueue.global(qos: .background).async {
            do
            {
                let data = try Data.init(contentsOf: URL.init(string:info.image ?? "")!)
                DispatchQueue.main.async {
                    // closed indicator
                    self.photo = UIImage(data: data) ?? UIImage()
                    self.showImageloading = false
                }
            }
            catch {
                self.photo = UIImage(named: "default-profile")!

            }
        }
    }
    
    func editUserInfo() {
        showIndicator = true
        let imagaData = photo.jpegData(compressionQuality: 0.5) ?? Data()
        let userInfo = UserInfoVO()
        userInfo.name = mUserName
        userInfo.email = mEmail
        userInfo.password = mPassword
        
        mAuthenticationModel.updateProfile(imageData: imagaData, info: userInfo) { (message) in
            DispatchQueue.main.async {
                self.errorMessage = message
                self.isError = true
                self.showIndicator = false
            }
            
        } fail: { (error) in
            DispatchQueue.main.async {
                self.errorMessage = error
                self.isError = true
                self.showIndicator = false
            }
        }

    }
    func onChangeImage(image : UIImage) {
        self.photo = image
    }
}
