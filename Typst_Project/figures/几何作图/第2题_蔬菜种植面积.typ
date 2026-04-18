#import "@preview/cetz:0.4.2"

#let render() = {
  v(1em)

  // 渲染彩色填充满格画板区域
  align(center)[
    #cetz.canvas(length: 0.5cm, {
      import cetz.draw: *

      // 颜色与样式配置
      let grid-color = rgb("#4FC3F7") // 浅青蓝色网格
      let grid-stroke = 0.8pt + grid-color
      // 密集分布的虚线间隔效果
      let grid-dash = (paint: grid-color, thickness: 0.8pt, dash: (2.5pt, 2pt))
      
      // 参考答案实填色值对应
      let color-tomato = rgb("#0078FF")   // 番茄 - 左侧蓝色块
      let color-eggplant = rgb("#00E5FF") // 茄子 - 中间青色块
      let color-cucumber = rgb("#FFEA00") // 黄瓜 - 右侧黄色块

      // 规格定义
      let cell-w = 1.8 // 每格基准宽度，撑大点便于清晰展现
      let cell-h = 4.0 // 网格整体高度
      let cols = 9     // 总等分数 9

      let w = cell-w
      let h = cell-h

      // ========== 涂色分色层 ==========
      // 番茄占据 4/9（前四格 0~4）
      rect((0, 0), (4 * w, h), fill: color-tomato, stroke: none)
      // 茄子占据 2/9（中间两格 4~6）
      rect((4 * w, 0), (6 * w, h), fill: color-eggplant, stroke: none)
      // 黄瓜占据 3/9（后三格 6~9）
      rect((6 * w, 0), (9 * w, h), fill: color-cucumber, stroke: none)

      // ========== 叠加基准框线层 ==========
      // 这是为了保证填实色的同时，学生依然能清晰看见对应的数学等分网格界线
      for i in range(1, cols) {
        line((i * w, 0), (i * w, h), stroke: grid-dash)
      }

      // 叠加最外层边框防止颜色外溢糊边
      rect((0, 0), (cols * w, h), stroke: grid-stroke)
    })
  ]

  v(1.5em)

  // 绘图原理与步骤（排版剥离纯净显示）
  block(
    width: 100%,
    inset: (x: 1em, y: 0.8em),
    stroke: (left: 2.5pt + luma(140)),
    fill: luma(248),
    radius: 2pt,
  )[
    #text(weight: "bold", fill: luma(80), size: 11pt)[绘图原理与步骤]
    #v(0.4em)
    
    - 题目解析：“一块地有九份（基于分母 $9$）”。番茄占据 $4/9$ （对应 $4$ 份），茄子占 $2/9$ （对应 $2$ 份），剩余空白由 $9 - 4 - 2 = 3$ 推断黄瓜占据了 $3$ 份（占 $3/9$）。所以占地面积方面：番茄（$4$份）大于 茄子（$2$份）；黄瓜（$3$份）大于 茄子（$2$份）。
    - 框架构建：利用 CeTZ 的 `rect` 构建出宽 `9 * w`，高 `h` 的外周大矩形方块，网格线均以间距 `w=1.8` 等步切割出 $9$ 条子区块。
    - 填色图层分配：通过无边线 `stroke: none` 的连续接力 `rect` 色块铺填（$0$~$4$蓝色，$4$~$6$青蓝色，$6$~$9$亮黄色）。以实色作为背景铺设在底层。
    - 网格图层置顶：为使填色边界精准而不显粗糙突兀，同时为了映射题干原图中“虚线框标注法”，运用定制步长 `(2.5pt, 2pt)` 的青色密集虚线将网格在顶部再次盖印打印，还原典型的教辅美学风格。
  ]
}
