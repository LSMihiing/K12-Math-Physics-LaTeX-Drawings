// circuit_009: 法拉第定律 — B场中导体棒速度分解
// LaTeX: 纯矢量图，无电路元件
#import "@preview/cetz:0.4.2"

#let render() = {
  cetz.canvas(length: 0.7cm, {
    import cetz.draw: *
    set-style(stroke: 0.7pt + black)
    // B场箭头（向下）
    for x in (0.5, 2.0, 3.5) {
      line((x, 4), (x, 0.3), mark: (end: "stealth", fill: black))
    }
    content((2.5, 0.1), text(size: 8pt)[$B$])
    // 速度向量 v₁（水平向右）
    line((1.5, 3), (2.5, 3), mark: (end: "stealth", fill: black))
    content((2.7, 3.1), text(size: 7pt)[$v_1$])
    // 速度向量 v₂（垂直向下）
    line((1.5, 3), (1.5, 1.2), mark: (end: "stealth", fill: black))
    content((1.3, 0.9), text(size: 7pt)[$v_2$])
    // 合速度 v（斜向右下）
    line((1.5, 3), (2.5, 1.2), mark: (end: "stealth", fill: black))
    content((2.7, 1.1), text(size: 7pt)[$v$])
    // 起点空心圆
    circle((1.5, 3), radius: 0.06, fill: white, stroke: 0.7pt + black)
    // θ 标注
    content((1.75, 2.5), text(size: 7pt)[$theta$])
  })
}
