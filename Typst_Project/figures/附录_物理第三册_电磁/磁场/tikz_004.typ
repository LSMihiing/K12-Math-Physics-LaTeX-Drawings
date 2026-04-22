// 来源：高中物理甲种本·第三册（电磁·光学·近代物理）
// 章节：磁场 / 直线电流的磁场
// 原始文件：1.tex，行 310-317
// 类型：tikz   >=latex   xscale=0.6, yscale=0.4
// 描述：直线电流穿过矩形板（导线穿板示意）
#import "@preview/cetz:0.4.2"

#let render() = {
  // xscale=0.6, yscale=0.4 → 手动缩放坐标
  let xs = 0.6
  let ys = 0.4
  cetz.canvas(length: 1cm, {
    import cetz.draw: *

    // --- 梯形板 ---
    // 原始: \draw (-2,2)--(2,2)--(2.2,-2)--(-2.2,-2)--(-2,2)
    line((-2*xs, 2*ys), (2*xs, 2*ys), (2.2*xs, -2*ys), (-2.2*xs, -2*ys),
      close: true, stroke: 0.4pt + black)

    // --- 导线（上部，白色遮挡板面） ---
    // 原始: \fill[white](-.1,0) rectangle (.1,5)
    rect((-0.1*xs, 0), (0.1*xs, 5*ys), fill: white, stroke: none)
    // 原始: \draw (-0.1,0)--(-0.1,5); \draw (0.1,0)--(0.1,5)
    line((-0.1*xs, 0), (-0.1*xs, 5*ys), stroke: 0.4pt + black)
    line((0.1*xs, 0), (0.1*xs, 5*ys), stroke: 0.4pt + black)

    // --- 导线（下部） ---
    // 原始: \draw (-0.1,-2)--(-0.1,-3); \draw (0.1,-2)--(0.1,-3)
    line((-0.1*xs, -2*ys), (-0.1*xs, -3*ys), stroke: 0.4pt + black)
    line((0.1*xs, -2*ys), (0.1*xs, -3*ys), stroke: 0.4pt + black)

    // --- 电流方向箭头 ---
    // 原始: \draw[->](-.5,3)--(-.5,4)node[above]{$I$}
    line((-0.5*xs, 3*ys), (-0.5*xs, 4*ys), stroke: 0.4pt + black,
      mark: (end: "stealth", fill: black))
    content((-0.5*xs, 4*ys + 0.2), text(size: 9pt)[$I$])
  })
}
