//
//  CartInfoView.swift
//  HappyFoodDeliveryApp
//
//  Created by Khin Yadanar Thein on 01/11/2020.
//

import SwiftUI

struct CartInfoView: View {
    
    var restaurant : RestaurantVO
    
    @ObservedObject var mViewModel = CartViewModel()
    
    var body: some View {
        GeometryReader{ geometry in
            
            ScrollView {
                VStack (alignment: .center,spacing : 10){
                    NewRestaurantView(restaurant: restaurant)
                        .frame(width: geometry.size.width - 30, height: 170, alignment: .leading)
                        .padding(.leading)
                        .background(Color.white)
                        
                    //ForEach(0..<5) { food in
                    ForEach(mViewModel.cartFoodList, id: \.id){ food in
                        
                        HStack{
                            Text(food.name ?? "")
                            Text("x\(food.quantity ?? 0)")
                            Spacer()
                            Button(action: {
                                mViewModel.onTapdecreaseItem(cartFood: food)
                            }, label: {
                                Text("-")
                                    .foregroundColor(.pink)
                                    .font(.system(size: 30))
                            })
                            Text("\(food.quantity ?? 0)")
                            Button(action: {
                                mViewModel.onTapIncreaseItem(cartFood: food)
                            }, label: {
                                Text("+").foregroundColor(.pink)
                                    .font(.system(size: 28))
                                    
                            })
                            Spacer()
                            Text("\(String(format:"%.1f", (food.price ?? 0.0)*Double(food.quantity ?? 0)))Ks")
                        }
                        
                    }
                    .frame(width: geometry.size.width - 30, height: 50, alignment: .leading)
                    
                    Text("Add more Food").foregroundColor(.pink)
                        .frame(height : 50)
                    
                    HStack{
                        Text("Delivery Instruction")
                        Spacer()
                        Text("Add Notes +").foregroundColor(.pink).fontWeight(.medium)
                    }
                    .frame(width: geometry.size.width - 30, height: 50, alignment: .leading)
                    
                    
                    HStack{
                        Text("Subtotal")
                        Spacer()
                        Text("\(String(format:"%.1f", mViewModel.totalCartVO.totalPrice ?? 0.0))Ks").fontWeight(.medium)
                    }
                    .frame(width: geometry.size.width - 30, height: 50, alignment: .leading)
                    
                    
                    HStack{
                        Text("Delivery fees")
                        Spacer()
                        Text(mViewModel.totalCartVO.deliveryFee == 0.0 ? "Free" : String(format: "%.1f", "\(mViewModel.totalCartVO.deliveryFee ?? 0.0)")).foregroundColor(.pink).fontWeight(.medium)
                    }
                    .frame(width: geometry.size.width - 30, height: 50, alignment: .leading)
                    
                    Spacer()
                    Button(action: {
                        //self.mViewModel.isNavigateToHomeScreen = true
                        //self.mViewModel.onTapLogin()
                        self.mViewModel.checkoutCart()
                        
                    }, label: {
                        Text("Checkout")
                    })
                    .frame(width: geometry.size.width - 100, height: 50, alignment: .center)
                    .accentColor(.white)
                    .background(Color.pink)
                    .addBorder(Color.pink, width: 1, cornerRadius: 25)
//                    .sheet(isPresented: self.$mViewModel.isShowBottomSheet, content: {
//
//                    })
                    if (!mViewModel.isShowBottomSheet) {
                        CheckoutSuccessView(isOpen: self.$mViewModel.isShowBottomSheet, maxHeight: geometry.size.height * 0.8) {
                            VStack {
                                Image("thankyou")
                                    .resizable()
                                    .frame(width: 300, height: 300, alignment: .center)
                                    .scaledToFit()
                                Text("You can track the delivery in \n order section. ")
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.gray)
                                
                                Button(action: {
                                    //self.mViewModel.isNavigateToHomeScreen = true
                                    //self.mViewModel.onTapLogin()
                                    self.mViewModel.isShowBottomSheet = true
                                    
                                }, label: {
                                    Text("Track my order").fontWeight(.semibold)
                                })
                                .frame(width: geometry.size.width - 40, height: 50, alignment: .center)
                                .accentColor(.white)
                                .background(Color.pink)
                                .addBorder(Color.pink, width: 1, cornerRadius: 25)
                                .padding(.top, 20)
                                .padding([.leading, .trailing], 5)
                                
                                Button(action: {
                                    //self.mViewModel.isNavigateToHomeScreen = true
                                    //self.mViewModel.onTapLogin()
                                    self.mViewModel.isShowBottomSheet = true
                                    
                                }, label: {
                                    Text("Order something else").fontWeight(.semibold)
                                        .foregroundColor(.black)
                                })
                                .frame(width: geometry.size.width - 40, height: 50, alignment: .center)
                                .padding(.top, 20)
                                .padding([.leading, .trailing], 5)
                                Spacer()
                            }
                            
                        }
                    }
                    
                    
                }
                .frame(height: geometry.size.height, alignment: .center)
                .background(Color.init(UIColor.systemGray5))
                .navigationBarHidden(true)
            }
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
            .onAppear(perform: {
                self.mViewModel.prepareCartInfo(restaurant: restaurant)
            })
            
        }
    }
}

struct CartInfoView_Previews: PreviewProvider {
    static var previews: some View {
        CartInfoView(restaurant: RestaurantVO())
    }
}
