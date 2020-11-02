//
//  RegisterUIView.swift
//  HappyFoodDeliveryApp
//
//  Created by Khin Yadanar Thein on 30/10/2020.
//

import SwiftUI

struct RegisterUIView: View {
    
    @ObservedObject var mViewModel = RegisterViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack (alignment : .leading ,spacing : 15){
                    Text("Create your \naccount").foregroundColor(.pink)
                        .fontWeight(.bold)
                        .font(.system(size: 30))
                        .multilineTextAlignment(.leading)
                        .padding([.bottom,.top],50)
                        .padding([.leading],20)
                    
                    TextField("User name", text: $mViewModel.mUserName)
                        .frame(height : 55)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding([.leading, .trailing], 20)
                        .background(Color.white)
                        .cornerRadius(25)
                        .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.white).padding(.bottom, -0).padding(.top, 0))
                        .padding([.leading, .trailing], 5)
                    
                    TextField("Email", text: $mViewModel.mEmail)
                        .frame(height : 55)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding([.leading, .trailing], 20)
                        .background(Color.white)
                        .cornerRadius(25)
                        .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.white).padding(.bottom, -0).padding(.top, 0))
                        .padding([.leading, .trailing], 5)
                    
                    SecureField("Password", text: $mViewModel.mPassword)
                        .frame(height : 55)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding([.leading, .trailing], 20)
                        .background(Color.white)
                        .cornerRadius(25)
                        .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.white).padding(.bottom, -0).padding(.top, 0))
                        .padding([.leading, .trailing], 5)
                    
                    
                    TextField("Phone", text: $mViewModel.mPhone)
                        .frame(height : 55)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding([.leading, .trailing], 20)
                        .background(Color.white)
                        .cornerRadius(25)
                        .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.white).padding(.bottom, -0).padding(.top, 0))
                        .padding([.leading, .trailing], 5)
                    
                    Button(action: {

                        self.mViewModel.onTapRegister {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                        
                    }, label: {
                        Text("Sign up")
                    })
                    .frame(width: geometry.size.width - 40, height: 50, alignment: .center)
                    .accentColor(.white)
                    .background(Color.pink)
                    .addBorder(Color.pink, width: 1, cornerRadius: 25)
                    .padding(.top, 20)
                    .padding([.leading, .trailing], 5)
                    Spacer()
                }
                Text("By clicking Sign up you agree to our \nTerms and Conditions ")
                    .fontWeight(.medium)
                    .font(.system(size: 14))
                    .multilineTextAlignment(.center)
                
                Spacer()
                HStack(alignment: .bottom) {
                    Text("Already have an account? ")
                        .fontWeight(.medium)
                        .font(.system(size: 20))
                    
                    NavigationLink(
                        destination: LoginUIView(),
                        isActive: self.$mViewModel.isNavigateToLoginScreen) {
                        Button(action: {
                            self.mViewModel.isNavigateToLoginScreen = true
                            
                        }, label: {
                            Text("Log in")
                                .foregroundColor(.pink)
                                .font(.system(size: 20))
                                .fontWeight(.semibold)
                        })
                    }
                    
                }
                .frame(height: 50)
                
            }
            .padding()
            .background(Color.init(.systemGray6))
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .leading)
            .alert(isPresented: self.$mViewModel.isError) {
                return Alert(title: Text(mViewModel.errorMessage))
            }
            .alert(isPresented: self.$mViewModel.isSuccess, content: {
                return Alert(title: Text("Success Sign up! Please log in!!!"))
            })
            .navigationBarHidden(true)
        }
    }
}

struct RegisterUIView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterUIView()
    }
}
