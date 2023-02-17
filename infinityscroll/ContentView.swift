//
//  ContentView.swift
//  infinityscroll
//
//  Created by Viktor on 15.02.2023.
//

import SwiftUI

struct ContentView: View {
	let carouselItems = CarouselList()

	init() {
		carouselItems.append(CarouselItem(title: "1 Item", color: Color.blue))
		carouselItems.append(CarouselItem(title: "2 Item", color: Color.orange))
		carouselItems.append(CarouselItem(title: "3 Item", color: Color.red))
		carouselItems.append(CarouselItem(title: "4 Item", color: Color.gray))
		carouselItems.append(CarouselItem(title: "5 Item", color: Color.green))
		carouselItems.head?.previous = carouselItems.tail
		carouselItems.tail?.next = carouselItems.head
	}

	var body: some View {
		CarouselView(items: carouselItems)
	}
}
