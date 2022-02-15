//
//  ListBindableView.swift
//  Sandbox
//
//  Created by Giovanni Gaffé on 2022/2/15.
//

import SwiftUI

struct User: Identifiable {
    let id = UUID()
    var name: String
    var isContacted = false
}

struct ListBindableView: View {
    @State private var users = [
        User(name: "Taylor"),
        User(name: "Justin"),
        User(name: "Adele")
    ]
    
    @State private var isOn = false
    var body: some View {
        List($users) { $user in
            HStack {
                Text(user.name)
                Spacer()
                Toggle("User has been contacted",isOn: $user.isContacted)
                    .labelsHidden()
            }
        }
        //        Toggle("Example", isOn: $isOn)
        //            .toggleStyle(SwitchToggleStyle())
        //            .padding()
    }
}

struct ListBindableView_Previews: PreviewProvider {
    static var previews: some View {
        ListBindableView()
    }
}
