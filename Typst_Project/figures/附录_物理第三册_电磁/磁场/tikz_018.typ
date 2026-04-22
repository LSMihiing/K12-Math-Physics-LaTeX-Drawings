// 来源：高中物理甲种本·第三册（电磁·光学·近代物理）
// 章节：磁场 / 回旋加速器
// 原始文件：1.tex，行 954-973
// 类型：tikz   >=latex   scale=0.5
// 描述：回旋加速器侧视图（甲）— 电场加速 + 虚线半圆轨迹
#import "@preview/cetz:0.4.2"

#let render() = {
  cetz.canvas(length: 0.5cm, {
    import cetz.draw: *

    // --- 极板线 A-A' ---
    // 原始: \draw (0,0)node[left]{$A$}--(9,0)node[right]{$A$}
    line((0, 0), (9, 0), stroke: 0.4pt + black)
    content((-0.5, 0), text(size: 9pt)[$A$])
    content((9.5, 0), text(size: 9pt)[$A$])
    // 原始: \draw (0,2)node[left]{$A'$}--(9,2)node[right]{$A'$}
    line((0, 2), (9, 2), stroke: 0.4pt + black)
    content((-0.5, 2), text(size: 9pt)[$A'$])
    content((9.5, 2), text(size: 9pt)[$A'$])

    // --- 电场箭头 ---
    // 原始: \foreach \x in {1,...,8} { \draw[->](\x,0)--(\x,2); }
    for x in range(1, 9) {
      line((float(x), 0), (float(x), 2), stroke: 0.4pt + black,
        mark: (end: "stealth", fill: black))
    }
    // 正负号
    for x in range(1, 9) {
      content((float(x), 2.5), text(size: 9pt)[$-$])
      content((float(x), -0.5), text(size: 9pt)[$+$])
    }

    // --- 虚线半圆轨迹 ---
    // 原始: \draw[dashed](3.5,0) arc (180:360:1)
    // 圆心在(4.5,0)，从(3.5,0)到(5.5,0)
    arc((4.5, 0), start: 180deg, stop: 360deg, radius: 1,
      anchor: "origin",
      stroke: (paint: black, thickness: 0.4pt, dash: "dashed"))

    // --- 粒子 + 圆圈 ---
    // 原始: \draw (5.5,.3) circle (.25) node{\tiny +}
    circle((5.5, 0.3), radius: 0.25, stroke: 0.4pt + black)
    content((5.5, 0.3), text(size: 7pt)[$+$])

    // --- v1 箭头 ---
    line((5.5, 0.55), (5.5, 2.75), stroke: 0.4pt + black,
      mark: (end: "stealth", fill: black))
    content((5.5, 3.0), text(size: 9pt)[$v_1$])

    // --- 标签 ---
    content((3.3, -0.5), text(size: 9pt)[$A_0$])
    content((5.7, -0.5), text(size: 9pt)[$A_1$])
    content((4.5, -2), text(size: 9pt)[甲])
  })
}
