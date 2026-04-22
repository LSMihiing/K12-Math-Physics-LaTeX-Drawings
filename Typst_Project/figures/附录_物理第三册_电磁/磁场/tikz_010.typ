// 来源：高中物理甲种本·第三册（电磁·光学·近代物理）
// 章节：磁场 / 磁场对电流的作用力
// 原始文件：1.tex，行 497-505
// 类型：tikz   >=latex   无缩放
// 描述：竖直导线旁矩形线圈（带电流方向箭头标注 abcd）
#import "@preview/cetz:0.4.2"

#let render() = {
  cetz.canvas(length: 1cm, {
    import cetz.draw: *

    // --- 竖直导线 ---
    // 原始: \draw (0,.5)--(0,4.5)
    line((0, 0.5), (0, 4.5), stroke: 0.4pt + black)

    // --- 电流方向 ---
    // 原始: \draw[->](-.5,2)--(-.5,3)node[above]{$I$}
    line((-0.5, 2), (-0.5, 3), stroke: 0.4pt + black,
      mark: (end: "stealth", fill: black))
    content((-0.5, 3.25), text(size: 9pt)[$I$])

    // --- 矩形线圈 thick ---
    // 原始: \draw[thick](1-.3,1) rectangle (2+.3,4) → (0.7,1) to (2.3,4)
    rect((0.7, 1), (2.3, 4), stroke: 0.8pt + black)

    // --- 边上的电流方向箭头 ---
    // a: 左边向上 原始: \draw[->](0.7,1.5)--(0.7,2.5)node[left]{$a$}
    line((0.7, 1.5), (0.7, 2.5), stroke: 0.4pt + black,
      mark: (end: "stealth", fill: black))
    content((0.45, 2.5), text(size: 9pt)[$a$])

    // c: 右边向下 原始: \draw[->](2.3,3)--(2.3,2.5)node[right]{$c$}
    line((2.3, 3), (2.3, 2.5), stroke: 0.4pt + black,
      mark: (end: "stealth", fill: black))
    content((2.55, 2.5), text(size: 9pt)[$c$])

    // b: 上边向右 原始: \draw[->](0.7,4)--(1.5,4)node[above]{$b$}
    line((0.7, 4), (1.5, 4), stroke: 0.4pt + black,
      mark: (end: "stealth", fill: black))
    content((1.5, 4.25), text(size: 9pt)[$b$])

    // d: 下边向左 原始: \draw[->](2.3,1)--(1.5,1)node[below]{$d$}
    line((2.3, 1), (1.5, 1), stroke: 0.4pt + black,
      mark: (end: "stealth", fill: black))
    content((1.5, 0.75), text(size: 9pt)[$d$])
  })
}
