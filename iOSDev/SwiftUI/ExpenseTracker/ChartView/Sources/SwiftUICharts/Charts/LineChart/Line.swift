import SwiftUI

/// A single line of data, a view in a `LineChart`
public struct Line: View {
    @EnvironmentObject var chartValue: ChartValue
    @State private var frame: CGRect = .zero
    @ObservedObject var chartData: ChartData

    var style: ChartStyle

    @State private var showIndicator: Bool = false
    @State private var touchLocation: CGPoint = .zero
    @State private var showFull: Bool = false
    @State private var showBackground: Bool = true
    var curvedLines: Bool = true

	/// Step for plotting through data
	/// - Returns: X and Y delta between each data point based on data and view's frame
    var step: CGPoint {
        return CGPoint.getStep(frame: frame, data: chartData.points)
    }

	/// Path of line graph
	/// - Returns: A path for stroking representing the data, either curved or jagged.
    var path: Path {
        let points = chartData.points

        if curvedLines {
            return Path.quadCurvedPathWithPoints(points: points,
                                                 step: step,
                                                 globalOffset: nil)
        }

        return Path.linePathWithPoints(points: points, step: step)
    }
    
	/// Path of linegraph, but also closed at the bottom side
	/// - Returns: A path for filling representing the data, either curved or jagged
    var closedPath: Path {
        let points = chartData.points

        if curvedLines {
            return Path.quadClosedCurvedPathWithPoints(points: points,
                                            step: step,
                                            globalOffset: nil)
        }

        return Path.closedLinePathWithPoints(points: points, step: step)
    }

    // see https://stackoverflow.com/a/62370919
    // This lets geometry be recalculated when device rotates. However it doesn't cover issue of app changing
    // from full screen to split view. Not possible in SwiftUI? Feedback submitted to apple FB8451194.
    let orientationChanged = NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)
        .makeConnectable()
        .autoconnect()
    
	/// The content and behavior of the `Line`.
	/// Draw the background if showing the full line (?) and the `showBackground` option is set. Above that draw the line, and then the data indicator if the graph is currently being touched.
	/// On appear, set the frame so that the data graph metrics can be calculated. On a drag (touch) gesture, highlight the closest touched data point.
	/// TODO: explain rotation
    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                if self.showFull && self.showBackground {
                    self.getBackgroundPathView()
                }
                self.getLinePathView()
                if self.showIndicator {
                    IndicatorPoint()
                        .position(self.getClosestPointOnPath(touchLocation: self.touchLocation))
                        .rotationEffect(.degrees(180), anchor: .center)
                        .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                }
            }
            .onAppear {
                self.frame = geometry.frame(in: .local)

            }
			.onReceive(orientationChanged) { _ in
				// When we receive notification here, the geometry is still the old value
				// so delay evaluation to get the new frame!
				DispatchQueue.main.async {
					self.frame = geometry.frame(in: .local)	// recalculate layout with new frame
				}
			}
			
            .gesture(DragGesture()
                .onChanged({ value in
                    self.touchLocation = value.location
                    self.showIndicator = true
                    self.getClosestDataPoint(point: self.getClosestPointOnPath(touchLocation: value.location))
                    self.chartValue.interactionInProgress = true
                })
                .onEnded({ value in
                    self.touchLocation = .zero
                    self.showIndicator = false
                    self.chartValue.interactionInProgress = false
                })
            )
        }
    }
}

// MARK: - Private functions

extension Line {

	/// Calculate point closest to where the user touched
	/// - Parameter touchLocation: location in view where touched
	/// - Returns: `CGPoint` of data point on chart
    private func getClosestPointOnPath(touchLocation: CGPoint) -> CGPoint {
        let closest = self.path.point(to: touchLocation.x)
        return closest
    }

	/// Figure out where closest touch point was
	/// - Parameter point: location of data point on graph, near touch location
    private func getClosestDataPoint(point: CGPoint) {
        let index = Int(round((point.x)/step.x))
        if (index >= 0 && index < self.chartData.data.count){
            self.chartValue.currentValue = self.chartData.points[index]
        }
    }

	/// Get the view representing the filled in background below the chart, filled with the foreground color's gradient
	///
	/// TODO: explain rotations
	/// - Returns: SwiftUI `View`
    private func getBackgroundPathView() -> some View {
        self.closedPath
            .fill(LinearGradient(gradient: Gradient(colors: [
                                                        style.foregroundColor.first?.startColor ?? .white,
                                                        style.foregroundColor.first?.endColor ?? .white,
                                                        .clear]),
                                 startPoint: .bottom,
                                 endPoint: .top))
            .rotationEffect(.degrees(180), anchor: .center)
            .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
            .opacity(0.2)
            .transition(.opacity)
            .animation(.easeIn(duration: 1.6))
    }

	/// Get the view representing the line stroked in the `foregroundColor`
	///
	/// TODO: Explain how `showFull` works
	/// TODO: explain rotations
	/// - Returns: SwiftUI `View`
    private func getLinePathView() -> some View {
        self.path
            .trim(from: 0, to: self.showFull ? 1:0)
            .stroke(LinearGradient(gradient: style.foregroundColor.first?.gradient ?? ColorGradient.orangeBright.gradient,
                                   startPoint: .leading,
                                   endPoint: .trailing),
                    style: StrokeStyle(lineWidth: 3, lineJoin: .round))
            .rotationEffect(.degrees(180), anchor: .center)
            .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
            .animation(Animation.easeOut(duration: 1.2))
            .onAppear {
                self.showFull = true
            }
            .onDisappear {
                self.showFull = false
            }
            .drawingGroup()
    }
}

struct Line_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Line(chartData:  ChartData([8, 23, 32, 7, 23, 43]), style: blackLineStyle)
            Line(chartData:  ChartData([8, 23, 32, 7, 23, 43]), style: redLineStyle)
        }
    }
}

/// Predefined style, black over white, for preview
private let blackLineStyle = ChartStyle(backgroundColor: ColorGradient(.white), foregroundColor: ColorGradient(.black))

/// Predefined stylem red over white, for preview
private let redLineStyle = ChartStyle(backgroundColor: .whiteBlack, foregroundColor: ColorGradient(.red))
