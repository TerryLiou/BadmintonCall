//
//  TabbarView.swift
//  BadmintonCall_SwiftUI
//
//  Created by 劉洧熏 on 2024/10/1.
//

import SwiftUICore
import SwiftUI

struct TabbarView: View {
    var tabbarItems: [String]

    @Binding var selectedIndex: Int
    @Namespace private var menuItemTransition
    
    var body: some View {
        ScrollViewReader { scrollView in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(tabbarItems.indices, id: \.self) { index in
                        TabbarItemView(name: tabbarItems[index], isActive: selectedIndex == index, namespace: menuItemTransition).onTapGesture {
                            withAnimation(.easeInOut) {
                                selectedIndex = index
                            }
                        }
                    }
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(25).onChange(of: selectedIndex, { oldValue, newValue in
                scrollView.scrollTo(newValue, anchor: .center)
            })
        }
    }
}
