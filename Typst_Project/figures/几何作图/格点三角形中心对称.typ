// ============================================================
// 格点三角形中心对称与面积
// 绘图 + 解答合并
// ============================================================

#import "@preview/cetz:0.4.2"

#let render() = {
  // --- 题目 ---
  set par(first-line-indent: 0em)
  text(weight: "bold", size: 12pt)[7. ]
  text(size: 11pt)[如图，方格纸每一个方格的边长为 1，点 $A, B, C, D$ 均在格点上.]
  
  v(1.5em)

  // --- 绘图区域 ---
  align(center)[
    #cetz.canvas(length: 0.6cm, {
      import cetz.draw: *
      
      // 1. 绘制 12 x 8 网格
      let w = 12
      let h = 8
      grid((0, 0), (w, h), stroke: (paint: luma(180), dash: (2pt, 1.2pt), thickness: 0.5pt))
      
      // 2. 坐标定义 (以左下角为(0,0))
      let pt-A  = (7, 7)
      let pt-B  = (1, 7)
      let pt-C  = (11, 3)
      let pt-D  = (6, 4)
      
      // 计算对称点 (P1 = 2*D - P)
      let pt-A1 = (5, 1)
      let pt-B1 = (11, 1)
      let pt-C1 = (1, 5)
      
      // 中点 E
      let pt-E  = (6, 5)
      
      // 绘制填充四边形区域（淡淡的底色展现计算面积求的四边形）
      merge-path(fill: rgb("E63946").lighten(85%), stroke: none, {
        line(pt-B, pt-C1, pt-B1, pt-C, close: true)
      })

      // 绘制中心对称参照虚线
      line(pt-A, pt-A1, stroke: (paint: gray, dash: "dotted"))
      line(pt-B, pt-B1, stroke: (paint: gray, dash: "dotted"))
      line(pt-C, pt-C1, stroke: (paint: gray, dash: "dotted"))
      
      // 绘制用于计算面积的辅助线段 B-C1 和 C-B1
      line(pt-B, pt-C1, stroke: (paint: rgb("E63946"), dash: (2pt, 1.2pt), thickness: 1pt))
      line(pt-C, pt-B1, stroke: (paint: rgb("E63946"), dash: (2pt, 1.2pt), thickness: 1pt))
      
      // 绘制原始三角形
      line(pt-A, pt-B, pt-C, close: true, stroke: 1pt + black)
      
      // 绘制旋转后的三角形 (深蓝色区分解答)
      let ans-color = rgb(31, 120, 180)
      line(pt-A1, pt-B1, pt-C1, close: true, stroke: 1.2pt + ans-color)
      
      // 绘制标记点
      let draw-pt(pos, label, anchor, col: black) = {
        circle(pos, radius: 0.12, fill: col, stroke: none)
        content(pos, anchor: anchor, padding: 3pt, text(fill: col, size: 10pt)[#label])
      }
      
      draw-pt(pt-A, $A$, "south-west")
      draw-pt(pt-B, $B$, "south-east")
      draw-pt(pt-C, $C$, "north-west")
      draw-pt(pt-D, $D$, "north-east")
      
      draw-pt(pt-A1, $A_1$, "north-east", col: ans-color)
      draw-pt(pt-B1, $B_1$, "north-west", col: ans-color)
      draw-pt(pt-C1, $C_1$, "south-east", col: ans-color)
      
      draw-pt(pt-E, $E$, "south-west", col: red)
    })
  ]
  
  align(center)[#text(size: 10pt)[（第 7 题）]]
  v(1em)
  
  text(size: 11pt)[
    （1）以点 $D$ 为旋转中心，将 $triangle A B C$ 旋转 180° 得到 $triangle A_1 B_1 C_1$，画出 $triangle A_1 B_1 C_1$；\
    （2）以 $B$, $C_1$, $B_1$, $C$ 为顶点的四边形的面积为 #box(stroke: (bottom: 1pt), outset: (bottom: 2pt), width: 3em)[#align(center)[#text(fill: blue, weight: "bold")[20]]] .\
    （3）在 $B C$ 上确定一个格点 $E$，使得 $B C = 2 B E$ . （已在上图用红色点标出）
  ]

  v(1.5em)

  // --- 解答部分 ---
  let answer-style(body) = text(fill: blue.darken(20%), weight: "bold", body)
  
  block(
    width: 100%,
    inset: (x: 1em, y: 0.8em),
    stroke: (left: 2pt + rgb(31, 120, 180)),
    fill: rgb(245, 250, 255),
    radius: 2pt,
  )[
    #set par(first-line-indent: 0em)
    #text(weight: "bold", fill: rgb(31, 120, 180), size: 10pt)[【解析与解答】]
    #v(0.3em)
    #set text(size: 10pt)
    
    （1）根据中心对称的性质，分别找出点 $A$、$B$、$C$ 关于点 $D$ 的对称点 $A_1, B_1, C_1$，顺次连接即可。作图见上方蓝色三角形。

    （2）补全点 $C_1, B_1$ 坐标后，连接 $B C_1, C_1 B_1$ 形成四边形 $B C_1 B_1 C$（如图中浅红色阴影区域边界所示）。观察网格发现，$B$ 点与 $C_1$ 点位于同一竖直线上，两者距离为 2；$C$ 点与 $B_1$ 点也位于同一竖直线上，距离也为 2。这一平行四边形可以看作是以竖直平行线段为底（底边长为 2），水平间距为高（水平距离为 10）的图形。其面积 $S = 2 times 10 = $ #answer-style[20] 。

    （3）由 $B C = 2 B E$ 且 $E$ 在 $B C$ 上可知，$E$ 是线段 $B C$ 的中点。设左下角网格点为原点 $(0,0)$，则 $B(1,7)$，$C(11,3)$。计算得中点 $E$ 坐标为 $(frac(1+11, 2), frac(7+3, 2)) = (6,5)$。该坐标均为整数，恰好是一个格点。在图中标出该点 $E$ 即可，如上方红色点 $E$ 所示。
  ]

  v(1.2em)

  // --- 绘图原理与步骤 ---
  block(
    width: 100%,
    inset: (x: 1em, y: 0.8em),
    stroke: (left: 2pt + luma(180)),
    fill: luma(248),
    radius: 2pt,
  )[
    #set par(first-line-indent: 0em)
    #text(weight: "bold", size: 10pt)[绘图原理与步骤]
    #v(0.3em)
    #set text(size: 9pt)

    + *建立坐标系*：以网格左下角为原点 $(0,0)$ 建立直角坐标系，总网格尺寸为 $12 times 8$。
    + *确定初始点坐标*：通过数格点定出 $A(7,7)$、$B(1,7)$、$C(11,3)$、$D(6,4)$。
    + *计算对称点*：应用中心对称公式 $P_1 = 2 D - P$，可得 $A_1(5,1)$、$B_1(11,1)$、$C_1(1,5)$。
    + *计算与标定特殊点*：$E$ 为 $B C$ 的中点，计算得出 $E(6,5)$。
    + *绘制图形结构*：
      - 使用 `cetz` 绘制底层虚线网格 `grid((0,0), (12,8))`。
      - 绘制背景浅红色的四边形区域底色，辅助看出被求面积的主体。
      - 利用 `line` 封闭绘制原始的黑色三角形与旋转后的蓝色三角形，并加上中心对称的追溯点划线。
      - 分别使用 `circle` 及 `content` 的四个象限锚点功能将字幕标记放置在不遮挡线段的最佳相对位置。
  ]
}
