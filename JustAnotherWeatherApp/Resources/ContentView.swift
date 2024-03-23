//
//  ContentView.swift
//  JustAnotherWeatherApp
//
//  Created by Rakibur Khan on 21/3/24.
//

import SwiftUI
import RKAPIUtility

struct ContentView: View {
    var body: some View {
        CurrentWeatherView()
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundColor(.accentColor)
//            Text("Hello, world!")
//        }
//        .padding()
//        .alert(isPresented: .constant(true), error: HTTPStatusCode.standard(statusCode: .badRequest)) { error in
//            Button(role: .destructive, action: {}) {
//                Text("Demo Titlee")
//            }
//        } message: { error in
//            Text(error.errorDescription ?? "Demo Message")
//        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
