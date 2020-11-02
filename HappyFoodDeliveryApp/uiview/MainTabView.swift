//
//  MainTabView.swift
//  HappyFoodDeliveryApp
//
//  Created by Khin Yadanar Thein on 31/10/2020.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        
        TabView {
            HomeStyle1UIView()
            .tabItem {(
                VStack {
                    Image(systemName: "house.fill")
                        .font(.system(size: 24, weight: .regular))
                    //Text("home")
                }
                )}
            .tag(0)

            WelcomeUIView()
            .tabItem {(
                VStack {
                    Image(systemName: "flame.fill").font(.system(size: 24, weight: .regular))
                    //Text("search")
                    }

                )}
            .tag(1)
            
            
            ProfileUIView()
                .tabItem {(
                    VStack {
                        Image(systemName: "person.fill").font(.system(size: 24, weight: .regular))
                        //Text("cloud")
                    }
                    
                    )}
                .tag(2)
            
        }.accentColor(.pink)
        
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
