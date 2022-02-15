//
//  CodableView.swift
//  Sandbox
//
//  Created by Giovanni Gaffé on 2022/2/15.
//

import SwiftUI

enum Vehicule: Codable {
    case bicycle(electric: Bool)
    case motorbike
    case car(seats: Int)
    case truck(wheel: Int)
}

func testVehicules() {
    let traffic: [Vehicule] = [
        .bicycle(electric: false),
        .bicycle(electric: false),
        .car(seats: 4),
        .bicycle(electric: true),
        .motorbike,
        .truck(wheel: 8)
    ]
    
    do {
        let jsonData = try JSONEncoder().encode(traffic)
        let jsonString = String(decoding: jsonData, as: UTF8.self)
        print(jsonString)
        let newValues = try JSONDecoder().decode([Vehicule].self, from: jsonData)
    } catch {
        
    }
}

struct CodableView: View {
    var body: some View {
        Text("Hello")
             .onAppear {
                 testVehicules()
             }
    }
}

struct CodableView_Previews: PreviewProvider {
    static var previews: some View {
        CodableView()
    }
}
