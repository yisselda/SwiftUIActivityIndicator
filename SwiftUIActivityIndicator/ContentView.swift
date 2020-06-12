//
//  ContentView.swift
//  SwiftUIActivityIndicator
//
//  Created by Yisselda Rhoc on 6/11/20.
//  Copyright © 2020 Yisselda Rhoc. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  let rainbow : [Color] = [.purple, .blue, .green, .yellow, .orange, .red]
  var body: some View {
    VStack(spacing: 100) {
      ActivityIndicator()
        .frame(width: 50, height: 50)
        .foregroundColor(.gray)

        HStack(spacing: 50) {
          ForEach(0..<(rainbow.count/2)) { index in
            ExperimentalActivityIndicators(indicatorType: .uikit)
              .frame(width: 50, height: 50)
              .foregroundColor(self.rainbow[index])
          }
        }

        HStack(spacing: 50) {
          ForEach((rainbow.count/2)..<rainbow.count) { index in
            ExperimentalActivityIndicators(indicatorType: .uikit)
              .frame(width: 50, height: 50)
              .foregroundColor(self.rainbow[index])
          }
        }

      HStack(spacing: 50) {
        ForEach(0..<(rainbow.count/2)) { index in
          ExperimentalActivityIndicators(indicatorType: .snail)
            .frame(width: 50, height: 50)
            .foregroundColor(self.rainbow[index])
        }
      }

      HStack(spacing: 50) {
        ForEach((rainbow.count/2)..<rainbow.count) { index in
          ExperimentalActivityIndicators(indicatorType: .movingsnail)
            .frame(width: 50, height: 50)
            .foregroundColor(self.rainbow[index])
        }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
