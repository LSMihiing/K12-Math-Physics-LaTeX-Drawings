// ============================================================
// 根据分数推导图形
// ============================================================

#import "@preview/cetz:0.4.2"

#let render() = {
  v(1em)

  align(center)[
    #cetz.canvas(length: 0.5cm, {
      import cetz.draw: *

      // 1. 样式设定
      let grid-color = luma(120) // 灰色底图网格
      let grid-stroke = 0.5pt + grid-color
      
      let shape-color = rgb("#00AEEF") // 青蓝色答案轮廓
      let shape-stroke = 1.5pt + shape-color

      // 2. 基底网格系统尺寸：经读图计算为 14列 x 4行
      let cols = 14
      let rows = 4
      let w = 1.0

      // 3. 画实线背景网格
      for i in range(0, cols + 1) {
        line((i * w, 0), (i * w, rows * w), stroke: grid-stroke)
      }
      for j in range(0, rows + 1) {
        line((0, j * w), (cols * w, j * w), stroke: grid-stroke)
      }

      // 4. 画三种推导出的青蓝色轮廓
      
      // 第一种答案：2x2 正方形 (列1~列3，行0~行2)
      rect((1 * w, 0 * w), (3 * w, 2 * w), stroke: shape-stroke)

      // 第二种答案：4x1 长方形 (列5~列9，行0~行1)
      rect((5 * w, 0 * w), (9 * w, 1 * w), stroke: shape-stroke)

      // 第三种答案：4个方块呈对角阶梯状 (列9~列13，横向错落排布在四个行上)
      // 最高层 (row 3)
      rect((9 * w, 3 * w), (10 * w, 4 * w), stroke: shape-stroke)
      // 第二层 (row 2)
      rect((10 * w, 2 * w), (11 * w, 3 * w), stroke: shape-stroke)
      // 第三层 (row 1)
      rect((11 * w, 1 * w), (12 * w, 2 * w), stroke: shape-stroke)
      // 最底层 (row 0)
      rect((12 * w, 0 * w), (13 * w, 1 * w), stroke: shape-stroke)
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
    #text(weight: "bold", fill: luma(80), size: 11pt)[绘图原理与步骤]
    #v(0.4em)
    
    - *反推思想验证*：题干告知某未知图形占整体的 $1/4$，而在网格中推导出该完整图形。意味着要求呈现的作品体积必须恰好包含 $4$ 个基础方格（$4 times 1/4 = 1$ 个完整图形）。
    - *网格环境搭建*：通过对参考答案的精准读图测算，得出总画幅为横跨 $14$ 列 $times$ 垂直 $4$ 行的结构网格。通过外层嵌套两组正交的 for 遍历循环，用线段拼接画出无断连的实线灰色大背景测量矩阵。
    - *图形边界提取定位*：抛弃内部填色，直接采用非常醒目的青蓝色（增厚边界线）在底层网格之上套刻轮廓框：
      - *图式1*：在画布左下（起步坐标 $[1, 0]$）划定了 $2 times 2$ 的结构，包含了规整的 $4$ 个单位格。
      - *图式2*：在底边中部（起步坐标 $[5, 0]$）横划出长为 $4$、高度为 $1$ 的平铺矩形条。
      - *图式3*：于图板右侧（跨度从 $x=9$ 到 $13$），独立声明四个 $1 times 1$ 正方形，并且令每组横坐标增加 $1$ 的同时纵偏移相对应降低一格，以对角形式连接起来。
    - *总结*：三者从形态变幻均达到了恰好占据 $4$ 格这一前提，充分穷举复刻了原题范例。
  ]
}
