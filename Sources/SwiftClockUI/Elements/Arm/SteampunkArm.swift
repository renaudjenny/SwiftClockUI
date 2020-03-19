import SwiftUI

struct SteampunkArm: View {
    let type: ArmType

    var body: some View {
        Group {
            if type == .hour {
                SteampunkHourArm()
            } else {
                SteampunkMinuteArm()
            }
        }
    }
}
