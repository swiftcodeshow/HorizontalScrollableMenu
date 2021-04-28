//
//  ContentView.swift
//  Shared
//
//  Created by 米国梁 on 2021/4/28.
//

import SwiftUI

extension View {
    
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}

extension String {
    
    func getSize() -> CGSize {
        (self as NSString).size(withAttributes: nil)
    }
}

struct Type: Identifiable, Equatable {
    var id = UUID().uuidString
    var title: String
}

let types: [Type] = [
    Type(title: "Fruits"),
    Type(title: "Clothes"),
    Type(title: "Toys"),
    Type(title: "Foods"),
    Type(title: "Novels"),
    Type(title: "Sports"),
    Type(title: "Books"),
    Type(title: "Tools"),
    Type(title: "Cars"),
    Type(title: "Devices"),
    Type(title: "Colors"),
]

struct ContentView: View {
    
    @State var selection = types.first
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {

            ScrollViewReader { proxy in

                HStack(spacing: 10) {

                    ForEach(types) { type in

                        Button(action: {

                            if let i = types.firstIndex(of: type) {

                                let textWidth = type.title.getSize().width

                                let midX = CGFloat(i) * (textWidth + 50) + 0.5 * (textWidth + 40)

                                let containerWidth = types.reduce(10) { (result, item) -> CGFloat in
                                    result + item.title.getSize().width + 50
                                }

                                withAnimation(.spring()) {
                                    selection = type
                                    if midX + getRect().width / 2 < containerWidth {
                                        proxy.scrollTo(type.id, anchor: .center)
                                    } else {
                                        proxy.scrollTo(types.last?.id, anchor: .trailing)
                                    }
                                }
                            }
                        }) {
                            Text(type.title)
                                .fontWeight(.semibold)
                        }
                        .frame(width: type.title.getSize().width + 40,
                               height: type.title.getSize().height + 24,
                               alignment: .center)
                        .background(Color.black.opacity(selection?.id == type.id ? 0.5 : 0))
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .id(type.id)
                        .padding(.trailing, type.id == types.last?.id ? 10 : 0)
                    }
                }
                .padding(.horizontal, 15)
            }
        }
        .padding(.vertical)
        .background(Color.yellow)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
