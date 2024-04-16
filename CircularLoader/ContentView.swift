//
//  ContentView.swift
//  CircularLoader
//
//  Created by Pouya Sadri on 15/04/2024.
//

import SwiftUI

struct ContentView: View {
	var body: some View {
		ZStack{
			LinearGradient(gradient: Gradient(colors: [Color(red: 72/255, green: 85/255, blue: 99/255),Color(red: 41/255, green: 50/255, blue: 60/255)]), startPoint: .top, endPoint: .bottom)
				.ignoresSafeArea()
			
			LoadingCircle()
			
			VStack{
				Text("POUYA SADRI DEV")
					.font(.title)
					.foregroundStyle(.white.opacity(0.3))
				
				Spacer()
					.frame(height: 350)
			}
		}
    }
}

//MARK: - LoadingCircle
struct LoadingCircle : View {
	@State private var circleRotations : [Bool] = Array(repeating: false, count: 8)
	@State private var entireRotation = false
	private let colors : [AnyGradient] = [Color.blue.gradient, Color.purple.gradient, Color.pink.gradient, Color.red.gradient, Color.orange.gradient, Color.yellow.gradient, Color.green.gradient, Color.dkgreen.gradient]
	var body: some View {
		ZStack{
			ForEach(0..<8){index in
				RotatingRectangle(index: index, isAnimating: $circleRotations[index], gradient: colors[index])
			}
			.rotationEffect(.degrees(entireRotation ? 0 : 180))
			.animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: entireRotation)
			.onAppear(){
				entireRotation.toggle()
			}
		}
	}
}

//MARK: - RotatingRectangle
struct RotatingRectangle : View {
	let index : Int
	@Binding var isAnimating : Bool
	let gradient : AnyGradient
	
	var rotation : Double {
		Double(index) * 45
	}
	
	var body: some View {
		Rectangle()
			.cornerRadius(isAnimating ? 50 : 0)
			.frame(width: 60,height: 60)
			.foregroundStyle(gradient)
			.overlay{
				RoundedRectangle(cornerRadius: isAnimating ? 50 : 0)
					.stroke(.white,lineWidth: 5)
			}
			.opacity(isAnimating ? 0.5 : 1)
			.scaleEffect(isAnimating ? 0.4 : 1)
			.rotationEffect(.degrees(isAnimating ? 90 : -90))
			.animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: isAnimating)
			.offset(y:80)
			.rotationEffect(.degrees(rotation))
			.onAppear(){
				isAnimating.toggle()
			}
		
	}
}

#Preview {
    ContentView()
}
