import SwiftUI


struct SurveyView: View {
    @Binding var survey: Survey
    @State private var currentStep = 1
    private let totalSteps = 5
    
    var body: some View {
        VStack(spacing: 20) {
            // 進捗バー
            ProgressView(value: Double(currentStep), total: Double(totalSteps))
                .padding()
            
            // 質問カードの切り替え
            ZStack {
                switch currentStep {
                case 1:
                    questionCard(title: "場所の好み", options: ["屋内のみ", "屋外も可"], selection: $survey.location)
                case 2:
                    questionCard(title: "使用可能な器具", options: ["なし（自重）", "最小限（ダンベル等）"], selection: $survey.equipment)
                case 3:
                    questionCard(title: "筋トレ経験", options: ["初心者（知見なし）", "経験あり"], selection: $survey.experience)
                case 4:
                    questionCard(title: "目標強度", options: ["リフレッシュ", "引き締め", "筋肉増強"], selection: $survey.goal)
                case 5:
                    commitmentCard()
                default:
                    EmptyView()
                }
            }
            .id(currentStep)
            .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
            
            Spacer()
            
            // 次へ / 完了 ボタン
            Button(action: {
                if currentStep < 5 {
                    withAnimation { currentStep += 1 }
                } else {
                    print("アンケート完了！: \(survey)")
                    // ここで保存処理 (未実装) 
                }
            }) {
                Text(currentStep < 5 ? "次へ" : "完了")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isStepValid ? Color.blue : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .disabled(!isStepValid)
            .padding()
        }
    }
    
    // 1〜4問目
    func questionCard(title: String, options: [String], selection: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(title)
                .font(.title2)
                .bold()
            ForEach(options, id: \.self) { option in
                Button(action: { selection.wrappedValue = option }) {
                    HStack {
                        Text(option)
                        Spacer()
                        if selection.wrappedValue == option { Image(systemName: "checkmark.circle.fill") }
                    }
                    .padding()
                    .background(selection.wrappedValue == option ? Color.blue.opacity(0.1) : Color.secondary.opacity(0.1))
                    .cornerRadius(10)
                }
                .foregroundColor(.primary)
            }
        }
        .padding()
    }
    
    // 5問目
    func commitmentCard() -> some View {
        VStack(alignment: .leading, spacing: 30) {
            Text("継続の約束")
                .font(.title2)
                .bold()
            Text("週に何回トレーニングしますか？")
                .foregroundColor(.secondary)

            Text("週 \(Int(survey.commitmentDays)) 回")
                .font(.system(size: 40, weight: .bold, design: .rounded))
                .foregroundColor(.blue)
                .frame(maxWidth: .infinity, alignment: .center)
            
            Slider(value: Binding(
                get: { Double(survey.commitmentDays) },
                set: { survey.commitmentDays = Int($0) }
            ), in: 1...7, step: 1)
            .accentColor(.blue)
            .padding(.horizontal)
        }
        .padding()
    }
    
    // バリデーション
    var isStepValid: Bool {
        switch currentStep {
        case 1: return !survey.location.isEmpty
        case 2: return !survey.equipment.isEmpty
        case 3: return !survey.experience.isEmpty
        case 4: return !survey.goal.isEmpty
        case 5: return survey.commitmentDays > 0
        default: return false
        }
    }
}

/* To preview on ContentView.swift *******

struct ContentView: View {
    @State private var survey = Survey()
    
    var body: some View {
        SurveyView(survey: $survey)
    }
}

#Preview{
    ContentView()
}
****************************************/
