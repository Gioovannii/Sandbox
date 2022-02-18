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
    @State private var sent = [Message]()
    
    @State private var selectedBox = "Inbox"
    let messageBoxes = ["Inbox", "Sent"]
    
    var messages: [Message] {
        if selectedBox == "Inbox" {
            return inbox
        } else {
            return sent
        }
    }
    
    var body: some View {
        NavigationView {
            List(messages) { message in
                Text("\(message.user): ").bold() +
                Text(message.text)
                
            }
            .navigationTitle("Inbox")
            .toolbar {
                Picker("Select a message box", selection: $selectedBox) {
                    ForEach(messageBoxes, id: \.self, content: Text.init)
                }
                .pickerStyle(.segmented)
            }
            .task { fetchData() }
        }
    }
    
    func fetchData() {
        Task {
            let inboxURL = URL(string: "https://hws.dev/inbox.json")!
            inbox = try await URLSession.shared.decode([Message].self, from: inboxURL)
            
        }
        
        Task {
            let sentURL = URL(string: "https://hws.dev/sent.json")!
            sent = try await URLSession.shared.decode([Message].self, from: sentURL)
        }
    }
}

struct AsyncView_Previews: PreviewProvider {
    static var previews: some View {
        AsyncView()
    }
}


//    func fetchInbox(completion: @escaping (Result<[Message], Error>) -> Void) {
//        let inboxURL = URL(string: "https://hws.dev/inbox.json")!
//
//        URLSession.shared.dataTask(with: inboxURL) { data, response, error in
//            if let data = data {
//                if let messages = try? JSONDecoder().decode([Message].self, from: data) {
//                    completion(.success(messages))
//                    return
//                }
//            } else if let error = error {
//                completion(.failure(error))
//                return
//            }
//
//            completion(.success([]))
//        }.resume()
//    }
//
//    func fetchInbox() async throws -> [Message] {
//        try await withCheckedThrowingContinuation { continuation in
//            fetchInbox { result in
//                switch result {
//                case .success(let messages):
//                    continuation.resume(returning: messages)
//                case .failure(let error):
//                    continuation.resume(throwing: error)
//                }
//            }
//        }
//    }
