//
//  CartViewModel.swift
//  HappyFoodDeliveryApp
//
//  Created by Khin Yadanar Thein on 02/11/2020.
//

import Foundation

class CartViewModel: ObservableObject {
    
    @Published var totalCartVO = TotalCartVO()
    @Published var isShowBottomSheet : Bool = true;
    @Published var cartFoodList = [CartFoodVO]()
    
    var userInfo = UserInfoVO()
    var cartVO = CartVO()
    
    let mModel : DataModel = DataModelImpl()
    let mAuthenticationModel : AuthenticationModel = AuthenticationModelImpl()
    
    init() {
        userInfo = mAuthenticationModel.getUserInfo()
    }
    
    func prepareCartInfo(restaurant : RestaurantVO) {
        cartVO = CartVO()
        cartVO.userId = userInfo.email
        cartVO.restaurant = restaurant
        
        
        mModel.getTotalCart(cartData: cartVO) { (totalCart) in
            
            var total = 0.0
            for cart in totalCart.cartFoodList ?? [] {
                total += ((cart.price ?? 0.0) * Double(cart.quantity ?? 1))
            }
            
            DispatchQueue.main.async {
                totalCart.totalPrice = total
                self.totalCartVO = totalCart
                if self.cartFoodList.count == 0 {
                    self.cartFoodList = totalCart.cartFoodList ?? []
                }
                
            }
            
        } fail: { (error) in
            print(error)
        }

    }
    
    func onTapIncreaseItem (cartFood : CartFoodVO) {
        
        let cart = CartVO()
        cart.restaurant = cartVO.restaurant
        cart.userId = "\(userInfo.email ?? "")"
        cart.deliveryFee = 0.0
        cart.isCheckout = false
        cart.totalPrice = totalCartVO.totalPrice
        
        var index = 0
        for food in self.cartFoodList {
            if food.id == cartFood.id {
                food.quantity! += 1
                self.cartFoodList[index].quantity = food.quantity
                
                let cartFood = CartFoodVO()
                cartFood.id = food.id
                cartFood.name = food.name
                cartFood.price = food.price ?? 0.0
                cartFood.quantity = food.quantity
                cart.cartFood = cartFood
                
                mModel.updateTotalCart(cartData: cart) { (message) in
                    print("success increase")
                    
                } fail: { (error) in
                    print(error)
                }

            }
            index += 1
        }
    }
    
    func onTapdecreaseItem (cartFood : CartFoodVO) {
        
        let cart = CartVO()
        cart.restaurant = cartVO.restaurant
        cart.userId = "\(userInfo.email ?? "")"
        cart.deliveryFee = 0.0
        cart.isCheckout = false
        cart.totalPrice = totalCartVO.totalPrice
        
        var index = 0
        for food in self.cartFoodList {
            if food.id == cartFood.id {
                food.quantity! -= 1
                self.cartFoodList[index].quantity = food.quantity
                
                let cartFood = CartFoodVO()
                cartFood.id = food.id
                cartFood.name = food.name
                cartFood.price = food.price ?? 0.0
                cartFood.quantity = food.quantity
                cart.cartFood = cartFood
                
                if let foodQuantity = cartFood.quantity {
                    
                    if foodQuantity == 0 {
                        mModel.deleteCartFood(cartData: cart) { (message) in
                            print("success delete")
                            
                        } fail: { (error) in
                            print(error)
                        }
                    } else {
                        mModel.updateTotalCart(cartData: cart) { (message) in
                            print("success decrease")
                            
                        } fail: { (error) in
                            print(error)
                        }
                    }
                }
            }
            index += 1
        }
    }
    
    func checkoutCart() {
        
        totalCartVO.isCheckout = true
        mModel.checkoutCartFood(cartData: totalCartVO) { (message) in
            print("success checkout")
            self.isShowBottomSheet = false
            
        } fail: { (error) in
            print(error)
        }
    }
}
