//
//  ProfileUIView.swift
//  HappyFoodDeliveryApp
//
//  Created by Khin Yadanar Thein on 30/10/2020.
//

import SwiftUI
import CoreData
import SDWebImageSwiftUI

struct ProfileUIView: View {
    
    @Environment(\.managedObjectContext)
    var context : NSManagedObjectContext
    
    @ObservedObject var mViewModel = ProfileViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                ScrollView {
                    
                    ZStack {
                        if (mViewModel.showIndicator) {
                            ProgressView("Loading")
                                .zIndex(10)
                                .progressViewStyle(CircularProgressViewStyle(tint: .pink))
                            
                        } else {
                            Text("")
                        }
                        
                        VStack (alignment : .center ,spacing : 15){
                            
                            ZStack (alignment : .top){
                                ZStack {
                                    ActivityIndicator(self.$mViewModel.showImageloading)
                                    Image(uiImage: mViewModel.photo)
                                        .resizable()
                                        .frame(width: 150, height: 150, alignment: .center)
                                        .scaledToFit()
                                        .cornerRadius(75)
                                    
                                }
                                
                                HStack (alignment: .center){
                                    Spacer()
                                    Button(action: {
                                        self.mViewModel.isShowingImage = true
                                    }, label: {
                                        Image(systemName: "photo.fill")
                                            .font(.system(size: 30, weight: .regular))
                                            .foregroundColor(.gray)
                                            .frame(alignment: .top)
                                    })
                                    .sheet(isPresented: self.$mViewModel.isShowingImage) {
                                        ImagePicker(isPresented: self.$mViewModel.isShowingImage, onImageChosen: { image in
                                            self.mViewModel.onChangeImage(image: image)
                                        })
                                    }
                                    
                                        
                                }
                                .frame(width: 150, height: 50, alignment: .center)
                                
                            }
                            
                            Text(mViewModel.mUserName)
                            
                            VStack (spacing: 5){
                                Text("Your Email")
                                    .frame(width: geometry.size.width - 50, height: 30,alignment: .leading)
                                    .foregroundColor(.gray)
                                
                                CustomTextField(placeHolder: "Email", value: $mViewModel.mEmail, lineColor: .gray, width: 1.5)
                                    .frame(height : 40)
                            }
                        
                            VStack (spacing: 5){
                                Text("Your Password")
                                    .frame(width: geometry.size.width - 50, height: 30,alignment: .leading)
                                    .foregroundColor(.gray)
                                
                                CustomTextField(placeHolder: "Password", value: $mViewModel.mPassword, lineColor: .gray, width: 1.5)
                                    .frame(height : 40)
                            }
                            
                            VStack (spacing: 5){
                                Text("Your Phone")
                                    .frame(width: geometry.size.width - 50, height: 30,alignment: .leading)
                                    .foregroundColor(.gray)
                                
                                CustomTextField(placeHolder: "09", value: $mViewModel.mPhone, lineColor: .gray, width: 1.5)
                                    .frame(height : 40)
                            }
                            
                            Spacer()
                            
                        }
                    }
                }
                .padding()
                .background(Color.init(.systemGray6))
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .leading)
                .navigationBarItems(leading: Button(action: {
                    
                }, label: {
                    Text("Cancel")
                }))
                .navigationBarItems(trailing: Button(action: {
                    
                    mViewModel.editUserInfo()
                    
                }, label: {
                    Text("Save")
                }))
            }
            .navigationBarHidden(true)
        }
    }
}

struct ProfileUIView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileUIView()
    }
}
