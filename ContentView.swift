//
//  ContentView.swift
//  ChatApp
//
//  Created by Jonathan Born on 2022-03-29.
//

import SwiftUI

struct ContentView: View {
    @StateObject var messagesManager = MessagesManager()
    
    var body: some View {
        VStack {
            VStack {
                TitleRow()
                
                ScrollViewReader { proxy in
                    ScrollView {
                        ForEach(messagesManager.messages, id: \.id) { message in
                            MessageBubble(message: message)
                        }
                    }
                    .padding(.top, 10)
                    .background(.white)
                .cornerRadius(25, corners: [.topLeft, .topRight])
                .onChange(of: messagesManager.lastMessageId) { id in
                                        withAnimation {
                                            proxy.scrollTo(id, anchor: .bottom)
                                        }
                                    }
                }
            }
            .background(Color("Orange"))
            
            MessageField()
                .environmentObject(MessagesManager())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}
