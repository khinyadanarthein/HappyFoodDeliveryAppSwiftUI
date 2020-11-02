//
//  LoginUIView.swift
//  HappyFoodDeliveryApp
//
//  Created by Khin Yadanar Thein on 30/10/2020.
//

import SwiftUI
import Combine

struct LoginUIView: View {
    
    @ObservedObject var mViewModel = LoginViewModel()
    
    var body: some View {
        
        GeometryReader { geometry in
            ScrollView {
                VStack (alignment : .leading ,spacing : 15){
                    Text("Log in to your \nAccount").foregroundColor(.pink)
                        .fontWeight(.bold)
                        .font(.system(size: 30))
                        .multilineTextAlignment(.leading)
                        .frame(height: 100, alignment: .center)
                        .padding()
//                        .padding([.leading],20)
                    
                    TextField("Email", text: $mViewModel.mEmail)
                        .frame(height : 55)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding([.leading, .trailing], 20)
                        .background(Color.white)
                        .cornerRadius(25)
                        .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.white).padding(.bottom, -0).padding(.top, 0))
                        .padding([.leading, .trailing], 5)
                    
                    ZStack (alignment: .trailing){
                        SecureField("Password", text: $mViewModel.mPassword)
                            .frame(height : 55)
                            .textFieldStyle(PlainTextFieldStyle())
                            .padding([.leading, .trailing], 20)
                            .background(Color.white)
                            .cornerRadius(25)
                            .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.white).padding(.bottom, -0).padding(.top, 0))
                            .padding([.leading, .trailing], 5)
                        
                        Button(action: {
                            
                        }, label: {
                            Text("Forgot?").foregroundColor(.pink)
                                .fontWeight(.semibold)
                        })
                        .frame(width : 100, height: 40, alignment: .center)
                    }
                    
                    NavigationLink(
                        destination: MainTabView(),
                        isActive: self.$mViewModel.isNavigateToHomeScreen) {
                        Button(action: {
                            //self.mViewModel.isNavigateToHomeScreen = true
                            self.mViewModel.onTapLogin()
                            
                        }, label: {
                            Text("Log in")
                        })
                        .frame(width: geometry.size.width - 40, height: 50, alignment: .center)
                        .accentColor(.white)
                        .background(Color.pink)
                        .addBorder(Color.pink, width: 1, cornerRadius: 25)
                        .padding(.top, 20)
                        .padding([.leading, .trailing], 5)
                    }
                    Spacer()
                    HStack(alignment: .center) {
                         Text("Don't have an account? ")
                             .fontWeight(.medium)
                             .font(.system(size: 20))
                         
                         
                         NavigationLink(
                             destination: RegisterUIView(),
                             isActive: self.$mViewModel.isNavigateToRegisterScreen) {
                             Button(action: {
                                 self.mViewModel.isNavigateToRegisterScreen = true
                             
                             }, label: {
                                 Text("Sign up")
                                     .foregroundColor(.pink)
                                     .font(.system(size: 20))
                                     .fontWeight(.semibold)
                             })
                         }
                     }
                    .frame(width : geometry.size.width - 30,height: 50, alignment: .center)
                }
                .frame(width: geometry.size.width - 30, height: geometry.size.height, alignment: .center)
                
                .navigationBarHidden(true)
            }
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
            //.edgesIgnoringSafeArea([.top, .bottom])
            .background(Color.init(.systemGray6))
            
        }
        
    }
}

struct LoginUIView_Previews: PreviewProvider {
    static var previews: some View {
        LoginUIView()
    }
}
