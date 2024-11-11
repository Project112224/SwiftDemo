//
//  HomeUIView.swift
//  SwiftDemo
//
//  Created by june on 2024/11/11.
//

import SwiftUI

struct AccountViewUI: View {
    
    @Binding var isDisabled: Bool
    var buttonTapped: () -> Void
    
    var body: some View {
        ZStack {
            ((isDisabled) ? Color.gray : Color.orange).id(isDisabled)
            Button("Click Me") {
                print("isDisabled: \(isDisabled)")
                buttonTapped()
            }
            .font(.title)
            .padding()
        }
    }
}

//#Preview {
//    AccountViewUI(
//        isDisabled: .constant(false),
//        buttonTapped: {}
//    )
//}
