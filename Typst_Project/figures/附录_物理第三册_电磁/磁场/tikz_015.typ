// 来源：高中物理甲种本·第三册（电磁·光学·近代物理）
// 章节：磁场 / 带电粒子在磁场中的运动
// 原始文件：1.tex，行 754-765
// 类型：tikz   >=stealth   scale=1
// 描述：带电粒子在×磁场中做圆周运动（圆形轨迹+v和f矢量）
#import "@preview/cetz:0.4.2"

#let render() = {
  cetz.canvas(length: 1cm, {
    import cetz.draw: *

    // --- ×符号阵列 6×5 ---
    for x in range(1, 7) {
      for y in range(1, 6) {
        content((float(x), float(y)), text(size: 10pt)[$times$])
      }
    }

    // --- 圆形轨迹 ---
    // 原始: \draw (3.5,3) circle (1.8)
    circle((3.5, 3), radius: 1.8, stroke: 0.4pt + black)

    // --- 速度 v 箭头（从圆顶向左） ---
    // 原始: \draw[->, very thick](3.5,4.8)node[above]{$+q$}--(2.5,4.8)node[left]{$v$}
    line((3.5, 4.8), (2.5, 4.8), stroke: 1.2pt + black,
      mark: (end: "stealth", fill: black))
    content((3.5, 5.1), text(size: 9pt)[$+q$])
    content((2.2, 4.8), text(size: 9pt)[$v$])

    // --- 洛伦兹力 f 箭头（从圆顶向下指向圆心） ---
    // 原始: \draw[->, very thick](3.5,4.8)--(3.5,3.8)node[below]{$f$}
    line((3.5, 4.8), (3.5, 3.8), stroke: 1.2pt + black,
      mark: (end: "stealth", fill: black))
    content((3.5, 3.55), text(size: 9pt)[$f$])

    // --- 半径线（从圆心向 140° 方向） ---
    // 原始: \draw[->](3.5,3)--+(140:1.8)
    let rx = 3.5 + 1.8 * calc.cos(140deg)
    let ry = 3 + 1.8 * calc.sin(140deg)
    line((3.5, 3), (rx, ry), stroke: 0.4pt + black,
      mark: (end: "stealth", fill: black))
  })
}
