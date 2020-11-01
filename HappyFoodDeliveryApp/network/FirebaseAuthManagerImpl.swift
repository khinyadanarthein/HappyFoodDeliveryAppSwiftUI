//
//  FirebaseAuthManagerImpl.swift
//  HappyFoodDeliveryApp
//
//  Created by Khin Yadanar Thein on 01/11/2020.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class FirebaseAuthManagerImpl: AuthManager {
    
    let firebaseAuth = Auth.auth()
    let storage = Storage.storage()
    
    func login(email: String, password: String, onSuccess: @escaping () -> Void, onFailure: @escaping (String) -> Void) {
        
        firebaseAuth.signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                onFailure(error.localizedDescription)
            } else {
                onSuccess()
            }
        }
    }
    
    func register(userInfo: UserInfoVO, onSuccess: @escaping () -> Void, onFailure: @escaping (String) -> Void) {
        
        firebaseAuth.createUser(withEmail: userInfo.email!, password: userInfo.password!) { (result, error) in
            
            if let error = error {
                onFailure(error.localizedDescription)
            } else {
                guard let user = self.firebaseAuth.currentUser else { return }
                let changeRequest = user.createProfileChangeRequest()
                changeRequest.displayName = userInfo.name ?? ""
                changeRequest.commitChanges { (error) in
                    if let error = error {
                        onFailure(error.localizedDescription)
                    } else {
                        
                        onSuccess()
                    }
                }
            }
        }
    }
    
    func getUserInfo() -> UserInfoVO {
        guard let user = self.firebaseAuth.currentUser else { return UserInfoVO()}
        let userInfo = UserInfoVO()
        userInfo.name = user.displayName ?? ""
        userInfo.email = user.email ?? ""
        userInfo.image = user.photoURL?.absoluteString
        return userInfo
    }
    
    func updateUserInfo(imageData: Data, info: UserInfoVO, success: @escaping (String) -> Void, fail: @escaping (String) -> Void) {
        let storageRef = storage.reference()
        
        let userImageRef = storageRef.child("images/\(info.email!).jpg")

        userImageRef.putData(imageData, metadata: nil) { (metadata, error) in
            userImageRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    return
                }
                info.image = downloadURL.absoluteString
                guard let user = self.firebaseAuth.currentUser else { return }
                let changeRequest = user.createProfileChangeRequest()
                changeRequest.displayName = info.name ?? ""
                changeRequest.photoURL = downloadURL
                changeRequest.commitChanges { (error) in
                    if let error = error {
                        fail(error.localizedDescription)
                    } else {
                        
                        success("Success")
                    }
                }
                success("success")
            }
        }
    }
    
    
}
