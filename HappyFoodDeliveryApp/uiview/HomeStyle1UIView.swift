//
//  HomeStyle1UIView.swift
//  HappyFoodDeliveryApp
//
//  Created by Khin Yadanar Thein on 31/10/2020.
//

import SwiftUI

struct HomeStyle1UIView: View {
    
    @ObservedObject var mViewModel = HomeViewModel()
    @State var locationExpend : Bool = false
    
    var body: some View {
        GeometryReader{ geometry in
            NavigationView{
            ScrollView {
                
                VStack (spacing: 10) {
                    Text("Delivering to")
                        .frame(width: geometry.size.width - 30, height: 20, alignment: .leading)
                    
                    HStack {
                        Text("Current Location")
                            .fontWeight(.bold)
                            .font(.title)
                        Image(systemName: locationExpend ? "chevron.up" : "chevron.down")
                            .resizable()
                            .frame(width: 20 , height: 13)
                          .foregroundColor(.pink)
                        
                    }.onTapGesture {
                        self.locationExpend.toggle()
                    }
                    .frame(width: geometry.size.width - 30, height: 30, alignment: .leading)
                    .padding(.bottom, 15)
                    
                    HStack {
                        HStack {
                          Image(systemName: "magnifyingglass")
                            .foregroundColor(.black)
                            TextField("Search foods", text: $mViewModel.mEmail)
                                .foregroundColor(.black)
                          }
                        .padding(10)
                        .background(Color.init(UIColor.systemGray5))
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.init(UIColor.systemGray5), lineWidth: 1))
                        .cornerRadius(20)
                        .frame(height:40)
                        
                        Image(systemName: "line.horizontal.3.decrease")
                          .foregroundColor(.pink)
                            .frame(width: 40, height: 40, alignment: .center)
                    }
                    .frame(width: geometry.size.width - 30, height: 40, alignment: .leading)
                    
                    
                    if ListStyleType.Catetory.rawValue == self.mViewModel.listStyle {
                            
                        ScrollView (.horizontal) {
                            LazyHGrid(rows: [GridItem(.flexible())]){
                                ForEach(mViewModel.categories, id: \.id){ category in
                                    
                                    CategoryView(data: category)
                                    
                                }
                            }.frame(height: 200, alignment: .center)
                        }
                    } else {
                        VStack {
                            HStack {
                                Text("Popular Choice")
                                    .foregroundColor(.pink)
                                    .fontWeight(.bold)
                                    .font(.title)
                                Spacer()
                                Text("Show all")
                                    .foregroundColor(.gray)
                                
                            }.frame(width: geometry.size.width - 30, height: 20, alignment: .leading)
                            .padding(.top,20)
                            
                            ScrollView (.horizontal) {
                                LazyHGrid(rows: [GridItem(.flexible())]){
                                    ForEach(mViewModel.popularChoices, id: \.id){ popular in
                                        
                                        PopularChoiceView(restaurant: popular, cellWidth: 380)
                                    }
                                }.frame(height: 270, alignment: .leading)
                                .padding()
                            }
                        }
                    }
                    
                }
                HStack {
                    Text("New Restaurants")
                        .foregroundColor(.pink)
                        .fontWeight(.bold)
                        .font(.title)
                    Spacer()
                    Text("Show all")
                        .foregroundColor(.gray)
                    
                }.frame(width: geometry.size.width - 30, height: 20, alignment: .leading)
                .padding(.top,20)
                
                LazyVGrid(columns:[GridItem(.flexible())]){
                    
                    if ListStyleType.Catetory.rawValue == self.mViewModel.listStyle {
                        ForEach(mViewModel.restaurants, id: \.id){ res in
                            
//                            NavigationLink(
//                                destination: RestaurantDetailView(restaurant: self.mViewModel.detailInfo),
//                                isActive: self.$mViewModel.isNavigateToDetailScreen) {
                                
                                Button(action: {
                                    self.mViewModel.detailInfo = res
                                    self.mViewModel.isNavigateToDetailScreen = true
                                }, label: {
                                    PopularChoiceView(restaurant: res, cellWidth: geometry.size.width - 30)
                                    
                                })
                                .sheet(isPresented: self.$mViewModel.isNavigateToDetailScreen, content: {
                                    RestaurantDetailView(restaurant: self.mViewModel.detailInfo)
                                })
                            //}
                        }
                    } else {
                        
                        ForEach(mViewModel.restaurants, id: \.id){ res in
                            Button(action: {
                                self.mViewModel.detailInfo = res
                                self.mViewModel.isNavigateToDetailScreen = true
                            }, label: {
                                NewRestaurantView(restaurant: res)
                                    .frame(width: geometry.size.width - 20, height: 170, alignment: .leading)
                            })
                            .sheet(isPresented: self.$mViewModel.isNavigateToDetailScreen, content: {
                                RestaurantDetailView(restaurant: self.mViewModel.detailInfo)
                            })
                            
                        }
                    }
                }
                
            }
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
            .padding(.top)
            .navigationBarHidden(true)
            }
        }
    }
}

struct HomeStyle1UIView_Previews: PreviewProvider {
    static var previews: some View {
        HomeStyle1UIView()
    }
}
