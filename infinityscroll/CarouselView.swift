//
//  CarouselView.swift
//  infinityscroll
//
//  Created by Viktor on 16.02.2023.
//

import SwiftUI


struct CarouselView: View {
	let items: CarouselList

	@State private var currentItem: CarouselItem?


	var body: some View {
		VStack {
			Button("prev", action: {
				self.currentItem = self.currentItem?.previous
			})
			Button("next", action: {
				self.currentItem = self.currentItem?.next
			})

			GeometryReader { geometry in
				ScrollView(.horizontal, showsIndicators: false) {
					LazyHStack(spacing: 10) {
						ForEach(items, id: \.id) { item in
							VStack {
								item.color
								Text(item.title)
							}
							.frame(width: 150, height: 150)
						}
					}
					.padding()
				}
			}


		}
	}


}






struct SizePreferenceKey: PreferenceKey {
	static var defaultValue: [Int: CGSize] = [:]

	static func reduce(value: inout [Int: CGSize], nextValue: () -> [Int: CGSize]) {
		value.merge(nextValue(), uniquingKeysWith: { $1 })
	}
}

//
//
//	private func currentItemOffset(_ geometry: GeometryProxy) -> CGFloat {
//		guard let currentItem = currentItem else {
//			return 0
//		}
//
//		let currentIndex = CGFloat(items.index(of: currentItem) ?? 0)
//		return -1 * currentIndex * geometry.size.width
//	}
//
//
//	private func currentItem(for translation: CGFloat, in geometry: GeometryProxy) -> CarouselItem? {
//		guard let currentItem = currentItem else {
//			return nil
//		}
//
//		let currentIndex = CGFloat(items.index(of: currentItem) ?? 0)
//		let proposedIndex = -1 * (translation / geometry.size.width) + currentIndex
//		let maxIndex = CGFloat(items.count - 1)
//
//		switch proposedIndex {
//		case ..<0:
//			return items.last
//		case 0..<maxIndex:
//			return items[Int(proposedIndex)]
//		default:
//			return items.first
//		}
//	}

//
//struct CarouselView: View {
//	let items: CarouselList
//
//	@State private var currentIndex: Int = 0
//
//	var body: some View {
//		GeometryReader { geometry in
//			ScrollView(.horizontal, showsIndicators: false) {
//				HStack(spacing: 20) {
//					ForEach(0..<self.items.count, id: \.self) { index in
//						GeometryReader { innerGeometry in
//							CarouselItemView(item: self.items[index])
//								.offset(x: self.offset(for: index, in: innerGeometry))
//								.onTapGesture {
//									self.currentIndex = index
//								}
//						}
//						.frame(width: geometry.size.width - 40)
//						.onAppear {
//							if index == 0 {
//								self.currentIndex = 0
//							}
//						}
//					}
//				}
//			}
//			.frame(width: geometry.size.width)
//			.offset(x: -CGFloat(self.currentIndex) * (geometry.size.width - 40))
//			.gesture(
//				DragGesture()
//					.onEnded { value in
//						let offsetX = value.predictedEndTranslation.width / (geometry.size.width - 40)
//						let newIndex = self.currentIndex - Int(offsetX)
//						let validIndex = max(0, min(self.items.count - 1, newIndex))
//						withAnimation {
//							self.currentIndex = validIndex
//						}
//					}
//			)
//		}
//	}
//
//	private func offset(for index: Int, in geometry: GeometryProxy) -> CGFloat {
//		let xOffset = CGFloat(index) * (geometry.size.width - 40)
//		let maxOffset = CGFloat(self.items.count - 1) * (geometry.size.width - 40)
//
//		let dragOffset = geometry.size.width - 40
//		let offset = xOffset - dragOffset * CGFloat(self.currentIndex)
//
//		if self.currentIndex == 0 && index == self.items.count - 1 {
//			return offset - maxOffset
//		} else if self.currentIndex == self.items.count - 1 && index == 0 {
//			return offset + maxOffset
//		} else {
//			return offset
//		}
//	}
//}
//
//
//struct CarouselItemView: View {
//	let item: CarouselItem
//
//	var body: some View {
//		ZStack(alignment: .bottomLeading) {
//			item.color
//				.frame(width: 100, height: 100)
//
//			Text(item.title)
//				.font(.title)
//				.foregroundColor(.white)
//				.padding()
//		}
//	}
//}
//








