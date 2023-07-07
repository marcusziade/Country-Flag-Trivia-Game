import SwiftUI

struct Triangle: Shape {

    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        return path
    }
}

struct ParentalGateView: View {

    var onClose: (() -> Void)?
    var onCancel: (() -> Void)?

    var body: some View {
        VStack(alignment: .center, spacing: 60) {
            HStack {
                Button {
                    HapticEngine.rigid.impactOccurred()
                    onCancel?()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30)
                        .foregroundColor(.red)
                }

                Spacer()
            }
            .padding([.leading, .top], 24)

            Text("Ask your parents")
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundColor(.blue)

            Spacer()

            HStack(spacing: 20) {
                Button {
                    HapticEngine.notification.notificationOccurred(.error)
                } label: {
                    Triangle()
                        .foregroundColor(.green)
                        .frame(width: size, height: size)
                }

                Button {
                    HapticEngine.notification.notificationOccurred(.error)
                } label: {
                    Rectangle()
                        .foregroundColor(.blue)
                        .frame(width: size, height: size)
                }

                Button {
                    HapticEngine.notification.notificationOccurred(.success)
                    onClose?()
                } label: {
                    Circle()
                        .foregroundColor(.yellow)
                        .frame(width: size, height: size)
                }
            }
            .shadow(radius: 10)

            Text("Tap the circle.")
                .font(.headline)
                .foregroundColor(.orange)

            Spacer()
        }
    }

    // MARK: - Private

    private let size: CGFloat = 90
}

struct ParentalGateView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ParentalGateView()
                .preferredColorScheme(.dark)
            ParentalGateView()
                .preferredColorScheme(.light)
        }
    }
}
