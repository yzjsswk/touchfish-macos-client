import SwiftUI
import SwiftUICharts

struct StatsView: View {
    
    @State var statistics: CountFishResp? = nil
    
    var body: some View {
        ScrollView {
            if let statistics = statistics {
                VStack {
                    Text("Fish")
                        .font(.title)
                        .bold()
                        .padding(10)
                    HStack {
                        PieChartView(
                            title: "Historical Total Count: \(statistics.activeCount+statistics.expiredCount)",
                            slices: [
                                PieSlice(
                                    label: "Active",
                                    value: statistics.activeCount,
                                    color: Color.blue,
                                    extraColor: [Color.purple]
                                ),
                                PieSlice(
                                    label: "Expired",
                                    value: statistics.expiredCount,
                                    color: "#B7C9F3".color,
                                    extraColor: ["F4E0E3".color]
                                ),
                            ],
                            radius: 80
                        )
                        .frame(width: 350, height: 250)
                        .padding()
                        PieChartView(
                            title: "Count By Fish Type",
                            slices: [
                                PieSlice(
                                    label: "Text",
                                    value: statistics.typeCount["Text", default: 0],
                                    color: "#F0D5D5".color,
                                    extraColor: ["#FCFBC2".color]
                                ),
                                PieSlice(
                                    label: "Image",
                                    value: statistics.typeCount["Image", default: 0],
                                    color: "#4172CE".color,
                                    extraColor: ["#707BBA".color]
                                ),
                            ],
                            radius: 80
                        )
                        .frame(width: 350, height: 250)
                        .padding()
                    }
                    HStack {
                        PieChartView(
                            title: "Count By Mark Status",
                            slices: [
                                PieSlice(
                                    label: "Marked",
                                    value: statistics.markedCount,
                                    color: "#E24A42".color,
                                    extraColor: ["#E3C180".color]
                                ),
                                PieSlice(
                                    label: "Unmarked",
                                    value: statistics.unmarkedCount,
                                    color: "#FDF5E6".color,
                                    extraColor: ["FDF6EE".color]
                                ),
                            ],
                            radius: 80
                        )
                        .frame(width: 350, height: 250)
                        .padding()
                        PieChartView(
                            title: "Count By Lock Status",
                            slices: [
                                PieSlice(
                                    label: "Locked",
                                    value: statistics.markedCount,
                                    color: "#E24A42".color,
                                    extraColor: ["#E3C180".color]
                                ),
                                PieSlice(
                                    label: "Unlocked",
                                    value: statistics.unmarkedCount,
                                    color: "#FDF5E6".color,
                                    extraColor: ["FDF6EE".color]
                                ),
                            ],
                            radius: 80
                        )
                        .frame(width: 350, height: 250)
                        .padding()
                    }
                }
            }
        }
        .onAppear {
            Task {
                statistics = await Storage.countFish()
            }
        }
    }
    
}

