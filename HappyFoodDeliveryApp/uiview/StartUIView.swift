//
//  StartUIView.swift
//  HappyFoodDeliveryApp
//
//  Created by Khin Yadanar Thein on 30/10/2020.
//

import SwiftUI

struct StartUIView: View {
    
    @State var isNavigateToWelcome : Bool = false
    
    @ObservedObject var mViewModel = StartAppViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                ScrollView {
                    VStack (alignment : .leading, spacing : -10){
                        Image("categories")
                            .resizable()
                            .background(Color.white)
                            .frame(width: geometry.size.width, height: 550, alignment: .center)
                            .scaledToFill()
                            
                        
                        VStack (alignment : .leading){
                            Text("Happy Meals")
                                .foregroundColor(Color.white)
                                .fontWeight(.bold)
                                .font(.system(size: 40))
                                .frame(width :geometry.size.width,height: 30, alignment: .leading)
                                .padding([.leading],30)
                               
                            Text("Discover the best foods from \nover 1,000 Restaurants")
                                .foregroundColor(Color.white)
                                .fontWeight(.bold)
                                .frame(width :geometry.size.width, height: 50, alignment: .leading)
                                .multilineTextAlignment(.leading)
                                .padding([.leading,.top],30)
                            
                            NavigationLink(
                                destination: WelcomeUIView(),
                                isActive: self.$isNavigateToWelcome) {
                                    Button(action: {
                                        
                                        self.isNavigateToWelcome = true
                                        
                                    }, label: {
                                        Text("Get Started")
                                    })
                                    .frame(width: 150, height: 45, alignment: .center)
                                    .accentColor(.black)
                                    .background(Color.white)
                                    .addBorder(Color.white, width: 1, cornerRadius: 20)
                                    .padding([.leading,.top], 30)
                                    
                                }
                            
                                Spacer()
                        }
                        .padding(30)
                        .frame(width :UIScreen.main.bounds.width, height : 250)
                        .background(Color.pink)
                        .cornerRadius(20, antialiased: true)
                        
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                }
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                //.edgesIgnoringSafeArea([.top, .bottom])
            }
            .navigationBarHidden(true)
        }
    }
}

struct StartUIView_Previews: PreviewProvider {
    static var previews: some View {
        StartUIView()
    }
}
