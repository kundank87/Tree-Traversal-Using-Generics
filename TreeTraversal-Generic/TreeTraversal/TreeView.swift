//
//  TreeView.swift
//  TreeTraversal
//
//  Created by Kundan Kumar on 01/02/26.
//

import SwiftUI
import Combine

// Generic Tree Node
class TreeNode<T> {
    var value: T
    var left: TreeNode?
    var right: TreeNode?
    
    init(_ value: T) {
        self.value = value
    }
}

// Traversal Logic
enum TraversalType {
    case inOrder, preOrder, postOrder
}

class TreeView<T>: ObservableObject {
    @Published var traversalResult: [T] = []
    var root: TreeNode<T>?

    func runTraversal(_ type: TraversalType) {
        traversalResult = [] // Clear previous results
        switch type {
        case .inOrder:
            inOrder(root)
        case .preOrder:
            preOrder(root)
        case .postOrder:
            postOrder(root)
        }
    }

    private func inOrder(_ node: TreeNode<T>?) {
        guard let node = node else { return }
        inOrder(node.left)
        traversalResult.append(node.value)
        inOrder(node.right)
    }

    private func preOrder(_ node: TreeNode<T>?) {
        guard let node = node else { return }
        traversalResult.append(node.value)
        preOrder(node.left)
        preOrder(node.right)
    }

    private func postOrder(_ node: TreeNode<T>?) {
        guard let node = node else { return }
        postOrder(node.left)
        postOrder(node.right)
        traversalResult.append(node.value)
    }
}
