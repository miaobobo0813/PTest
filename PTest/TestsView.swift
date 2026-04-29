//
//  TestsView.swift
//  PTest
//
//  Created by miaobobo on 2026/4/29.
//

import SwiftUI

struct TestsView: View {
    @State private var showTests = false
    var tests: String
    @State var testsAfterTranslate: [Tests] = []
    @State private var programOutputs: [Int: String] = [:]
    @State private var checks: [Int: Int] = [:] // 0: Haven't check yet 1: Checked, and it's right -1: Checked, and it's wrong.
    @State private var isAccept = false
    
    var body: some View {
        if (showTests){
            List {
                ForEach(testsAfterTranslate) { item in
                    VStack(alignment: .leading) {
                        Text("#\(item.id) INP: ")
                        if let markdown = try? AttributedString(markdown: item.input){
                            Text(markdown)
                                .lineLimit(nil)
                                .multilineTextAlignment(.leading)
                                .textSelection(.enabled)
                        } else {
                            Text(item.input)
                                .lineLimit(nil)
                                .multilineTextAlignment(.leading)
                                .textSelection(.enabled)
                        }
                        HStack {
                            TextField("Enter program output", text: Binding(get: {programOutputs[item.id] ?? ""}, set: {programOutputs[item.id] = $0}))
                                .textFieldStyle(.squareBorder)
                            Button {
                                checkAnswer(id: item.id)
                            } label: {
                                Label("Check answer.", systemImage: "magnifyingglass")
                                    .labelStyle(.iconOnly)
                            }
                            switch checks[item.id] {
                            case 0:
                                Label("Haven't checked yet.", systemImage: "questionmark")
                                    .labelStyle(.iconOnly)
                                    .foregroundStyle(.gray)
                            case 1:
                                Label("AC", systemImage: "checkmark")
                                    .labelStyle(.iconOnly)
                                    .foregroundStyle(.green)
                            case -1:
                                Label("WA", systemImage: "xmark")
                                    .labelStyle(.iconOnly)
                                    .foregroundStyle(.red)
                            default:
                                Label("Haven't checked yet.", systemImage: "questionmark")
                                    .labelStyle(.iconOnly)
                                    .foregroundStyle(.gray)
                            }
                        }
                    }
                }
                if (isAccept){
                    Text("Congratulations, all tests passed!")
                        .foregroundStyle(.green)
                }
            }
        } else {
            VStack {
                Text("If you need tests, click the button below.")
                Button {
                    testsAfterTranslate = translateTests()
                    showTests = true
                } label: {
                    Label("Show Tests", systemImage: "eye")
                }
            }
        }
    }
    
    private func translateTests() -> [Tests] {
        let INP = "#(\\d+)INP:([^#]*)#(\\d+)OUT:([^#]*)"
        let regex = try! NSRegularExpression(pattern: INP)
        let range = NSRange(tests.startIndex..., in: tests)
        let matches = regex.matches(in: tests, range: range)
        
        var results: [Tests] = [Tests(id: 0, input: "Compile. (If Pass, type \"Passed\" in the field)", output: "Passed")]
        for match in matches {
            guard match.numberOfRanges == 5 else { continue }
            let nsInput = tests as NSString
            let id = Int(nsInput.substring(with: match.range(at: 1)))!
            let inpValue = "```"+nsInput.substring(with: match.range(at: 2))+"```"
            let outValue = nsInput.substring(with: match.range(at: 4))
            results.append(Tests(id: id, input: inpValue, output: outValue))
        }
        return results
    }
    
    private func checkAnswer(id: Int) {
        if (programOutputs[id] == testsAfterTranslate[id].output){
            checks[id] = 1;
        } else {
            checks[id] = -1;
        }
        var sum = 0
        for check in checks {
            sum += check.value
        }
        if (sum == testsAfterTranslate.last!.id+1){
            isAccept = true
        }
    }
}

struct TestsView_Previews: PreviewProvider {
    static var previews: some View {
        TestsView(tests: "#1INP:12#1OUT:3#2INP:30#2OUT:7")
    }
}
