//
//  BinaryTreeDashboard.swift
//  TreeTraversal
//
//  Created by Kundan Kumar on 31/01/26.
//

import SwiftUI

struct BinaryTreeDashboard: View {
    @StateObject private var viewModel = TreeView<Int>()
    
    init() {
        let root = TreeNode(10)
        root.left = TreeNode(5)
        root.right = TreeNode(15)
        root.left?.left = TreeNode(2)
        root.left?.right = TreeNode(8)
        root.right?.left = TreeNode(12)
        root.right?.right = TreeNode(20)
        
        _viewModel = StateObject(wrappedValue: {
            let vm = TreeView<Int>()
            vm.root = root
            return vm
        }())
    }
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Tree Visualizer").font(.largeTitle.bold())

            // 1. THE VISUAL TREE
            if let root = viewModel.root {
                RecursiveTreeRow(node: root, resultSet: viewModel.traversalResult)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 15).fill(Color.gray.opacity(0.05)))
            }

            // 2. CONTROLS
            HStack {
                Button("Pre-order") { viewModel.runTraversal(.preOrder) }
                Button("In-order") { viewModel.runTraversal(.inOrder) }
                Button("Post-order") { viewModel.runTraversal(.postOrder) }
            }
            .buttonStyle(.borderedProminent)


            // 3. TEXT OUTPUT
            VStack(alignment: .leading) {
                Text("Traversal Sequence:").font(.headline)
                Text(viewModel.traversalResult.isEmpty ? "Select a mode" :
                     viewModel.traversalResult.map { "\($0)" }.joined(separator: " → "))
                    .font(.system(.title3, design: .monospaced))
                    .foregroundColor(.blue)
            }
            Spacer()
        }
        .padding()
    }
}

// Recursive Component to Draw the Tree
struct RecursiveTreeRow: View {
    let node: TreeNode<Int>
    let resultSet: [Int]

    var body: some View {
        VStack(spacing: 20) {
            // Node Circle
            Text("\(node.value)")
                .font(.headline)
                .foregroundColor(.white)
                .frame(width: 40, height: 40)
                .background(Circle().fill(resultSet.contains(node.value) ? Color.blue : Color.gray))
                .shadow(radius: 2)

            // Children Row
            HStack(alignment: .top, spacing: 20) {
                if let left = node.left {
                    RecursiveTreeRow(node: left, resultSet: resultSet)
                }
                if let right = node.right {
                    RecursiveTreeRow(node: right, resultSet: resultSet)
                }
            }
        }
    }
}

// Preview provider for the SwiftUI canvas
#Preview {
    BinaryTreeDashboard()
}

