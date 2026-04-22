// 来源：高中物理甲种本·第三册（电磁·光学·近代物理）
// 章节：磁场 / 磁场对运动电荷的作用力
// 原始文件：1.tex，行 695-704
// 类型：tikz   >=stealth   scale=0.5
// 描述：洛伦兹力甲 — ×磁场中+q水平运动
#import "@preview/cetz:0.4.2"

#let render() = {
  cetz.canvas(length: 0.5cm, {
    import cetz.draw: *

    // --- ×符号阵列 4×4 ---
    for x in range(1, 5) {
      for y in range(1, 5) {
        content((float(x), float(y)), text(size: 10pt)[$times$])
      }
    }

    // --- +q 和 v 箭头 ---
    // 原始: \draw[->](-.5,2.5)node[left]{$+q$}--node[below]{$v$}(0.5,2.5)
    line((-0.5, 2.5), (0.5, 2.5), stroke: 0.4pt + black,
      mark: (end: "stealth", fill: black))
    content((-1.0, 2.5), text(size: 9pt)[$+q$])
    content((0, 2.1), text(size: 9pt)[$v$])

    // +q 白色圆
    // 原始: \draw (-.5,2.5)[fill=white] circle (3pt)
    circle((-0.5, 2.5), radius: 0.12, fill: white, stroke: 0.4pt + black)

    // 甲 标签
    content((2.5, -1), text(size: 9pt)[甲])
  })
}
