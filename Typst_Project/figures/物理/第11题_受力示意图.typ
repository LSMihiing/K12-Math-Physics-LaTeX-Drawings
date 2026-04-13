// ============================================================
// 第11题 · 受力示意图（足球、斜面物块、小车拉力）
// 绘图 + 解答合并
// ============================================================

#import "@preview/cetz:0.4.2"

// ==========================================
// 输出：题目 + 解答
// ==========================================
#let render() = {
  // --- 题目 ---
  set par(first-line-indent: 0em)
  text(weight: "bold", size: 12pt)[11.]
  text(size: 11pt)[在图 7-2-4 中画出下列情况的力的示意图。]

  v(0.5em)
  text(size: 11pt)[
    （1）图 7-2-4(a)中虚线表示足球在空中飞行的路线。若足球的质量为 $0.5 upright("kg")$，则它所受的重力是 #underline[　$5$　] $upright("N")$。请画出足球在图示位置时所受重力的示意图。($g$ 取 $10 upright("N")/upright("kg")$)\
    （2）如图 7-2-4(b)所示，画出从斜面上下滑的物体所受重力的示意图。\
    （3）如图 7-2-4(c)所示，用与水平方向成 $30^degree$ 角方向斜向右上方、大小为 $750 upright("N")$ 的力向右拉车（作用点在 $A$ 点），画出这个拉力的示意图。
  ]

  v(1.5em)

  // --- 绘图 ---
  align(center)[
    #cetz.canvas(length: 0.85cm, {
      import cetz.draw: *
      let fill-color = rgb(124, 214, 245) // 原图中的浅蓝色填充

      // ==================== (a) 足球 ====================
      group(name: "a", {
        // 虚线轨迹（弧线只包含抛物线左边上升部分）
        bezier((0, 0.5), (4.0, 2.5), (1.33, 1.83), (2.67, 2.5), stroke: (dash: "dashed", paint: luma(80)))

        // 足球参数 (恰好在曲线上, t=0.5 处)
        let bx = 2.0
        let by = 2.0

        // 足球
        circle((bx, by), radius: 0.35, fill: fill-color, stroke: 0.8pt + black)

        // 重力 G
        line((bx, by), (bx, by - 1.8), mark: (end: "stealth", fill: black), stroke: 1.2pt + black)
        content((bx + 1, by - 1.2))[ $G = 5 upright("N")$ ]

        // 标号
        content((2.0, -1.2))[ (a) ]
      })

      // ==================== (b) 斜面物块 ====================
      group(name: "b", {
        let ox = 6.0
        let oy = 0.0

        // 三角形斜面 (由于宽高不同，直角在左下方)
        line((ox, oy), (ox + 5, oy), (ox, oy + 2), close: true, stroke: 1pt + black)

        // 几何计算正交基
        let H_x = 5.0
        let H_y = -2.0
        let L = calc.sqrt(H_x * H_x + H_y * H_y)
        let ux = H_x / L
        let uy = H_y / L
        let nx = -uy
        let ny = ux

        // 物块中心位于斜面上相当于 x=2.5 的位置
        let Px = ox + 2.5
        let Py = oy + 2.0 - 0.4 * 2.5 // = 1.0
        let w = 0.6 // 半宽
        let h = 0.7 // 高度

        // 物块四个顶点
        let bl_x = Px - w * ux
        let bl_y = Py - w * uy
        let br_x = Px + w * ux
        let br_y = Py + w * uy
        let tr_x = br_x + h * nx
        let tr_y = br_y + h * ny
        let tl_x = bl_x + h * nx
        let tl_y = bl_y + h * ny

        // 画物块
        line(
          (bl_x, bl_y),
          (br_x, br_y),
          (tr_x, tr_y),
          (tl_x, tl_y),
          close: true,
          fill: fill-color,
          stroke: 0.8pt + black,
        )

        // 物体质心
        let cg_x = Px + h / 2 * nx
        let cg_y = Py + h / 2 * ny

        // 速度方向 v (虚线指示辅助)
        let vx = cg_x + (h / 2 + 0.2) * nx
        let vy = cg_y + (h / 2 + 0.2) * ny
        line((vx, vy), (vx + 1.2 * ux, vy + 1.2 * uy), mark: (end: "stealth", fill: black), stroke: 0.6pt + black)
        content((vx + 0.6 * ux + 0.3 * nx, vy + 0.6 * uy + 0.4 * ny))[ $v$ ]

        // 重力示意图
        line((cg_x, cg_y), (cg_x, cg_y - 1.8), mark: (end: "stealth", fill: black), stroke: 1.2pt + black)
        content((cg_x + 0.5, cg_y - 1))[ $G$ ]

        // 标号
        content((ox + 2.5, -1.2))[ (b) ]
      })

      // ==================== (c) 小车拉力 ====================
      group(name: "c", {
        let ox = 12.5
        let oy = 0.0

        // 地面与阴影线
        line((ox - 0.5, oy), (ox + 4.5, oy), stroke: 1pt + black)
        for i in range(16) {
          let x = ox - 0.3 + i * 0.3
          line((x, oy), (x - 0.2, oy - 0.2), stroke: 0.5pt + black)
        }

        // 车轮
        circle((ox + 0.8, oy + 0.25), radius: 0.25, stroke: 1pt + black)
        circle((ox + 2.8, oy + 0.25), radius: 0.25, stroke: 1pt + black)
        circle((ox + 0.8, oy + 0.25), radius: 0.05, fill: black)
        circle((ox + 2.8, oy + 0.25), radius: 0.05, fill: black)

        // 车身 (位于轮子切线y=0.5之上)
        line(
          (ox + 0.2, oy + 0.5),
          (ox + 3.4, oy + 0.5),
          (ox + 3.4, oy + 1.8),
          (ox + 0.2, oy + 1.8),
          close: true,
          stroke: 1pt + black,
        )

        // A 点 (车身右上角)
        let ax = ox + 3.4
        let ay = oy + 1.8
        circle((ax, ay), radius: 0.06, fill: black)
        content((ax - 0.1, ay + 0.35))[ $A$ ]

        // 拉力 F (30度)
        let F_L = 2.0
        let cos30 = calc.cos(30deg)
        let sin30 = calc.sin(30deg)
        let Fx = ax + F_L * cos30
        let Fy = ay + F_L * sin30
        line((ax, ay), (Fx, Fy), mark: (end: "stealth", fill: black), stroke: 1.2pt + black)
        content((ax + 1.2 * cos30 - 0.2, ay + 1.2 * sin30 + 0.6))[ $F = 750 upright("N")$ ]

        // 辅助虚线
        line((ax, ay), (ax + 1.8, ay), stroke: (dash: "dashed", paint: black))

        // 角度弧线 (用多个细小线段平滑过渡避免CeTZ api问题)
        let r = 0.8
        for i in range(15) {
          let a1 = i * 2deg
          let a2 = (i + 1) * 2deg
          let x1 = ax + r * calc.cos(a1)
          let y1 = ay + r * calc.sin(a1)
          let x2 = ax + r * calc.cos(a2)
          let y2 = ay + r * calc.sin(a2)
          line((x1, y1), (x2, y2), stroke: 0.6pt + black)
        }
        content((ax + 1.15, ay + 0.25))[ $30^degree$ ]

        // 标号
        content((ox + 1.8, -1.2))[ (c) ]
      })
    })
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

    + *坐标编排*：在一张画布中分别平移绘制 (a)(b)(c) 三个图形，相对基准 x 轴偏移依次为 `0`、`6.0`、`12.5`。
    + *(a) 足球*：使用贝塞尔曲线 `#bezier` 绘制虚线轨迹；根据轨迹坐标计算出球心位置，绘制圆形；自球心画指向正下方的矢量箭头并在末端标注 $G=5$ N。
    + *(b) 斜面物块*：绘制长宽比例固定的直角三角形斜面；通过几何投影求出斜面的单位切向量和法向量，反算并绘制出矩形物块；分别自质心竖直向下绘制重力 $G$，以及物块切面上方绘制平行于斜面的速度向量 $v$。
    + *(c) 小车*：利用矩形和圆拼接绘制小车轮廓，原点作用位置 $A$ 点设于车身右上角；以 $A$ 为原点，根据角度 $30^degree$ 的三角函数投影计算终点坐标，画受力箭头并标注 $F=750$ N。角度小圆弧使用多个小线段离散绘制。
  ]
}
