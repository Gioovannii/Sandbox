//
//  SentMessageView.swift
//  Sandbox
//
//  Created by Giovanni Gaffé on 2022/2/16.
//

import SwiftUI

struct SentMessageView: View {
    let sentMessages: [Message]
    var body: some View {
        List(sentMessages) { message in
            Text(message.text)
        }
    }
}

struct SentMessageView_Previews: PreviewProvider {
    static var previews: some View {
        SentMessageView(sentMessages: [Message(id: 1, user: "Giovanni", text: "Comment ca va?")])
    }
}
