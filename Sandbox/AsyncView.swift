//
//  AsyncView.swift
//  Sandbox
//
//  Created by Giovanni Gaffé on 2022/2/16.
//

import SwiftUI

extension URLSession {
    func decode<T: Decodable>(
        _ type: T.Type = T.self,
        from url: URL,
        keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
        dataDecodingStrategy: JSONDecoder.DataDecodingStrategy = .deferredToData,
        dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate
    ) async throws -> T {
        let (data, _) = try await data(from: url)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = keyDecodingStrategy
        decoder.dataDecodingStrategy = dataDecodingStrategy
        decoder.dateDecodingStrategy = dateDecodingStrategy
        
        let decoded = try decoder.decode(T.self, from: data)
        return decoded
    }
}

struct Message: Codable, Identifiable {
    let id: Int
    let user: String
    let text: String
}

struct AsyncView: View {
    @State private var inbox = [Message]()
    
    var body: some View {
        NavigationView {
            List(inbox) { message in
                Text("\(message.user): ").bold() +
                Text(message.text)
            }
            .navigationTitle("Inbox")
            .task {
                do {
                    inbox = try await fetchInbox()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func fetchInbox() async throws -> [Message] {
        let inboxURL = URL(string: "https://hws.dev/inbox.json")!
        return try await URLSession.shared.decode(from: inboxURL)
    }
}

struct AsyncView_Previews: PreviewProvider {
    static var previews: some View {
        AsyncView()
    }
}
