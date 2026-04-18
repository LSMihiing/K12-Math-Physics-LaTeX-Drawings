#import "@preview/cetz:0.4.2"

#let render() = {
  v(1em)

  align(center)[
    #cetz.canvas(length: 0.5cm, {
      import cetz.draw: *

      // 1. 样式参数设置
      let grid-color = rgb("#4FC3F7") // 从原题干提取的浅青蓝色
      let grid-stroke = 0.6pt + grid-color
      let grid-dash = (paint: grid-color, thickness: 0.6pt, dash: (2.5pt, 2pt))
      let rect-stroke = 1.2pt + luma(30) // 长方形画线笔触用加粗灰黑

      let cols = 16 // 题干横向有 16 个格
      let rows = 6  // 题干纵向有 6 个格
      let w = 1.0

      // 2. 绘制基础背景网格
      // 内部垂直虚线
      for i in range(1, cols) {
        line((i * w, 0), (i * w, rows * w), stroke: grid-dash)
      }
      // 内部水平虚线
      for j in range(1, rows) {
        line((0, j * w), (cols * w, j * w), stroke: grid-dash)
      }
      // 网格外围全包围实线边框
      rect((0, 0), (cols * w, rows * w), stroke: grid-stroke)

      // 3. 画要求的长方形
      // (1) 题目要求长 1.4m = 14dm = 14格，宽 0.4m = 4dm = 4格
      // (2) 为了呈现标准答案般的美观居中设定（左右各留 1 格，上下各留 1 格）
      let start-x = 1 * w
      let start-y = 1 * w
      let end-x = 15 * w
      let end-y = 5 * w
      rect((start-x, start-y), (end-x, end-y), stroke: rect-stroke)

      // 4. 标注物理界线尺寸
      // 底部文字居中（X 取中点，Y 略微下移）
      content(((start-x + end-x) / 2, start-y - 0.7), [#text(size: 11pt, font: "KaiTi")[1.4米]])
      // 右侧文字垂直居中（X 略微右移，Y 取中点）
      content((end-x + 1.2, (start-y + end-y) / 2), [#text(size: 11pt, font: "KaiTi")[0.4米]])
    })
  ]

  v(1.5em)

  // 解析模块
  block(
    width: 100%,
    inset: (x: 1em, y: 0.8em),
    stroke: (left: 2.5pt + luma(140)),
    fill: luma(248),
    radius: 2pt,
  )[
    #text(weight: "bold", fill: luma(80), size: 11pt)[绘图原理与步骤]
    #v(0.4em)
    
    - *单位尺寸换算*：由于长方形背景图“每个小方格都表示边长 $1$ 分米”，而题目给定的绘图对象是长 $1.4$ 米、宽 $0.4$ 米。两者存在单位落差，故绘图前首先经过换算：$1.4$ 米 $= 14$ 分米，$0.4$ 米 $= 4$ 分米。
    - *逻辑映射*：投射在作图画板中就是：所画长方形的“长”须精确跨越 $14$ 个格子，“宽”须精确跨越 $4$ 个格子。
    - *底图重塑绘制*：针对题干网格（$16$ 列 $times$ $6$ 行），底层使用自定义致密虚线样式 `grid-dash` 采用循环描摹的方式还原了青蓝色的基底坐标系统。
    - *定位与裁割*：为追求视觉规范与参考答案保持一致，采用绝对居中的排版偏置参数。横向余留空间 $(16 - 14) / 2 = 1$ 格，纵向余留空间 $(6 - 4) / 2 = 1$ 格。故而图形从左下角坐标 $(1, 1)$ 起笔，延伸到右上角坐标 $(15, 5)$。
    - *显化与标签*：利用了更高权重的无透明度黑色实线覆盖在目标网格上；最后在图形横纵中心线的向外投影延长处输出 $1.4$ 米和 $0.4$ 米的文本注记。
  ]
}
