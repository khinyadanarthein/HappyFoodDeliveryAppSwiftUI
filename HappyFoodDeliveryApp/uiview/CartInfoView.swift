//
//  CartInfoView.swift
//  HappyFoodDeliveryApp
//
//  Created by Khin Yadanar Thein on 01/11/2020.
//

import SwiftUI

struct CartInfoView: View {
    var body: some View {
        GeometryReader{ geometry in
            
            ScrollView {
                VStack (alignment: .center,spacing : 10){
                    NewRestaurantView(restaurant: RestaurantVO())
                        .frame(width: geometry.size.width - 30, height: 170, alignment: .leading)
                        .padding(.leading)
                        .background(Color.white)
                        
                    ForEach(0..<5) { food in
                        
                        HStack{
                            Text("Cheese Burger")
                            Text("x1")
                            Spacer()
                            Button(action: {
                                
                            }, label: {
                                Text("-")
                                    .foregroundColor(.pink)
                                    .font(.system(size: 30))
                            })
                            Text("1")
                            Button(action: {
                                
                            }, label: {
                                Text("+").foregroundColor(.pink)
                                    .font(.system(size: 30))
                                    
                            })
                            Spacer()
                            Text("$160")
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
                        Text("$1600").fontWeight(.medium)
                    }
                    .frame(width: geometry.size.width - 30, height: 50, alignment: .leading)
                    
                    
                    HStack{
                        Text("Delivery fees")
                        Spacer()
                        Text("Free").foregroundColor(.pink).fontWeight(.medium)
                    }
                    .frame(width: geometry.size.width - 30, height: 50, alignment: .leading)
                    
                    Spacer()
                    Button(action: {
                        //self.mViewModel.isNavigateToHomeScreen = true
                        //self.mViewModel.onTapLogin()
                        
                    }, label: {
                        Text("Checkout")
                    })
                    .frame(width: geometry.size.width - 100, height: 50, alignment: .center)
                    .accentColor(.white)
                    .background(Color.pink)
                    .addBorder(Color.pink, width: 1, cornerRadius: 25)
                    
                }
                .frame(height: geometry.size.height, alignment: .center)
                .background(Color.init(UIColor.systemGray5))
            }
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
            
            
        }
    }
}

struct CartInfoView_Previews: PreviewProvider {
    static var previews: some View {
        CartInfoView()
    }
}
