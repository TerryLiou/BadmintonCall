//
//  GridView.swift
//  BadmintonCall_SwiftUI
//
//  Created by 劉洧熏 on 2024/10/28.
//

import SwiftUI
import SwiftUICore

enum PartnerBtnState {
    case normal
    case selected
    
    var text: String {
        switch self {
        case .normal:
            return "不綁定"
        case .selected:
            return "隊友"
        }
    }
    
    var textColor: Color {
        switch self {
        case .normal:
            return .gray
        case .selected:
            return .primary
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .normal:
            return Color(uiColor: UIColor())
        case .selected:
            return .green
        }
    }
    
    var disable: Bool {
        switch self {
        case .normal:
            return true
        case .selected:
            return false
        }
    }
}

struct GridView: View {
    @EnvironmentObject var dataModel: PlayerViewModel
    
    let onItemTapped: (Player) -> Void
    let onItemLongPress: (Player) -> Void
    
    let columns = [
        GridItem(.flexible(minimum: 100, maximum: 200), spacing: 10),
        GridItem(.flexible(minimum: 100, maximum: 200), spacing: 10)
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(dataModel.players) { player in
                    GridCell(playerInfo: player) { player in
                        onItemTapped(player)
                    } onItemLongPress: { player in
                        onItemLongPress(player)
                    }
                }
            }
        }
    }
}

struct GridCell: View {
    @EnvironmentObject var dataModel: PlayerViewModel
    @State private var showPopover: Bool = false
    @State private var partnerState: PartnerBtnState = .normal
    
    let playerInfo: Player
    let onItemTapped: (Player) -> Void
    let onItemLongPress: (Player) -> Void
    
    var body: some View {
        ZStack {
            VStack {
                Text(playerInfo.name)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Divider()
                    .background(.gray.opacity(0.1))
                
                HStack {
                    Text(playerInfo.level.nameTag)
                        .font(.caption2)
                        .fontWeight(.bold)
                        .padding(EdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4))
                        .cornerRadius(3)
                        .background(Color.black.opacity(0.1))
                        .overlay {
                            RoundedRectangle(cornerRadius: 3, style: .circular)
                                .stroke(Color.white, lineWidth: 0.5)
                        }
                    Text("上場次數： \(playerInfo.playTimes)" )
                        .font(.caption)
                        .fontWeight(.thin)
                        .frame(maxWidth: .infinity, alignment: .bottomTrailing)
                }
                .padding(EdgeInsets(top: 4, leading: 0, bottom: 0, trailing: 0))
            }
            .padding()
            .foregroundColor(.white)
            .background(playerInfo.level.color)
            .cornerRadius(8)
            .onTapGesture {
                onItemTapped(playerInfo)
            }
            .onLongPressGesture(minimumDuration: 2.0) {
                onItemLongPress(playerInfo)
            }
            
            Button{
                showPopover = true
            } label: {
                Text("XXX")
            }
            .foregroundColor(.red)
            .background(.white)
            .frame(width: 16, height: 16)
            .position(CGPoint(x: 12, y: 12))
            .popover(isPresented: $showPopover) {
                VStack {
                    HStack {
                        Button {
                            switch partnerState {
                            case .normal:
                                partnerState = .selected
                            case .selected:
                                partnerState = .normal
                            }
                        } label: {
                            Text(partnerState.text)
                                .foregroundColor(partnerState.textColor)
                                .background(partnerState.backgroundColor)
                                .cornerRadius(8.0)
                        }

                        Text("Partner")
                            .padding()
                            .font(.subheadline)
                            .foregroundColor(.black)
                        
                        Menu {
                            ForEach(dataModel.players) { player in
                                Button {
                                    dataModel.setupPartner(for: playerInfo, by: player.id.uuidString)
                                } label: {
                                    Text(player.name)
                                }
                            }
                        } label: {
                            Text("球友名單")
                        }
                    }
                    Text("Popup View")
                        .padding()
                        .background(Color.yellow)
//                        .cornerRadius(10)
//                        .frame(width: 300, height: 200)
                }
                .onTapGesture {
                    withAnimation {
                        self.showPopover = false
                    }
                }
                .cornerRadius(10)
                .frame(width: 300, height: 200)
            }
        }
    }
    
    var playerInfoContent: some View {
        VStack {
            Text(playerInfo.name)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .center)
            
            Divider()
                .background(.gray.opacity(0.1))
            
            HStack {
                Text(playerInfo.level.nameTag)
                    .font(.caption2)
                    .fontWeight(.bold)
                    .padding(EdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4))
                    .cornerRadius(3)
                    .background(Color.black.opacity(0.1))
                    .overlay {
                        RoundedRectangle(cornerRadius: 3, style: .circular)
                            .stroke(Color.white, lineWidth: 0.5)
                    }
                Text("上場次數： \(playerInfo.playTimes)" )
                    .font(.caption)
                    .fontWeight(.thin)
                    .frame(maxWidth: .infinity, alignment: .bottomTrailing)
            }
            .padding(EdgeInsets(top: 4, leading: 0, bottom: 0, trailing: 0))
        }
        .padding()
        .foregroundColor(.white)
        .background(playerInfo.level.color)
        .cornerRadius(8)
        .onTapGesture {
            onItemTapped(playerInfo)
        }
        .onLongPressGesture(minimumDuration: 2.0) {
            onItemLongPress(playerInfo)
        }
    }
    
    var playerStateView: some View {
        VStack {
            HStack {
                Button {
                    
                } label: {
                    Text("隊友")
                        .padding()
                        .font(.subheadline)
                        .foregroundColor(.black)
                }

                Menu {
                    ForEach(dataModel.players) { player in
                        Button {
                            dataModel.setupPartner(for: playerInfo, by: player.id.uuidString)
                        } label: {
                            Text(player.name)
                        }
                    }
                } label: {
                    Text("球友名單")
                }
            }
            Text("Popup View")
                .padding()
                .background(Color.yellow)
                .cornerRadius(10)
                .frame(width: 300, height: 200)
        }
        .onTapGesture {
            withAnimation {
                self.showPopover = false
            }
        }
    }
}

