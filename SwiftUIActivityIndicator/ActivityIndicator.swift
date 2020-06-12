//
//  ActivityIndicator.swift
//  SwiftUIActivityIndicator
//
//  Created by Yisselda Rhoc on 6/11/20.
//  Copyright © 2020 Yisselda Rhoc. All rights reserved.
//

import SwiftUI

struct ActivityIndicator: View {
  @State private var currentIndex: Int = 0
  var speed : Int = 50

  func incrementIndex() {
    if currentIndex == 12 {
      currentIndex = 0
    }

    currentIndex += 1
    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(speed), execute: {
      self.incrementIndex()
    })
  }

  var body: some View {
    GeometryReader { (geometry: GeometryProxy) in
      ForEach(0..<12) { index in
        Group {
          Rectangle()
            .cornerRadius(geometry.size.width / 5)
            .frame(width: geometry.size.width / 8, height: geometry.size.height / 3)
            .offset(y: geometry.size.width / 2.25)
            .rotationEffect(.degrees(Double(-360 * index / 12)))
            .opacity(self.setOpacity(for: index))
        }.frame(width: geometry.size.width, height: geometry.size.height)
      }
    }
    .aspectRatio(1, contentMode: .fit)
    .onAppear {
      self.incrementIndex()
    }
  }

  func setOpacity(for index: Int) -> Double {
    let opacityOffset = Double((index + currentIndex - 1) % 11 ) / 12 * 0.9
    return 0.1 + opacityOffset
  }
}

struct ActivityIndicator_Previews: PreviewProvider {
  static var previews: some View {
    ActivityIndicator()
      .frame(width: 50, height: 50)
      .foregroundColor(.blue)
  }
}