//
//import SwiftUI
//
//
//struct ContentView_V2: View {
//
//
//
//
//
//
//	@State private var selectedIndex = 0
//
//	private let rows: [GridItem] = [
//		GridItem(.fixed(300))
//	]
//
//	private var timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
//
//	var body: some View {
//		// Apple docs:
//		// https://developer.apple.com/documentation/swiftui/scrollviewreader
//		ScrollViewReader { proxy in
//			ScrollView(.horizontal, showsIndicators: false) {
//				LazyHGrid(rows: rows, spacing: 0) {
//					ForEach(languages, id:\.self) { item in
//						HStack {
//							Image(item.image)
//								.resizable()
//								.aspectRatio(contentMode: .fit)
//						}
//						.frame(maxHeight: .infinity)
//						.frame(width: 300)
//						.background(.white)
//						.cornerRadius(12)
//						.padding(.horizontal, 20)
//					}
//					.onAppear {
//						withAnimation {
//							proxy.scrollTo(languages[selectedIndex])
//						}
//					}
//					.onReceive(timer) { _ in
//						withAnimation {
//							if selectedIndex < languages.count - 1 {
//								selectedIndex += 1
//								proxy.scrollTo(languages[selectedIndex])
//							}
//						}
//					}
//				}
//			}
//			.frame(maxHeight: 400)
//			.background(.black)
//		}
//	}
//}
//
//struct ContentView_Previews_V2: PreviewProvider {
//	static var previews: some View {
//		ContentView_V2()
//	}
//}




//struct CarouselView<Content: View>: View {
//	let content: () -> Content
//	@State private var currentIndex = 0
//
//	var body: some View {
//		GeometryReader { geometry in
//			ScrollView(.horizontal, showsIndicators: false) {
//				HStack(spacing: 0) {
//					self.content()
//				}
//			}
//			.onPreferenceChange(CarouselIndexKey.self) { index in
//				self.currentIndex = index
//			}
//			.coordinateSpace(name: "carousel")
//		}
//	}
//}
//struct CarouselCard<Content: View>: View {
//	let index: Int
//	let content: () -> Content
//
//	var body: some View {
//		GeometryReader { geometry in
//			self.content()
//				.frame(width: geometry.size.width, height: geometry.size.height)
//				.background(GeometryReader {_ in
//					Color.clear.preference(key: CarouselIndexKey.self, value: self.index)
//				})
//		}
//	}
//}
//struct ContentView: View {
//	var body: some View {
//		CarouselView {
//			HStack {
//				Text("123")
//			}
//		}
//	}
//}



//
//
//import SwiftUI
//struct InfinityCarousel<T: View>: View {
//	let views: [T]
//	@State private var offset: CGFloat = 0
//	@State private var size: CGSize = .zero
//
//	var body: some View {
//		GeometryReader { geometry in
//
//			ScrollView(.horizontal, showsIndicators: false) {
//				HStack(spacing: 0) {
//					ForEach(views.indices) { index in
//						views[index]
//							.frame(width: geometry.size.width, height: geometry.size.height)
//							.preference(key: SizePreferenceKey.self, value: [index: geometry.size])
//					}
//				}
//				.offset(x: -offset)
//				.animation(.easeInOut(duration: 0.3))
//				.onPreferenceChange(SizePreferenceKey.self) { sizes in
//					var width: CGFloat = 0
//					sizes.forEach { size in
//						width += self.size.width
//						if size.key == views.count - 1 {
//							offset = width - self.size.width
//						}
//					}
//				}
//				.background(GeometryReader {
//					Color.clear.preference(key: SizePreferenceKey.self, value: [0: $0.size])
//				})
//				.onPreferenceChange(SizePreferenceKey.self) { sizes in
//					if let firstSize = sizes[0] {
//						size = firstSize
//					}
//				}
//				.contentShape(Rectangle())
//
//			}
//		}
//		.clipped()
//		.onAppear {
//			Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
//				withAnimation {
//					offset += size.width
//				}
//				if offset >= CGFloat(views.count) * size.width {
//					offset = 0
//				}
//			}
//		}
//	}
//}
//
//struct SizePreferenceKey: PreferenceKey {
//	static var defaultValue: [Int: CGSize] = [:]
//
//	static func reduce(value: inout [Int: CGSize], nextValue: () -> [Int: CGSize]) {
//		value.merge(nextValue(), uniquingKeysWith: { $1 })
//	}
//}
//
//struct ContentView: View {
//	let colors: [Color] = [.red, .blue, .green, .purple, .yellow]
//
//	var body: some View {
//		InfinityCarousel(views: colors.map { color in
//			VStack {
//				Text(color.description)
//				Rectangle()
//					.fill(color)
//			}
//
//		})
//		.frame(height: 200)
//	}
//}
//
