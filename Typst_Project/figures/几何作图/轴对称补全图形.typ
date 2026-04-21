// ============================================================
// 补充完整图形
// ============================================================

#import "@preview/cetz:0.4.2"

#let render() = {
  v(1em)
  
  align(center)[
    #cetz.canvas(length: 0.6cm, {
      import cetz.draw: *
      
      // 1. 样式参数
      let grid-color = rgb("#4FC3F7") // 青蓝色底图网格色
      let grid-stroke = 0.8pt + grid-color
      let grid-dash = (paint: grid-color, thickness: 0.8pt, dash: (3pt, 2.5pt))
      
      let fill-color = rgb("#C8E8F5") // 淡蓝色涂装（原图色块）
      let ans-fill = rgb("#E1F5FE")   // 学生补充部分的稍微不同区分色或者同色（选用同构浅一点的色以作区分）
      let ans-stroke = 1.8pt + luma(60) // 补充画出的答案边框（深灰/近黑粗线）
      
      // 基座尺寸：经读图为 6列 x 4行，共计24格
      let cols = 6
      let rows = 4
      let w = 1.0
      
      // 2. 为了显示出“补充”，先涂满这 8 个连续框内新画出的 6 个块
      // 目标是画一个 4x2 = 8格的矩形 (x从1到5, y从1到3)
      rect((1 * w, 1 * w), (5 * w, 3 * w), fill: ans-fill, stroke: none)
      
      // 3. 压上题目中已知的原始2块淡区（保留原始特征）
      // 靠左上的淡蓝块 (x从2到3, y从2到3)
      rect((2 * w, 2 * w), (3 * w, 3 * w), fill: fill-color, stroke: none)
      // 靠右下的淡蓝块 (x从3到4, y从1到2)
      rect((3 * w, 1 * w), (4 * w, 2 * w), fill: fill-color, stroke: none)
      
      // 4. 构建全部全局青蓝色网格
      // 纵向内部分割虚线
      for i in range(1, cols) {
        line((i * w, 0), (i * w, rows * w), stroke: grid-dash)
      }
      // 横向内部分割虚线
      for j in range(1, rows) {
        line((0, j * w), (cols * w, j * w), stroke: grid-dash)
      }
      // 外部实线轮廓锁边
      rect((0, 0), (cols * w, rows * w), stroke: grid-stroke)
      
      // 5. 定型绘制总答案的外围边框（圈占 8 格）
      rect((1 * w, 1 * w), (5 * w, 3 * w), stroke: ans-stroke)
    })
  ]

  v(1.5em)

  // 绘图原理与步骤
  block(
    width: 100%,
    inset: (x: 1em, y: 0.8em),
    stroke: (left: 2.5pt + luma(140)),
    fill: luma(248),
    radius: 2pt,
  )[
    #text(weight: "bold", fill: luma(80), size: 11pt)[绘图原理与涂色组合步骤]
    #v(0.4em)
    
    - *原图像素推算*：题干中所指的“原图”为完整的 $6 times 4 = 24$ 格点阵基座。按照比例要求，涂色部分必须占到总容积的 $2/6$，即 $24 times 2/6 = 8$ 个网格。
    - *已知缺口补充*：原卷中已绘制了 $2$ 个孤块，所以只需补充描绘出剩余的 $6$ 块，使组合后的连贯总数正好等于 $8$ 块。
    - *方案覆盖构造*：原始的两个色块处于斜跨身位，横亘于 $x in [2, 4]$ 和 $y in [1, 3]$。为此我选用了一种长宽为 $4 times 2$（容积 $8$）、完美涵盖两者的轴对称大矩形：即左沿拓展至 $x=1$、右沿延至 $x=5$；起止列行坐标划定在 `(1, 1)` 发射到 `(5, 3)` 处。
    - *答案视觉隔离*：作图中特意利用深邃的 `ans-stroke` 为外壳拉注了这层 $8$ 格轮廓，且在衬底上使用了稍浅一度底色进行那新添 $6$ 格的灌浆填实，以便突出保留题面原始“芯”的视觉辨识效果。
  ]
}
