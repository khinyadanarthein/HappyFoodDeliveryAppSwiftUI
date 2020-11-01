//
//  StartAppViewModel.swift
//  HappyFoodDeliveryApp
//
//  Created by Khin Yadanar Thein on 01/11/2020.
//

import Foundation
import SwiftUI
import Combine

class StartAppViewModel: ObservableObject {
    
    let mModel : DataModel = DataModelImpl()
    
    init() {
        mModel.setupRemoteConfigDefaultVlaues()
        mModel.fetchRemoteConfigs()
    }
}
 
