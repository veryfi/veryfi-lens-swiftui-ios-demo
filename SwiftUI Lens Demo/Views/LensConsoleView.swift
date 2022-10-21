//
//  LensConsoleView.swift
//  SwiftUI Lens Demo
//
//  Created by Sebastian Giraldo on 21/10/22.
//

import SwiftUI
import VeryfiLens

struct LensConsoleView: View {
    var lensManager = LensManager()
    @State var lensEvents: [String] = []
    
    var body: some View {
        VStack {
            Text(lensEvents.isEmpty ? "Tap the button to try out Lens!" : "Lens Console")
                .bold(!lensEvents.isEmpty)
            List {
                ForEach(0..<lensEvents.count, id: \.self) { each in
                    Text(lensEvents[each])
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            Button("Launch Veryfi Lens") {
                lensManager.setDelegate(eventListener: eventListener)
                lensManager.configure()
                lensManager.showCamera()
            }
            .buttonStyle(.borderedProminent)
            .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
    }
    
    func eventListener(_ json: [String : Any]) -> Void {
        if let string = string(from: json) {
            lensEvents.append(string)
        }
    }
    
    func string(from json: [String : Any]) -> String? {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: json as Any, options: .prettyPrinted) else { return nil }
        return String(data: jsonData, encoding: .utf8)
    }
}

struct LensConsoleView_Previews: PreviewProvider {
    static var previews: some View {
        LensConsoleView()
    }
}
