//
//  FirebaseApiClient.swift
//  HappyFoodDeliveryApp
//
//  Created by Khin Yadanar Thein on 01/11/2020.
//

import Foundation
import Firebase
import FirebaseFirestore

class FirebaseApiClient: FirebaseApi {
    
    let db = Firestore.firestore()
    
    func getCategories(success: @escaping ([CategoryVO]) -> Void, fail: @escaping (String) -> Void) {
        
        db.collection("categories").addSnapshotListener { (snapshot, error) in
            var categories = [CategoryVO]()
            
            snapshot?.documents.forEach({ (singleSnapshot) in
                
                let category = CategoryVO()
                category.id = singleSnapshot["id"] as? Int
                category.name = singleSnapshot["name"] as? String
                category.image = singleSnapshot["photoURL"] as? String
                
                categories.append(category)
                
            })
            success(categories)
        }
    }
    
    func getRestaurants(success: @escaping ([RestaurantVO]) -> Void, fail: @escaping (String) -> Void) {
        
        db.collection("Restaurants").addSnapshotListener { (snapshot, error) in
            var restaurants = [RestaurantVO]()
            
            snapshot?.documents.forEach({ (singleSnapshot) in
                
                let data = singleSnapshot.data()
                
                let foodListDic = data["food_list"] as? Array<Any> ?? []
                var foodList = [FoodVO]()
                for foodDic in foodListDic {
                    let food = foodDic as? [String: AnyObject] ?? [:]
                    foodList.append(ApiUtils.shared.getFoodList(foodDic: food))
                }
                
                let restaurant = ApiUtils.shared.getRestaurant(resDic: data, food:foodList)
                restaurants.append(restaurant)
            })
            success(restaurants)
        }
    }
    
    func addCart(cartData : CartVO, success: @escaping (String) -> Void, fail: @escaping (String) -> Void) {
        
        let cartDic : [String:Any] = [
            "id" : "\(cartData.userId ?? "")_\(cartData.restaurant?.name ?? "")" ,
            "restaurant_name" : cartData.restaurant?.name ?? "",
            "restaurant_address" : cartData.restaurant?.address ?? "",
            "subtotal" : cartData.totalPrice ?? 0.0,
            "delivery_fee" : cartData.deliveryFee ?? 0.0
        ]
        
        let foodCartDic : [String:Any] = [
            "id" : "\(cartData.restaurant?.name ?? "")_\(cartData.cartFood?.name ?? "")" ,
            "name" : cartData.cartFood?.name ?? "",
            "price" : cartData.cartFood?.price ?? 0.0,
            "quantity" : cartData.cartFood?.quantity ?? 0
        ]
        
        let id = "\(cartData.userId ?? "")_\(cartData.restaurant?.name ?? "")"
        
        
        db.collection("cart").document(id).setData(cartDic) { err in
            if let error = err{
                print("Failed to add data => \(error.localizedDescription)")
            } else{
                print("Successfully add data")
                self.db.collection("cart").document(id).collection(cartData.cartFood?.name ?? "").addDocument(data: foodCartDic) { err  in
                    if let error = err{
                        print("Failed to add data => \(error.localizedDescription)")
                    } else{
                        print("Successfully add food data")
                    }
                    
                }
            }
        }
    }
    
    func getTotalCartVO(success: @escaping (TotalCartVO) -> Void, fail: @escaping (String) -> Void) {
        
//        var query = db.collection("cart").where
//        db.collection("cart").addSnapshotListener { (snapshot, error) in
//            var cart = TotalCartVO()
//            
//            snapshot?.documents.forEach({ (singleSnapshot) in
//                
//                let data = singleSnapshot.data()
//                
//                let foodListDic = data["food_list"] as? Array<Any> ?? []
//                var foodList = [FoodVO]()
//                for foodDic in foodListDic {
//                    let food = foodDic as? [String: AnyObject] ?? [:]
//                    foodList.append(ApiUtils.shared.getFoodList(foodDic: food))
//                }
//                
//                let restaurant = ApiUtils.shared.getRestaurant(resDic: data, food:foodList)
//                restaurants.append(restaurant)
//            })
//            success(cart)
//        }
    }
}
