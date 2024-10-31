//
//  ContentView.swift
//  DiwaliDiyaApp
//
//  Created by Roopesh Tripathi on 31/10/24.
//

import SwiftUI

struct FireworksView: View {
    @State private var animateFireworks = false
    
    var body: some View {
        ZStack {
            // Background
            Color.black
                .ignoresSafeArea()
            
            // Fireworks particle emitter
            ForEach(0..<50) { index in
                
                FireworkEmitter()
                    .offset(x: CGFloat.random(in: 0...320), y: CGFloat.random(in: 0...800))
                    .animation(Animation.easeInOut(duration: 1).delay(Double(index) * 0.5).repeatForever(autoreverses: true), value: animateFireworks)
            }
        }
        .onAppear {
            animateFireworks.toggle()
        }
    }
}

struct FireworkEmitter: View {
    @State private var particles: [FireworkParticle] = []
    
    var body: some View {
        ZStack {
            ForEach(particles) { particle in
                Circle()
                    .fill(particle.color)
                    .frame(width: particle.size, height: particle.size)
                    .position(x: particle.position.x, y: particle.position.y)
                    .opacity(particle.opacity)
            }
        }
        .onAppear(perform: createParticles)
    }
    
    func createParticles() {
        particles = (0..<50).map { _ in
            FireworkParticle(
                position: CGPoint(x: 0, y: 0),
                color: Color(hue: Double.random(in: 0...1), saturation: 1, brightness: 1),
                size: CGFloat.random(in: 5...10),
                opacity: Double.random(in: 0.5...1)
            )
        }
        
        withAnimation(Animation.easeOut(duration: 1).repeatForever(autoreverses: false)) {
            for i in particles.indices {
                particles[i].position.x = CGFloat.random(in: -150...150)
                particles[i].position.y = CGFloat.random(in: -150...150)
                particles[i].opacity = 0
            }
        }
    }
}

struct FireworkParticle: Identifiable {
    let id = UUID()
    var position: CGPoint
    var color: Color
    var size: CGFloat
    var opacity: Double
}

struct DiyaView: View {
    @State private var isFlickering = false
    
    var body: some View {
        VStack {
            ZStack {
                HappyDiwaliView()
                ForEach(0..<50) { index in
                    FlameView(isFlickering: isFlickering)
                        .offset(y: 290)
                }
                ForEach(0..<5) { index in
                    HStack(spacing: 5) {
                        FlameView(isFlickering: isFlickering)
                            .offset(y: 360)
                    }
                }
                HStack {
                    FlameView(isFlickering: isFlickering)
                    FlameView(isFlickering: isFlickering)
                    FlameView(isFlickering: isFlickering)
                    FlameView(isFlickering: isFlickering)
                    FlameView(isFlickering: isFlickering)
                    FlameView(isFlickering: isFlickering)
                    FlameView(isFlickering: isFlickering)
                    
                }.offset(y: 360)
            }
        }
        .onAppear {
            // Flicker effect using animation
            withAnimation(Animation.easeInOut(duration: 0.4).repeatForever(autoreverses: true)) {
                isFlickering.toggle()
            }
        }
    }
}

// Flame shape and animation
struct FlameView: View {
    var isFlickering: Bool
    
    var body: some View {
        ZStack {
            // Outer glow
            Circle()
                .fill(Color.orange.opacity(0.5))
                .frame(width: 40, height: 60)
                .blur(radius: isFlickering ? 10 : 15)
                .scaleEffect(isFlickering ? 1.1 : 1)
                .animation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true), value: isFlickering)
            
            // Inner flame
            Ellipse()
                .fill(LinearGradient(
                    gradient: Gradient(colors: [.yellow, .orange, .red]),
                    startPoint: .top,
                    endPoint: .bottom
                ))
                .frame(width: 20, height: 40)
                .scaleEffect(isFlickering ? 1.1 : 1)
                .animation(Animation.easeInOut(duration: 0.3).repeatForever(autoreverses: true), value: isFlickering)
        }
    }
}

struct HappyDiwaliView: View {
    var body: some View {
        ZStack {
            FireworksView()
            
            VStack {
                HStack {
                    Text("🪔")
                    Text("   शुभ दिवाली!")
                    Text("🪔")
                }
            }
                .font(.system(size: 60, weight: .bold, design: .rounded))
                .foregroundColor(.yellow)
                .shadow(color: .orange, radius: 10, x: 0, y: 0) // Glowing effect
        }
    }
}


#Preview {
    VStack {
        DiyaView()
            .ignoresSafeArea()
    }
}
