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
            "restaurant_rating" : cartData.restaurant?.rating ?? 0.0,
            "restaurant_count" : cartData.restaurant?.rateCount ?? 0,
            "subtotal" : cartData.totalPrice ?? 0.0,
            "delivery_fee" : cartData.deliveryFee ?? 0.0
        ]
        
        let foodCartDic : [String:Any] = [
            "id" : "\(cartData.restaurant?.name ?? "")_\(cartData.cartFood?.name ?? "")" ,
            "name" : cartData.cartFood?.name ?? "",
            "price" : cartData.cartFood?.price ?? 0.0,
            "quantity" : cartData.cartFood?.quantity ?? 0
        ]
        
        let documentId = "\(cartData.userId ?? "")_\(cartData.restaurant?.name ?? "")"
        
        db.collection("cart").document(documentId).setData(cartDic) { err in
            if let error = err{
                print("Failed to add data => \(error.localizedDescription)")
            } else{
                print("Successfully add data")
                self.db.collection("cart").document(documentId).collection("cartFoods").document(cartData.cartFood?.name ?? "").setData(foodCartDic) { err  in
                    if let error = err{
                        print("Failed to add data => \(error.localizedDescription)")
                    } else{
                        print("Successfully add food data")
                    }
                    
                }
            }
        }
    }
    
    func getTotalCartVO(cartInfo: CartVO, success: @escaping (TotalCartVO) -> Void, fail: @escaping (String) -> Void) {
        
        let documentId = "\(cartInfo.userId ?? "")_\(cartInfo.restaurant?.name ?? "")"
        
        db.collection("cart").document(documentId).addSnapshotListener { (documentSnapshot, error) in
            
            let totalCart = TotalCartVO()
            
            if let data = documentSnapshot?.data() {
                
                totalCart.id = data["id"] as? String ?? ""
                totalCart.deliveryFee = data["delivery_fee"] as? Double ?? 0.0
                totalCart.totalPrice = data["total_price"] as? Double ?? 0.0
                totalCart.restaurantName = data["restaurant_name"] as? String ?? ""
                totalCart.restaurantAddress = data["restaurant_address"] as? String ?? ""
                totalCart.restaurantCount = data["restaurant_count"] as? Int ?? 0
                totalCart.restaurantRating = data["restaurant_rating"] as? Double ?? 0.0
                
                var cartList = [CartFoodVO]()
                
                self.db.collection("cart").document(documentId).collection("cartFoods").addSnapshotListener { (snapshot, error) in
                    snapshot?.documents.forEach({ (singleSnapshot) in
                        
                        let cart = CartFoodVO()
                        let data = singleSnapshot.data()
                        cart.id = data["id"] as? String ?? ""
                        cart.name = data["name"] as? String ?? ""
                        cart.price = data["price"] as? Double ?? 0.0
                        cart.quantity = data["quantity"] as? Int ?? 0
                        
                        cartList.append(cart)
                    })
                    totalCart.cartFoodList = cartList
                    success(totalCart)
                }
            }
        }
    }
    
    func updateTotalCartVO(cartData: CartVO, success: @escaping (String) -> Void, fail: @escaping (String) -> Void) {
        
        let cartDic : [String:Any] = [
            "id" : "\(cartData.userId ?? "")_\(cartData.restaurant?.name ?? "")" ,
            "restaurant_name" : cartData.restaurant?.name ?? "",
            "restaurant_address" : cartData.restaurant?.address ?? "",
            "restaurant_rating" : cartData.restaurant?.rating ?? 0.0,
            "restaurant_count" : cartData.restaurant?.rateCount ?? 0,
            "subtotal" : cartData.totalPrice ?? 0.0,
            "delivery_fee" : cartData.deliveryFee ?? 0.0,
            "is_checkout" : cartData.isCheckout ?? false
        ]
        
        let foodCartDic : [String:Any] = [
            "id" : "\(cartData.cartFood?.id ?? "")" ,
            "name" : cartData.cartFood?.name ?? "",
            "price" : cartData.cartFood?.price ?? 0.0,
            "quantity" : cartData.cartFood?.quantity ?? 0,
        ]
        
        let documentId = "\(cartData.userId ?? "")_\(cartData.restaurant?.name ?? "")"
        
        db.collection("cart").document(documentId).setData(cartDic) { err in
            if let error = err{
                print("Failed to update cart data => \(error.localizedDescription)")
            } else{
                print("Successfully update cart data")
                self.db.collection("cart").document(documentId).collection("cartFoods").document(cartData.cartFood?.name ?? "").setData(foodCartDic) { err  in
                    if let error = err{
                        print("Failed to update cart data => \(error.localizedDescription)")
                    } else{
                        print("Successfully update cart data")
                        success("success")
                    }
                    
                }
            }
        }
    }

    func deleteCartFoodItem(cartData: CartVO, success: @escaping (String) -> Void, fail: @escaping (String) -> Void) {
        let documentId = "\(cartData.userId ?? "")_\(cartData.restaurant?.name ?? "")"
        
        db.collection("cart")
            .document(documentId)
            .collection("cartFoods")
            .document(cartData.cartFood?.name ?? "")
            .delete { (error) in
                if let err = error{
                    print("Failed to delete data => \(err.localizedDescription)")
                } else{
                    print("Successfully delete data")
                    success("success")
                }
            }
    }
    
    func updateCheckoutCart(cartData: TotalCartVO, success: @escaping (String) -> Void, fail: @escaping (String) -> Void) {
        
        let cartDic : [String:Any] = [
            "id" : "\(cartData.id ?? "")" ,
            "restaurant_name" : cartData.restaurantName ?? "",
            "restaurant_address" : cartData.restaurantAddress ?? "",
            "restaurant_rating" : cartData.restaurantRating ?? 0.0,
            "restaurant_count" : cartData.restaurantCount ?? 0,
            "subtotal" : cartData.totalPrice ?? 0.0,
            "delivery_fee" : cartData.deliveryFee ?? 0.0,
            "is_checkout" : cartData.isCheckout ?? false
        ]
        db.collection("cart").document(cartData.id ?? "").setData(cartDic) { err in
            if let error = err{
                print("Failed to update cart data => \(error.localizedDescription)")
            } else{
                print("Successfully update cart data")
                success("success")
            }
        }
    }
}
