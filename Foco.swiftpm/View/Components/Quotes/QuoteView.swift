//
//  QuoteView.swift
//
//
//  Created by João Franco on 11/02/2024.
//

import SwiftUI

struct QuoteView: View {
    //Quote to Display
    var quote: Quote
    
    var body: some View {
        HStack{
            Spacer()
            VStack(alignment: .trailing){
                Text("“\(quote.text)”")
                    .font(.system(.title2, design: .serif))
                    .bold()
                Text("- \(quote.author)")
                    .font(.system(.headline, design: .serif))
                    .italic()
                    .padding(.top)
            }
            .padding()
            .padding(.vertical)
            Spacer()
        }
        .background(Material.ultraThin)
        .overlay(
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .stroke(LinearGradient(colors: [.white.opacity(0.2), .white.opacity(0.1)], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 1.5)
        )
    }
}
