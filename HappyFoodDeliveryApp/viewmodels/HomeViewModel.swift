//
//  HomeViewModel.swift
//  HappyFoodDeliveryApp
//
//  Created by Khin Yadanar Thein on 31/10/2020.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var categories : [CategoryVO] = []
    @Published var restaurants : [RestaurantVO] = []
    @Published var popularChoices : [RestaurantVO] = []
    @Published var detailInfo = RestaurantVO()
    
    @Published var mEmail : String = "";
    @Published var mPassword : String = "";
    
    @Published var isError : Bool = false;
    @Published var errorMessage: String = "";
    
    @Published var isNavigateToRegisterScreen : Bool = false;
    @Published var isNavigateToDetailScreen : Bool = false;
    
    let mModel : DataModel = DataModelImpl()
    
    // list view style
    @Published var listStyle : Int = 0
    
    init() {
        listStyle = mModel.getListStyle()
        mModel.getCategories(success: { (categorylist) in
            self.categories = categorylist
            
        }) { (error) in
            
        }
        
        mModel.getRestaurants { (restaurantList) in
            self.restaurants = restaurantList
            
            self.popularChoices = restaurantList.filter({$0.popularFlag ?? false})
        } fail: { (error) in
            
        }

    }
}
