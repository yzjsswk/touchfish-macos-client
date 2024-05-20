import SwiftUI

struct FishListView: View {
    
    var fishList: [Fish]
    
    @Binding var isEditing: Bool
    
    @Binding var selectedFishIdentity: String?
    
    @State var hoveringFishIdentity: String?
    
    @State var lastHoverTs: TimeInterval = Date().timeIntervalSince1970
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    ForEach(fishList, id: \.identity) { fish in
                        FishListItemView(
                            fish: fish,
                            isEditing: $isEditing,
                            selectedFishIdentity: $selectedFishIdentity,
                            hoveringFishIdentity: $hoveringFishIdentity
                        )
                        .onHover { isHovered in
                            if isHovered {
                                selectedFishIdentity = fish.identity
                                if hoveringFishIdentity != fish.identity {
                                    hoveringFishIdentity = nil
                                }
                                lastHoverTs = Date().timeIntervalSince1970
                                let hoverTs = lastHoverTs
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    if isHovered && lastHoverTs == hoverTs {
                                        withAnimation(.spring(duration: 0.4)) {
                                            hoveringFishIdentity = fish.identity
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(.vertical, 5)
            }
            HStack {
                Text("total: \(fishList.count)")
                    .font(.system(.footnote, design: .monospaced))
                Spacer()
            }
            
        }

    }
    
}



