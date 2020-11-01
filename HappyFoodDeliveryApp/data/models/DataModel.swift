//
//  DataModel.swift
//  HappyFoodDeliveryApp
//
//  Created by Khin Yadanar Thein on 01/11/2020.
//

import Foundation

protocol DataModel {
    
//    func getGroceries(success : @escaping ([GroceryVO]) -> Void, fail : @escaping (String) -> Void)
//    func addGrocery(grocery : GroceryVO, image : Data,success : @escaping (String) -> Void, fail : @escaping (String) -> Void)
//    func deleteGrocery(grocery : GroceryVO)
//    func onUploadImage(image : Data, grocery : GroceryVO ,success : @escaping (String) -> Void, fail : @escaping (String) -> Void)
    func setupRemoteConfigDefaultVlaues()
    func fetchRemoteConfigs()
    func getAppBarNameFromRemoteConfig() -> String
    func getListStyle() -> Int
}
