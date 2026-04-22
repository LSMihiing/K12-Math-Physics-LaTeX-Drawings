// 来源：高中物理甲种本·第三册（电磁·光学·近代物理）
// 章节：磁场 / 荷质比的测定~~质谱仪
// 原始文件：1.tex，行 878-896
// 类型：tikz   >=stealth   scale=1
// 描述：质谱仪（D形电极 + ×磁场 + 电场加速缝隙）
#import "@preview/cetz:0.4.2"

#let render() = {
  cetz.canvas(length: 1cm, {
    import cetz.draw: *

    // --- ×符号阵列 6×4 ---
    for x in range(1, 7) {
      for y in range(1, 5) {
        content((float(x), float(y)), text(size: 10pt)[$times$])
      }
    }

    // --- D形电极（两条竖直 ultra thick 线） ---
    // 原始: \draw[ultra thick](2.5,0.5)--(2.5,4.5)
    line((2.5, 0.5), (2.5, 4.5), stroke: 1.6pt + black)
    // 原始: \draw[ultra thick](4.5,0.5)--(4.5,4.5)
    line((4.5, 0.5), (4.5, 4.5), stroke: 1.6pt + black)

    // --- 电极连接线 ---
    // 原始: \draw[ultra thick](2.5,2.5)--(0.5,2.5)node[left]{$-$}
    line((2.5, 2.5), (0.5, 2.5), stroke: 1.6pt + black)
    content((0.2, 2.5), text(size: 11pt)[$-$])
    // 原始: \draw[ultra thick](4.5,2.5)--(6.5,2.5)node[right]{$+$}
    line((4.5, 2.5), (6.5, 2.5), stroke: 1.6pt + black)
    content((6.8, 2.5), text(size: 11pt)[$+$])

    // --- 顶部缝隙 S2 ---
    // 原始: \draw[ultra thick](2,4.75)--(3.4,4.75); \draw[ultra thick](3.6,4.75)--(5,4.75)
    line((2, 4.75), (3.4, 4.75), stroke: 1.6pt + black)
    line((3.6, 4.75), (5, 4.75), stroke: 1.6pt + black)

    // --- 底部缝隙 S3 ---
    line((2, 0.25), (3.4, 0.25), stroke: 1.6pt + black)
    line((3.6, 0.25), (5, 0.25), stroke: 1.6pt + black)

    // --- 粒子入射箭头 ---
    // 原始: \draw[->](3.5,5.5)--(3.5,4.5)node[below]{$v$}
    line((3.5, 5.5), (3.5, 4.5), stroke: 0.4pt + black,
      mark: (end: "stealth", fill: black))
    content((3.5, 4.3), text(size: 9pt)[$v$])

    // --- 标签 ---
    content((3.5, 5), text(size: 9pt)[$S_2$])
    content((3.5, 0), text(size: 9pt)[$S_3$])
    content((2, 3.5), text(size: 9pt)[$D_1$])
    content((5, 3.5), text(size: 9pt)[$D_2$])
  })
}
