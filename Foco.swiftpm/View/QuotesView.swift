//
//  QuotesView.swift
//  Foco
//
//  Created by João Franco on 11/02/2024.
//

import SwiftUI
import TipKit

struct QuotesView: View {
    //Database
    let quoteDatabase = QuoteDatabase()
    
    //Selected Quote (Used to Share)
    @State private var selectedQuoteID: UUID?
    
    init() {
        // Enables the Share Button for the first quote
        _selectedQuoteID = State(initialValue: quoteDatabase.quotes.first?.id)
    }
    
    var body: some View {
        NavigationStack{
            if #available(iOS 17.0, *) {
                //iOS 17 and after ;)
                ScrollView(.horizontal) {
                    LazyHStack(spacing:0) {
                        ForEach(quoteDatabase.quotes, id: \.self) { quote in
                            HStack{
                                Spacer()
                                VStack {
                                    Spacer()
                                    Text("“\(quote.text)”")
                                        .font(.system(.title, design: .serif))
                                        .bold()
                                        .multilineTextAlignment(.center)
                                    Text("- \(quote.author)")
                                        .multilineTextAlignment(.center)
                                        .font(.system(.title3, design: .serif))
                                        .italic()
                                        .padding(.top)
                                    Spacer()
                                }
                                Spacer()
                            }
                            .background(
                                Rectangle()
                                    .fill(Material.regular)
                                    .clipped()
                                    .mask { RoundedRectangle(cornerRadius: 30, style: .continuous) }
                            )
                            .id(quote.id)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .containerRelativeFrame(.horizontal)
                            .scrollTransition(
                                topLeading: .interactive, bottomTrailing: .interactive, axis: .horizontal) { view, phase in view
                                        .opacity(1-(phase.value < 0 ? -phase.value : phase.value))
                                        .scaleEffect(1-(phase.value < 0 ? 0 : phase.value))
                                }
                        }
                    }
                    .scrollTargetLayout(isEnabled: true)
                    .padding(.bottom, 40)
                }
                .scrollIndicators(.hidden)
                .scrollTargetBehavior(.paging)
                .scrollPosition(id: $selectedQuoteID)
                .navigationTitle("Quotes")
                .navigationBarTitleDisplayMode(.inline)
                .padding(.bottom)
            } else {
                //Below iOS 17
                ScrollView {
                    ForEach(quoteDatabase.quotes, id: \.text) { quote in
                        QuoteView(quote: quote)
                    }
                    .padding(.bottom, 80)
                }
                .navigationTitle("Quotes")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        
        //Share
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                if let selectedQuoteID = selectedQuoteID,
                   let selectedQuote = quoteDatabase.getQuote(byId: selectedQuoteID) {
                    ShareLink(
                        item: "“\(selectedQuote.text)” - \(selectedQuote.author)"
                    )
                }
            }
        }
    }
}


#Preview {
    QuotesView()
}
