// 来源：高中物理甲种本·第三册（电磁·光学·近代物理）
// 章节：磁场 / 回旋加速器
// 原始文件：1.tex，行 912-946
// 类型：tikz   >=stealth   scale=1.3
// 描述：回旋加速器俯视图 — 交替半圆轨迹 + 加速间隙 + ×磁场
#import "@preview/cetz:0.4.2"

#let render() = {
  cetz.canvas(length: 1.3cm, {
    import cetz.draw: *

    // --- ×符号阵列 7×5 ---
    for x in range(1, 8) {
      for y in range(1, 6) {
        content((float(x), float(y)), text(size: 10pt)[$times$])
      }
    }

    // --- 间隙双线 ---
    // 原始: \draw (0,3.2)--(8,3.2); \draw (0,3.4)--(8,3.4)
    line((0, 3.2), (8, 3.2), stroke: 0.4pt + black)
    line((0, 3.4), (8, 3.4), stroke: 0.4pt + black)

    // --- 半圆轨迹序列（very thick） ---
    // 第1半圆：从A0向下，半径0.5
    // 原始: (3.5,3.2) arc(180:360:.5) — 圆心在(4,3.2)
    arc((4, 3.2), start: 180deg, stop: 360deg, radius: 0.5,
      anchor: "origin", stroke: 1.2pt + black)
    // v0 箭头
    line((3.5, 3.2), (3.5, 2.7), stroke: 0.8pt + black,
      mark: (end: "stealth", fill: black))
    content((3.5, 2.45), text(size: 8pt)[$v_0$])

    // 连接线到上方：(4.5,3.2)→(4.5,3.4)
    line((4.5, 3.2), (4.5, 3.4), stroke: 1.2pt + black)

    // 第2半圆：从A'1向上，半径1，圆心在(3.5,3.4)
    arc((3.5, 3.4), start: 0deg, stop: 180deg, radius: 1,
      anchor: "origin", stroke: 1.2pt + black)
    // v1 箭头
    line((4.5, 3.4), (4.5, 4.2), stroke: 0.8pt + black,
      mark: (end: "stealth", fill: black))
    content((4.5, 4.45), text(size: 8pt)[$v_1$])

    // 连接到下方：(2.5,3.4)→(2.5,3.2)
    line((2.5, 3.4), (2.5, 3.2), stroke: 1.2pt + black)

    // 第3半圆：从A2向下，半径1.5
    arc((4, 3.2), start: 180deg, stop: 360deg, radius: 1.5,
      anchor: "origin", stroke: 1.2pt + black)
    // v2 箭头
    line((2.5, 3.2), (2.5, 2.2), stroke: 0.8pt + black,
      mark: (end: "stealth", fill: black))
    content((2.5, 1.95), text(size: 8pt)[$v_2$])

    // 连接到上方：(5.5,3.2)→(5.5,3.4)
    line((5.5, 3.2), (5.5, 3.4), stroke: 1.2pt + black)

    // 第4半圆：从A'3向上，半径2
    arc((3.5, 3.4), start: 0deg, stop: 180deg, radius: 2,
      anchor: "origin", stroke: 1.2pt + black)
    // v3 箭头
    line((5.5, 3.4), (5.5, 4.6), stroke: 0.8pt + black,
      mark: (end: "stealth", fill: black))
    content((5.5, 4.85), text(size: 8pt)[$v_3$])

    // 连接到下方：(1.5,3.4)→(1.5,3.2)
    line((1.5, 3.4), (1.5, 3.2), stroke: 1.2pt + black)

    // 第5半圆：从A4向下，半径2.5
    arc((4, 3.2), start: 180deg, stop: 360deg, radius: 2.5,
      anchor: "origin", stroke: 1.2pt + black)
    // v4 箭头
    line((1.5, 3.2), (1.5, 1.7), stroke: 0.8pt + black,
      mark: (end: "stealth", fill: black))
    content((1.5, 1.45), text(size: 8pt)[$v_4$])

    // 连接到上方：(6.5,3.2)→(6.5,3.4)
    line((6.5, 3.2), (6.5, 3.4), stroke: 1.2pt + black)
    // v5 箭头
    line((6.5, 3.4), (6.5, 5.2), stroke: 0.8pt + black,
      mark: (end: "stealth", fill: black))
    content((6.5, 5.45), text(size: 8pt)[$v_5$])

    // --- 标签（下方 A 系列） ---
    content((3.3, 3), text(size: 8pt)[$A_0$])
    content((4.7, 3), text(size: 8pt)[$A_1$])
    content((2.3, 3), text(size: 8pt)[$A_2$])
    content((5.7, 3), text(size: 8pt)[$A_3$])
    content((1.3, 3), text(size: 8pt)[$A_4$])
    content((6.7, 3), text(size: 8pt)[$A_5$])

    // --- 标签（上方 A' 系列） ---
    content((4.7, 3.6), text(size: 8pt)[$A'_1$])
    content((2.3, 3.6), text(size: 8pt)[$A'_2$])
    content((5.7, 3.6), text(size: 8pt)[$A'_3$])
    content((1.3, 3.6), text(size: 8pt)[$A'_4$])
    content((6.7, 3.6), text(size: 8pt)[$A'_5$])
  })
}
