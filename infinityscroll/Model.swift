//
//  Model.swift
//  infinityscroll
//
//  Created by Viktor on 16.02.2023.
//

import SwiftUI

class CarouselItem: Identifiable, Equatable {
	static func == (lhs: CarouselItem, rhs: CarouselItem) -> Bool {
		lhs.id == rhs.id
	}
	
	let id = UUID()
	let title: String
	let color: Color
	var previous: CarouselItem?
	var next: CarouselItem?
	
	init(title: String, color: Color) {
		self.title = title
		self.color = color
	}
}

class CarouselList {
	var head: CarouselItem?
	var tail: CarouselItem?
	
	func append(_ item: CarouselItem) {
		if head == nil {
			head = item
			tail = item
		} else {
			tail?.next = item
			item.previous = tail
			tail = item
		}
	}
}


extension CarouselList: RandomAccessCollection {
	var startIndex: Int {
		return 0
	}
	
	var endIndex: Int {
		return count
	}
	
	subscript(position: Int) -> CarouselItem {
		var currentItem = head
		for _ in 0..<position {
			currentItem = currentItem?.next
		}
		return currentItem!
	}
}

extension CarouselList {
	var count: Int {
		var count = 0
		var currentItem = head
		while currentItem != nil {
			count += 1
			currentItem = currentItem?.next
			if currentItem == head {
				break
			}
		}
		return count
	}
	
	func index(of item: CarouselItem) -> Int? {
		var index = 0
		var currentItem = head
		while currentItem != nil {
			if currentItem == item {
				return index
			}
			index += 1
			currentItem = currentItem?.next
			if currentItem == head {
				break
			}
		}
		return nil
	}
}
