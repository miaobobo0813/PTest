//
//  QuestionView.swift
//  PTest
//
//  Created by miaobobo on 2026/4/28.
//

import SwiftUI

struct QuestionView: View {
    var title: String
    var context: String
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.title)
                if let markdown = try? AttributedString(markdown: context
                    .replacingOccurrences(of: "\n\n", with: "\n")
                    .replacingOccurrences(of: "```\n", with: "")
                    .replacingOccurrences(of: "#", with: "")
                    .replacingOccurrences(of: "# ", with: "")
                    .replacingOccurrences(of: "$", with: "*")
                    .replacingOccurrences(of: "\\leq", with: "≤")
                    .replacingOccurrences(of: "\\le", with: "≤")
                    .replacingOccurrences(of: "\\leqslant", with: "≤")
                    .replacingOccurrences(of: "\\geq", with: "≥")
                    .replacingOccurrences(of: "\\ge", with: "≥")
                    .replacingOccurrences(of: "\\geqslant", with: "≥")
                    .replacingOccurrences(of: "\\times", with: "×")
                    .replacingOccurrences(of: "\\alpha", with: "α")
                    .replacingOccurrences(of: "\\beta", with: "β")
                    .replacingOccurrences(of: "\\pi", with: "π")
                    .replacingOccurrences(of: "\\omega", with: "Ω")
                    .replacingOccurrences(of: "\\infty", with: "∞")
                    .replacingOccurrences(of: "\\in", with: "∈")
                    .replacingOccurrences(of: "\\varnothing", with: "∅")
                    .replacingOccurrences(of: "\\approx", with: "≈")
                    .replacingOccurrences(of: "\\neq", with: "≠")
                    .replacingOccurrences(of: "\\pm", with: "±")
                    .replacingOccurrences(of: "\\cdot", with: "·")
                    .replacingOccurrences(of: "\\div", with: "÷")
                    .replacingOccurrences(of: "\\sum", with: "∑")
                    .replacingOccurrences(of: "\\int", with: "∫")
                    .replacingOccurrences(of: "\\inf", with: "∞")
                    .replacingOccurrences(of: "\\notin", with: "∉")
                    .replacingOccurrences(of: "\\subseteq", with: "⊆")
                    .replacingOccurrences(of: "\\subset", with: "⊂")
                    .replacingOccurrences(of: "\\cup", with: "∪")
                    .replacingOccurrences(of: "\\cap", with: "∩")
                    .replacingOccurrences(of: "\\land", with: "∧")
                    .replacingOccurrences(of: "\\lor", with: "∨")
                    .replacingOccurrences(of: "\\forall", with: "∀")
                    .replacingOccurrences(of: "\\exists", with: "∃")
                    .replacingOccurrences(of: "\\delta", with: "δ")
                    .replacingOccurrences(of: "\\Delta", with: "Δ")
                    .replacingOccurrences(of: "\\sigma", with: "σ")
                    .replacingOccurrences(of: "\\lambda", with: "λ")
                    .replacingOccurrences(of: "\\theta", with: "θ")
                    .replacingOccurrences(of: "\\epsilon", with: "ε")
                    .replacingOccurrences(of: "\\ldots", with: "...")
                    .replacingOccurrences(of: ". ", with: ".")
                    .replacingOccurrences(of: "- ", with: "·")
                    .replacingOccurrences(of: "\n", with: "  \n")){
                    Text(markdown)
                        .lineLimit(nil)
                        .multilineTextAlignment(.leading)
                        .textSelection(.enabled)
                } else {
                    Text(context)
                        .lineLimit(nil)
                        .multilineTextAlignment(.leading)
                        .textSelection(.enabled)
                }
            }
            .frame(alignment: .leading)
        }
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(title: "Test", context: "#题目描述  \n输入一个整数n，输出n/3并向下取整。  \n#样例  \n#1 INP:  \n```hello```  \n```goodbye```  \n#1 OUT:  \n4  \n#数据范围: n <= 1e9")
    }
}
