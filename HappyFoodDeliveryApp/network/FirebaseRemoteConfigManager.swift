//
//  FirebaseRemoteConfigManager.swift
//  HappyFoodDeliveryApp
//
//  Created by Khin Yadanar Thein on 01/11/2020.
//

import Foundation
import FirebaseRemoteConfig

class FirebaseRemoteConfigManager {
    
    static let shared = FirebaseRemoteConfigManager()
    
    private init(){}
    
    let remoteConfig : RemoteConfig = {
        let config = RemoteConfig.remoteConfig()
        let setting = RemoteConfigSettings()
        setting.minimumFetchInterval = 0
        config.configSettings = setting
        return config
    }()
    
    func setUpRemoteConfigWithDefaultValues() {
        let defaultValues = ["list_style" : "0" as NSObject]
        remoteConfig.setDefaults(defaultValues)
    }
    
    func fetchRemoteConfig() {
        remoteConfig.fetch { (status, error) in
            if status == .success {
                print("fetched config")
                self.remoteConfig.activate { (changed, error) in
                    print("confid updated")
                }
            } else {
                print("fetched failed")
            }
        }
    }
    
    func getListStyle() -> Int {
        let value = remoteConfig.configValue(forKey: "list_style").stringValue ?? "0"
        return Int(value) ?? 0
    }
}
