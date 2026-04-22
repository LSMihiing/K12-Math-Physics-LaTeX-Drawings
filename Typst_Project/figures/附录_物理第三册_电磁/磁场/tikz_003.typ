// 来源：高中物理甲种本·第三册（电磁·光学·近代物理）
// 章节：磁场 / 磁通量
// 原始文件：1.tex，行 282-295
// 类型：tikz   >=latex   无缩放
// 描述：磁通量（×符号阵列 + 矩形线圈 + 旋转轴虚线）
#import "@preview/cetz:0.4.2"

#let render() = {
  cetz.canvas(length: 1cm, {
    import cetz.draw: *

    // --- ×符号阵列 6×3 ---
    // 原始: \foreach \x in{1,2,...,6} \foreach \y in{1,2,3} { \node at(\x,\y){$\times$}; }
    for x in range(1, 7) {
      for y in range(1, 4) {
        content((float(x), float(y)), text(size: 10pt)[$times$])
      }
    }

    // --- 矩形线圈 ---
    // 原始: \draw[thick](2.5,1.5) rectangle (4.5,2.5)
    rect((2.5, 1.5), (4.5, 2.5), stroke: 0.8pt + black)

    // --- 旋转轴虚线 ---
    // 原始: \draw[dashed](3.5,0.2)node[below]{$O'$}--(3.5,3.8)node[above]{$O$}
    line((3.5, 0.2), (3.5, 3.8),
      stroke: (paint: black, thickness: 0.4pt, dash: "dashed"))
    content((3.5, 0), text(size: 9pt)[$O'$])
    content((3.5, 4), text(size: 9pt)[$O$])

    // --- 角标签 ---
    // 原始: \node at (2.3,2.7){$a$} etc.
    content((2.3, 2.7), text(size: 9pt)[$a$])
    content((2.3, 1.3), text(size: 9pt)[$c$])
    content((4.7, 2.7), text(size: 9pt)[$b$])
    content((4.7, 1.3), text(size: 9pt)[$d$])

    // --- 旋转方向弧箭头 ---
    // 原始: \draw[->](3.5+.25, 3.5) arc[start angle=10, end angle=360, x radius=.25, y radius=.125]
    arc((3.75, 3.5), start: 10deg, stop: 360deg,
      radius: (0.25, 0.125), anchor: "origin",
      stroke: 0.4pt + black,
      mark: (end: "stealth", fill: black))
  })
}
