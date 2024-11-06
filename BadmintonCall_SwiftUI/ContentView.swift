//
//  ContentView.swift
//  BadmintonCall_SwiftUI
//
//  Created by 劉洧熏 on 2024/10/1.
//

import SwiftUI
import CoreData
import UniformTypeIdentifiers

struct ContentView: View {
    @State private var showAlert: Bool = false
    @State private var selectedPeople: [Player] = []
    @State private var newName: String = ""
    @State private var selectedOption: Gender = .male
    @State private var levelOption: Level = .middle
    
    @EnvironmentObject private var todayPlayer: PlayerViewModel
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    
    private var items: FetchedResults<Item>
    private var courtCount: [String] = ["1 號場地", "2 號場地", "3 號場地", "4 號場地"]
    
    @State private var courts: [GameModel] = [GameModel( courtCount: 4),
                                       GameModel( courtCount: 4),
                                       GameModel( courtCount: 4),
                                       GameModel( courtCount: 4)]
    
    let collectionCells = Array(1...50).map { "Item \($0)" }
    
    // GridItem 定义每个单元格的布局
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
            ZStack {
                HStack {
                    // 左側固定寬度的 View
                    
                    VStack(spacing: 20) {
                        LazyVGrid(columns: columns) {
                            ForEach(Array(courtCount.enumerated()), id: \.element) { index, item in
                                Button(action: {
                                    if selectedPeople.count == 4 {
                                        courts[index].player = selectedPeople
                                        selectedPeople.removeAll()
                                    } else {
                                        
                                    }
                                }) {
                                    Text(item)
                                        .padding()
                                        .background(Color.gray.opacity(0.3))
                                        .cornerRadius(8)
                                }
                                .disabled(!courts[index].player.isEmpty)
                            }
                        }
                        .frame(width: 300, height: 140)
                        
                        // 顯示已選擇的物品
                        VStack {
                            Text("Selected Players")
                                .font(.headline)
                                .padding(.bottom, 5)
                            
                            LazyVGrid(columns: columns) {
                                ForEach(selectedPeople) { item in
                                    Text(item.name)
                                        .padding()
                                        .background(Color.gray.opacity(0.3))
                                        .cornerRadius(8)
                                }
                            }
                            .frame(width: 300, height: 140)
                            .border(Color.gray)
                            .cornerRadius(8)
                            
                            HStack {
                                Button(action: {}) {
                                    Text("男雙")
                                }
                                
                                Button(action: {}) {
                                    Text("女雙")
                                }
                                
                                Button(action: {}) {
                                    Text("混雙")
                                }
                            }
                            
                            Button(action: {
                                showAlert = true
                            }) {
                                Text("新增球友")
                            }
                            .frame(width: 120, height: 40)
                            .background(Color.cyan)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .overlay {
                                Group {
                                    if showAlert {
                                        Color.black.opacity(0.4) // 半透明背景
                                            .edgesIgnoringSafeArea(.all)
                                        alertView()
                                            .background(Color.white) // 白色背景
                                            .cornerRadius(12)
                                            .shadow(radius: 20)
                                            .padding()
                                    }
                                }
                            }
                        }
                        
                        Divider()
                        
                        GridView(onItemTapped: { item in
                            if selectedPeople.count < 4 {
                                selectedPeople.append(item)
                                todayPlayer.removePlayer(by: item.id)
                            }
                        }, onItemLongPress: { item in
                            print("Long Press")
                            //                        allItems.removeAll(where: { $0.id == item.id })
                        })
                    }
                    .frame(maxWidth: 300, maxHeight: .infinity, alignment: .top)
                    
                    Divider()
                    
                    ScrollView {
                        ForEach(courtCount.indices, id: \.self) { itemIndex in
                            // 使用圖片作為背景
                            ZStack {
                                Image("badmintonCourt") // 替換為背景圖名稱
                                    .resizable()
                                    .frame(width: 536, height: 244) // 設定固定大小
                                    .cornerRadius(8)
                                Text(courtCount[itemIndex])
                                    .foregroundColor(.white)
                                    .bold()
                                
                                if !courts[itemIndex].player.isEmpty {
                                    LazyVGrid(columns: columns, spacing: 40) {
                                        ForEach(courts[itemIndex].player, id: \.self) { player in
                                            Text(player.name)
                                                .font(.largeTitle)
                                                .padding()
                                                .background(Color.gray.opacity(0.3))
                                                .cornerRadius(8)
                                        }
                                    }
                                    .frame(width: 400, height: 200)
                                    .cornerRadius(8)
                                }
                            }
                            
                            Button(action: {
                                if !courts[itemIndex].player.isEmpty {
                                    todayPlayer.players += courts[itemIndex].player
                                    courts[itemIndex].player.removeAll()
                                }
                            }) {
                                Text("下場")
                            }
                            .frame(width: 64, height: 30)
                            .background(.cyan)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                        }
                        .padding(EdgeInsets(top: 10, leading: 30, bottom: 20, trailing: 10))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
    }
    
    private func alertView() -> some View {
        VStack(spacing: 20) {
            Text("Enter Your Name")
                .font(.headline)

            // 輸入框
            TextField("Name", text: $newName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            // 下拉式選單
//            Picker("Select an Option", selection: $selectedOption) {
//                ForEach(Gender, id: \.self) { option in
//                    Text(option)
//                }
//            }
            .pickerStyle(MenuPickerStyle()) // 最佳顯示方式

            // 確認和取消按鈕
            HStack {
                Button("OK") {
                    // 在這裡您可以處理用戶的輸入，例如將其送交伺服器
//                    print("Name: \(name), Selected Option: \(selectedOption)")
//                    allItems.append(Player(name: newName, gender: .male, level: .middle))
                    showAlert = false // 關閉警告
                }
                .padding()

                Button("Cancel") {
                    showAlert = false // 關閉警告
                }
                .padding()
            }
        }
        .padding()
        .frame(width: 300)
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct PopupView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            Text("This is a Popup!")
            Button(action: {
                isPresented = false
            }) {
                Text("Dismiss")
            }
        }
        .frame(width: 200, height: 200)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

struct ExternalDropDelegate: DropDelegate {
    @Binding var externalGridItems: [String]
    
    func performDrop(info: DropInfo) -> Bool {
        if let item = info.itemProviders(for: [UTType.text]).first {
            item.loadItem(forTypeIdentifier: UTType.text.identifier, options: nil) { data, error in
                if let data = data as? Data, let string = String(data: data, encoding: .utf8) {
                    DispatchQueue.main.async {
                        externalGridItems.append(string)
                    }
                }
            }
            return true
        }
        return false
    }
}

#Preview {
    ContentView()
        .environment(\.managedObjectContext,
                      PersistenceController.preview.container.viewContext)
        .environmentObject(PlayerViewModel(isDemo: true))
}
