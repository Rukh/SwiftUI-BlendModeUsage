//
//  ContentView.swift
//  BlendModeUsage
//
//  Created by Dmitry Gulyagin on 04/03/2023.
//

import SwiftUI

struct ContentView: View {
    
    private let lineWidth: CGFloat = 8
    
    @State var dragLocation: CGFloat = 0.3
        
    var body: some View {
        ZStack {
            Color.green
            LinearGradient(
                colors: [
                    .blue,
                    .blue.opacity(0.2),
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            slider
                .frame(height: lineWidth)
                .padding()
                .background(
                    Image(systemName: "xmark")
                        .resizable(resizingMode: .tile)
                        .font(.system(size: 10, weight: .ultraLight))
                        .opacity(0.3)
                        .clipShape(Capsule())
                )
                .padding()
        }
        .foregroundColor(.white)
    }
    
    @ViewBuilder
    private var slider: some View {
        let coordinateSpace = "slider"
        let padding: CGFloat = 10
        GeometryReader { geo in
            let maxWidth = geo.size.width - padding
            let dragGesture = DragGesture(
                coordinateSpace: .named(coordinateSpace)
            ).onChanged { value in
                let location = value.location.x / maxWidth
                dragLocation = max(0, min(location, 1))
            }
            Capsule(style: .continuous)
            ZStack {
                Circle()
                    .fill(.black)
                    .padding(-lineWidth / 2)
                    .blendMode(.destinationOut)
                Circle()
                    .strokeBorder(lineWidth: lineWidth)
            }
            .aspectRatio(1, contentMode: .fit)
            .padding(-padding)
            .gesture(dragGesture)
            .offset(x: dragLocation * maxWidth)
        }
        .compositingGroup()
        .coordinateSpace(name: coordinateSpace)
    }
    
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(
            .fixed(width: 480, height: 240)
        )
    }
}
#endif
