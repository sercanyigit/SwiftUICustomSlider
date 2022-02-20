//
//  ContentView.swift
//  SwiftUICustomSlider
//
//  Created by Sercan YİĞİT on 20.02.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State var offset : CGFloat = 0
    var offsetValue = 0
    let pickerCount = 35
   
    
    var body: some View {
        VStack {
            Text("\(getWeight()) KG")
                .font(.system(size: 38, weight: .heavy))
                .foregroundColor(Color.gray)
            
            CustomSlider(pickerCount: pickerCount, offset: $offset, content: {
                ScrollView(.horizontal, showsIndicators: false, content: {
                    HStack(spacing : 0) {
                        ForEach(1...pickerCount, id: \.self) { index in
                            Rectangle()
                                .fill(Color.gray)
                                .frame(width: 3, height: 30)
                                .frame(width: 20)
                            
                            ForEach(1...4, id: \.self) { subIndex in
                                Rectangle()
                                    .fill(Color.gray)
                                    .frame(width: 1, height: 15)
                                    .frame(width: 20)
                            }
                           
                        }
                        
                    }
                    .offset(x: (getRect().width - 50 ) / 2)
                    .padding(.trailing,getRect().width - 50)
                })
            })
            .frame(height: 50)
            .overlay(
              Rectangle()
                .fill(Color.gray)
                .frame(width: 3, height: 50)
                .offset(x: 0.4, y: -30)
            )
            .padding()
        }
  }
  
    func getWeight() -> String {
        return "\(Int(offset/20))"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
