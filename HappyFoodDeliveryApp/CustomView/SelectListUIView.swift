//
//  SelectListUIView.swift
//  HappyFoodDeliveryApp
//
//  Created by Khin Yadanar Thein on 31/10/2020.
//

import SwiftUI

struct SelectionView: View {

    let fruit = ["apples", "pears", "bananas", "pineapples"]
    @State var selectedFruit: String? = nil

    var body: some View {
        List {
            ForEach(fruit, id: \.self) { item in
                SelectionCell(fruit: item, selectedFruit: self.$selectedFruit)
            }
        }
    }
}

struct SelectListUIView_Previews: PreviewProvider {
    static var previews: some View {
        SelectionView()
    }
}

struct SelectionCell: View {

    let fruit: String
    @Binding var selectedFruit: String?

    var body: some View {
        HStack {
            Text(fruit)
            Spacer()
            if fruit == selectedFruit {
                Image(systemName: "checkmark")
                    .foregroundColor(.accentColor)
            }
        }   .onTapGesture {
                self.selectedFruit = self.fruit
            }
    }
}
