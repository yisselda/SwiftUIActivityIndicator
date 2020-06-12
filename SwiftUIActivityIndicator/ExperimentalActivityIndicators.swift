//
//  ExperimentalActivityIndicators.swift
//  SwiftUIActivityIndicator
//
//  Created by Yisselda Rhoc on 6/11/20.
//  Copyright © 2020 Yisselda Rhoc. All rights reserved.
//

import SwiftUI

enum ExperimentalActivityIndicatorsType: CaseIterable {
  case uikit
  case snail
  case movingsnail
}

struct ExperimentalActivityIndicators: View {
  var indicatorType : ExperimentalActivityIndicatorsType = .uikit
  @State private var isAnimating: Bool = false
  @State private var currentIndex: Int = 0

  func incrementIndex() {
    currentIndex += 1
    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(50), execute: {
      self.incrementIndex()
    })
  }

  var body: some View {
    GeometryReader { (geometry: GeometryProxy) in
      ForEach(0..<12) { index in
        Group {
          Rectangle()
            .cornerRadius(geometry.size.width / 5)
            .frame(width: geometry.size.width / 8, height: self.setHeight(height: geometry.size.height, index: index, indicatorType: self.indicatorType))
            .offset(y: geometry.size.width / 2.25)
            .rotationEffect(.degrees(Double(-360 * index / 12)))
            .opacity(self.setOpacity(for: index))
        }.frame(width: geometry.size.width, height: geometry.size.height)
      }
    }
    .aspectRatio(1, contentMode: .fit)
    .onAppear {
      self.isAnimating = true
      self.incrementIndex()
    }
  }

  func setHeight(height: CGFloat, index: Int, indicatorType: ExperimentalActivityIndicatorsType = .uikit) -> CGFloat {
    switch indicatorType {
      case .uikit:
        return  height  / 3
      case .snail:
        return height * CGFloat(index) / 3
      case .movingsnail:
        return  (height * CGFloat((index + currentIndex - 1) % 11)) / 3
    }
  }


  func setOpacity(for index: Int) -> Double {
    let opacityOffset = Double((index + currentIndex - 1) % 11 ) / 12 * 0.9
    return 0.1 + opacityOffset
  }
}

struct ExperimentalActivityIndicators_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      VStack {
    ExperimentalActivityIndicators()
      .frame(width: 50, height: 50)
      ExperimentalActivityIndicators()
        .frame(width: 50, height: 50)
      ExperimentalActivityIndicators()
        .frame(width: 50, height: 50)
      }.environment(\.colorScheme, .light)
      
      VStack {
        ExperimentalActivityIndicators()
          .frame(width: 50, height: 50)
        ExperimentalActivityIndicators(indicatorType: .movingsnail)
          .frame(width: 50, height: 50)
        ExperimentalActivityIndicators(indicatorType: .snail)
          .frame(width: 50, height: 50)
      }.environment(\.colorScheme, .dark)
    }
  }
}
