//
//  CustomSwipeAction.swift
//  ExpenseTracker
//
//  Created by Rogério Toledo on 15/12/23.
//

import SwiftUI

enum SwipeDirection {
	case leading, trailing
	var alignment: Alignment {
		switch self {
		case .leading: return .leading
		case .trailing: return .trailing
		}
	}
}

struct OffsetKey: PreferenceKey {
	static var defaultValue: CGFloat = .zero
	static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
		value = nextValue()
	}
}

struct Action: Identifiable {
	private (set) var id: UUID = .init()
	var tint: Color
	var icon: String
	var iconFont: Font = .title
	var iconTint: Color = .white
	var isEnabled: Bool = true
	var action: () -> ()
}

@resultBuilder
struct ActionBuilder {
	static func buildBlock(_ components: Action...) -> [Action] {
		return components
	}
}

struct CustomTransition: Transition {
	func body(content: Content, phase: TransitionPhase) -> some View {
		content
			.mask {
				GeometryReader { geometry in
					let size = geometry.size
					Rectangle()
						.offset(y: phase == .identity ? 0 : -size.height)
				}
				.containerRelativeFrame(.horizontal)
			}
	}
}


struct SwipeAction<Content: View>: View {
	var cornerRadius: CGFloat = 0
	var direction: SwipeDirection = .trailing
	
	@ViewBuilder var content: Content
	@ActionBuilder var actions: [Action]
	@Environment(\.colorScheme) private var scheme
	
	let viewID: String = "CONTENTVIEW"
	@State private var isEnabled: Bool = true
	@State private var scrollOffset: CGFloat = .zero
	
	var filteredActions: [Action] {
		return actions.filter({ $0.isEnabled  })
	}
    
	var body: some View {
		ScrollViewReader { proxy in
			ScrollView(.horizontal) {
				LazyHStack(spacing: 0) {
					content
						.rotationEffect(.init(degrees: direction == .leading ? -180 : 0))
						.containerRelativeFrame(.horizontal)
						.background(scheme == .dark ? .black : .white)
						.background {
							if let firstAction = filteredActions.first {
								Rectangle()
									.fill(firstAction.tint)
									.opacity(scrollOffset == .zero ? 0 : 1)
							}
						}
						.id(viewID)
						.transition(.identity)
						.overlay {
							GeometryReader {
								let minX = $0.frame(in: .scrollView(axis: .horizontal)).minX
								Color.clear
									.preference(key: OffsetKey.self, value: minX)
									.onPreferenceChange(OffsetKey.self) {
										scrollOffset = $0
									}
							}
						}
					
					ActionButtons {
						withAnimation(.snappy) {
							proxy.scrollTo(viewID, anchor: direction == .trailing ? .topLeading : .topTrailing)
						}
					}
					.opacity(scrollOffset == .zero ? 0 : 1)
				}
				.scrollTargetLayout()
				.visualEffect { content, geometryProxy in
					content
						.offset(x: scrollOffset(geometryProxy))
				}
			}
			.scrollIndicators(.hidden)
			.scrollTargetBehavior(.viewAligned)
			.background {
				if let lastAction = filteredActions.last {
					Rectangle()
						.fill(lastAction.tint)
						.opacity(scrollOffset == .zero ? 0 : 1)
				}
			}
			.clipShape(.rect(cornerRadius: cornerRadius))
		}
		.allowsHitTesting(isEnabled)
		.transition(CustomTransition())
    }
	
	@ViewBuilder
	private func ActionButtons(resetPosition: @escaping () -> ()) -> some View {
		Rectangle()
			.fill(.clear)
			.frame(width: CGFloat(filteredActions.count) * 100)
			.overlay(alignment: direction.alignment) {
				HStack(spacing: 0) {
					ForEach(filteredActions) { action in
						Button(action: {
							Task {
								isEnabled = false
								resetPosition()
								try? await Task.sleep(for: .seconds(0.25))
								action.action()
								try? await Task.sleep(for: .seconds(0.1))
								isEnabled = true
							}
						}, label: {
							Image(systemName: action.icon)
								.font(action.iconFont)
								.foregroundStyle(action.iconTint)
								.frame(width: 100)
								.frame(maxHeight: .infinity)
								.contentShape(.rect)
						})
						.buttonStyle(.plain)
						.background(action.tint)
					}
				}
			}
	}
	
	private func scrollOffset(_ proxy: GeometryProxy) -> CGFloat {
		let minX = proxy.frame(in: .scrollView(axis: .horizontal)).minX
		return direction == .trailing ? (minX > 0 ? -minX : 0) : (minX < 0 ? -minX : 0)
	}
}
