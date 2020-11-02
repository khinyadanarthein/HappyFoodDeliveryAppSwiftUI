//
//  WelcomeUIView.swift
//  HappyFoodDeliveryApp
//
//  Created by Khin Yadanar Thein on 28/10/2020.
//

import SwiftUI
import Combine

struct WelcomeUIView: View {
    
    @ObservedObject var mViewModel = WelcomeViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            
                ScrollView {
                    //Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                    
                    VStack (alignment : .center){
                        HStack(alignment: .top) {
                            Spacer()
                            NavigationLink(
                                destination: LoginUIView(),
                                isActive: self.$mViewModel.isNavigateToLoginScreen) {
                                
                                Button(action: {
                                    self.mViewModel.isNavigateToLoginScreen = true
                                }, label: {
                                    Text("Log In").foregroundColor(.pink)
                                })
                                .padding()
                                .border(Color.white, width: 0)
                                .frame(width: 100, height: 50, alignment: .center)
                            }
                        }
                        
                        TabView {
                            ForEach(0..<3) { i in
                                ZStack {
                                    //Color.black
                                    //Text("Row: \(i)").foregroundColor(.white)
                                    SlideView(index: i)
                                }.clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                            }
                        }
                        .frame(width: UIScreen.main.bounds.width, height: 600, alignment: .center)
                        .accentColor(.blue)
                        .tabViewStyle(PageTabViewStyle())
                        
                        NavigationLink(
                            destination: RegisterUIView(),
                            isActive: self.$mViewModel.isNavigateToRegisterScreen) {
                            Button(action: {
                                self.mViewModel.isNavigateToRegisterScreen = true
                            
                            }, label: {
                                Text("Create Account")
                            })
                            .frame(width: geometry.size.width - 50, height: 45, alignment: .center)
                            .accentColor(.white)
                            .background(Color.pink)
                            .addBorder(Color.pink, width: 1, cornerRadius: 20)
                            .padding(.top, 20)
                        }
                        
                        Button(action: {
                            
                        }, label: {
                            HStack {
                                Image("facebook_circle_64")
                                    .resizable()
                                    .frame(width: 30, height: 30, alignment: .center)
                                    .scaledToFill()
                                Text("Continue with Facebook")
                            }
                            
                        })
                        .frame(width: geometry.size.width - 50, height: 45, alignment: .center)
                        .accentColor(.black)
                        .background(Color.init(UIColor.systemGray5))
                        .addBorder(Color.init(UIColor.systemGray5), width: 1, cornerRadius: 20)
                        .padding(.top, 10)
                        Spacer()
                        
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                }
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .trailing)
                //.background(Color.init(UIColor.systemGray6))
                .navigationBarHidden(true)
            }
      
    }
}

struct WelcomeUIView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeUIView()
    }
}

struct SlideView: View {
    
    var index : Int
    
    var body: some View {
        VStack (alignment: .center, spacing : 10){
            
            switch(index) {
            case 0 :
                Image("welcome1")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width - 50, height: 400, alignment: .center)
                    .scaledToFill()
                
                Text("Fast Delivery").foregroundColor(.pink)
                    .fontWeight(.bold)
                    .font(.system(size: 30))
                    .multilineTextAlignment(.center)
                
                Text("Fast Deliver to your home, office and \neverywhere you are").foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                
            case 1:
                Image("welcome2")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width - 50, height: 400, alignment: .center)
                    .scaledToFill()
                
                Text("Find Food You Love").foregroundColor(.pink)
                    .fontWeight(.bold)
                    .font(.system(size: 30))
                    .multilineTextAlignment(.center)
                
                Text("Discover the best foods from \nover 1000 restarurants").foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                
            default :
                Image("live-tracking")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width - 50, height: 400, alignment: .center)
                    .scaledToFill()
                
                Text("Live Tracking").foregroundColor(.pink)
                    .fontWeight(.bold)
                    .font(.system(size: 30))
                    .multilineTextAlignment(.center)
                
                Text("Fast Deliver to your home, office and \neverywhere you are").foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                
            }
            
            
        }
    }
}
