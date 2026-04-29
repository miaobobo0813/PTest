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
                if let markdown = try? AttributedString(markdown: context.replacingOccurrences(of: "\n", with: "  \n")){
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
