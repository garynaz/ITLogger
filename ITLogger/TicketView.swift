//
//  TicketView.swift
//  ITLogger
//
//  Created by Gary Naz on 2/23/21.
//

import SwiftUI

struct TicketView: View {
        
    var body: some View {
        List{
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    Text("Health Bound")
                        .font(.system(size: 20, weight: .bold))
                        .fixedSize()
                    Text("Jan 11")
                        .font(.caption)
                        .fontWeight(.bold)
                        .fixedSize()
                        .foregroundColor(.secondary)
                    Text("Completed")
                        .padding()
                        .frame(width: .infinity, height: 50)
                        .background(Color.green)
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                        .lineLimit(1)
                        .fixedSize()
                        .padding(.leading,90)
                }.padding(.bottom, 5)

                Text("Submitted By: Gary Nazarian")
                    .font(.system(size: 15, weight: .light))
                    .padding(.bottom, 5)

                Text("Can you please check my Outlook. It's constantly freezing and I'm not receiving my emails.")
                    .lineLimit(2)
                    .foregroundColor(.gray)
            }
        }
    }
}

struct TicketView_Previews: PreviewProvider {
    static var previews: some View {
        TicketView()
    }
}
