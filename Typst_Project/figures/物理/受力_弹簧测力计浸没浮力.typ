// ============================================================
// 受力示意图（弹簧测力计悬挂石球浸没水中的浮力）
// 绘图 + 解答合并
// ============================================================

#import "@preview/cetz:0.4.2"

// ==========================================
// 输出：题目 + 解答
// ==========================================
#let render() = {
  // --- 题目 ---
  set par(first-line-indent: 0em)

  text(weight: "bold", size: 12pt, fill: rgb(90, 160, 210))[2.]
  text(
    size: 11pt,
  )[将挂在弹簧测力计上的石球浸没到水中，如图 9-8-1 所示。请画出石球的受力示意图，并写出这几个力之间的关系式。]

  v(2.0em)

  // --- 绘图 ---
  align(center)[
    #cetz.canvas(length: 1cm, {
      import cetz.draw: *

      let caption-color = rgb(88, 166, 216)
      let water-color = rgb(198, 238, 255) // 参考图中的浅蓝色
      let ball-color = rgb("#7ad3f0") // 参考图中的深蓝色

      let bx1 = -1.5
      let bx2 = 1.5
      let h = 3.6
      let yw = 2.4 // 水面高度

      // 1. 填充水区域
      line((bx1, 0), (bx2, 0), (bx2, yw), (bx1, yw), close: true, fill: water-color, stroke: none)

      // 2. 绘制水面线条
      line((bx1, yw), (bx2, yw), stroke: 1pt + rgb(120, 180, 210))

      // 3. 绘制直壁烧杯外框 (开口处带防侧漏外翻短线)
      line((bx1 - 0.2, h), (bx1, h), (bx1, 0), (bx2, 0), (bx2, h), (bx2 + 0.2, h), stroke: 1.5pt + black)

      // 4. 石球绘制 (完全浸没)
      let cx = 0.0
      let cy = 1.0 // 石球中心高度
      let r = 0.4 // 石球半径
      circle((cx, cy), radius: r, fill: ball-color, stroke: 1.2pt + black)
      circle((cx, cy), radius: 0.05, fill: black) // 重心/浮心

      // 5. 悬挂细线与弹簧测力计
      // 细线
      line((cx, cy + r), (cx, h + 0.5), stroke: 1pt + black)

      // 测力计钩子 (简易J型外观)
      line((0, h + 0.8), (0, h + 0.5), (-0.15, h + 0.4), (-0.15, h + 0.5), stroke: 1.5pt + black)

      // 测力计外壳
      let sx1 = -0.3
      let sx2 = 0.3
      let sy1 = h + 0.8
      let sy2 = h + 3.8
      rect((sx1, sy1), (sx2, sy2), radius: 0.1, fill: white, stroke: 1.2pt + black)

      // 测力计顶部拉环
      circle((0, sy2 + 0.15), radius: 0.15, stroke: 1.2pt + black)

      // 测力计内部标识线与刻度
      line((0, sy1 + 0.2), (0, sy2 - 0.2), stroke: 1pt + black)
      for i in range(13) {
        let ty = sy1 + 0.4 + i * 0.2
        line((0, ty), (-0.15, ty), stroke: 0.8pt + black)
      }

      // 内部受力指针
      let pointer_y = sy1 + 1.2
      line((-0.2, pointer_y), (0.2, pointer_y), stroke: 1.5pt + black)

      // 6. 受力示意图 (严格处于多力平衡下的一维矢量绘图)
      // 长度比缩放原则: 重力向下, 浮力拉力向上。平衡方程 G = F_浮 + F_拉
      // 长度设定: $L_G = 2.4$, $L_F浮 = 0.9$, $L_F拉 = 1.5$ 保证 $2.4 = 0.9 + 1.5$
      let l_g = 2.4
      let l_f_buoy = 0.9
      let l_f_pull = 1.5

      // 为了防止同一竖直路径发生遮挡重叠，利用横向微分偏移法
      // (1) 重力 G 向下
      line((cx, cy), (cx, cy - l_g), mark: (end: "stealth", fill: black), stroke: 1.5pt + black)
      content((cx + 0.3, cy - l_g + 0.2), [ $G$ ])

      // (2) 浮力 F_浮 向上 (向左偏移 0.12 单位起笔)
      line((cx, cy), (cx, cy + l_f_buoy), mark: (end: "stealth", fill: black), stroke: 1.5pt + black)
      content((cx - 0.45, cy + l_f_buoy - 0.1), [ $F_("浮")$ ])

      // (3) 拉力 F_拉 向上 (向右偏移 0.12 单位起笔)
      line((cx, cy), (cx, cy + l_f_pull), mark: (end: "stealth", fill: black), stroke: 1.5pt + black)
      content((cx + 0.45, cy + l_f_pull - 0.1), [ $F_("拉")$ ])

      // 底部标题
      content((0, -2.2))[ #text(fill: caption-color)[图 9-8-1] ]
    })
  ]

  v(1.0em)

  // --- 关系式 ---
  align(center)[
    #text(size: 11pt, weight: "bold")[石球受力平衡关系式：]
    #v(0.5em)
    #text(size: 12pt)[ $ G = F_("浮") + F_("拉") $ ]
  ]

  v(1.8em)

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

    + *图元基础绘制*：使用常规 `line` 函数构建具有翻边元素的透明直壁矩形烧杯，添加表示满水平面的多边形着色。使用 `rect` 及 `for` 循环线条阵列渲染测力计结构（包括拉环和量线刻度）。
    + *浸没球体定位*：设定水面高度 `yw` 为 $2.4$，球体中心 `cy` 取 $1.0$、带半径 $0.6$，确保球完全处在液面下限。画出链接弹簧秤底部弯钩的细拉绳。
    + *受力精确表达*：石球处于静力平衡，同时受到向下的重力 $G$ 以及向上的弹簧拉力 $F_("拉")$ 和水产生的浮力 $F_("浮")$。根据受力平衡关系在作图中确立矢量比例关系 $L_G = L_{F_("拉")} + L_{F_("浮")}$（具体采用值为：重力 $2.4 =$ 拉力 $1.5 +$ 浮力 $0.9$），使得向下的长箭头等于向上两个短箭头的代数和长度，保证物理严谨性。
    + *防遮挡处理*：在对三个同一竖直维度上的同心作用力作图时，重力原位标定。两个向上力起点利用视觉上的横向微步错位法分散开（浮力向左移 $0.12$，弹力向右移 $0.12$）。由于力的平行且互不叠加，有效阻止了箭头和指示标签糊在一起导致看不清的问题。
  ]
}
