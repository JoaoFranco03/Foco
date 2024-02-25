//
//  EmojiPicker.swift
//
//
//  Created by João Franco on 20/02/2024.
//

import SwiftUI

struct EmojiPickerSheet: View {
    @Binding var selectedEmoji: String
    @Environment(\.dismiss) var dismiss
    let emojiList = ["📚", "🧮", "🧬", "🌐", "💻", "🎨", "🎵", "📝", "🗣️", "🏋️‍♂️","🧘‍♀️", "📐", "📖", "🎭", "🎓", "💼", "🎯", "📰", "🧪", "🗺️","📓", "📒", "📔", "📕", "📗", "📘", "📙","🔬", "🎼", "🎹", "🎸","🥁", "🎤", "🎬", "🖌️", "🖍️","📏", "📌", "✂️", "📋", "📁", "📂", "🗂️", "📅", "📆", "📇","📈", "📉", "📊", "🖋️", "✒️", "📎","🖇️", "🔍"]

    var body: some View {
        NavigationStack{
            ScrollView{
                LazyVGrid(columns: Array(repeating: .init(.flexible()),count: UIDevice.current.userInterfaceIdiom == .pad ? 5 : 3), spacing: 20) {
                    //Emojis List
                    ForEach(emojiList, id: \.self) { emoji in
                        Button {
                            selectedEmoji = emoji
                            dismiss()
                        } label: {
                            Text(emoji)
                                .font(.system(size: 50))
                                .padding()
                                .background(Material.regular)
                                .aspectRatio(1/1,contentMode: .fill)
                                .mask(RoundedRectangle(cornerRadius: 15, style: .continuous))
                                .frame(maxWidth: .infinity, maxHeight: .infinity) // Limit item size
                        }
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Choose a Emoji:")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    //Dismiss
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(.orange)
                    })
                }
            })
        }
    }
}
