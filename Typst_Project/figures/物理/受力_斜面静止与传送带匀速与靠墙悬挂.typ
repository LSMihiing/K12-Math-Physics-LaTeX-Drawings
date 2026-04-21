// ============================================================
// 受力示意图（斜面静止、传送带匀速、靠墙悬挂）
// 绘图 + 解答合并
// ============================================================

#import "@preview/cetz:0.4.2"

// ==========================================
// 输出：题目 + 解答
// ==========================================
#let render() = {
  // --- 题目 ---
  set par(first-line-indent: 0em)
  text(weight: "bold", size: 12pt)[20.]
  text(size: 11pt)[（6分）按照题目要求作图。]

  v(0.5em)
  text(size: 11pt)[
    （1）如图甲所示，物体静止在粗糙斜面上。试作出物体所受力的示意图。\
    （2）如图乙所示，物体随水平传送带一起匀速移动。试作出物体所受力的示意图。\
    （3）如图丙所示，小球斜挂在墙上处于静止状态。试作出小球所受重力的示意图。
  ]

  v(1.5em)

  // --- 绘图 ---
  align(center)[
    #cetz.canvas(length: 0.85cm, {
      import cetz.draw: *

      // ==================== 甲：斜面上的物体 ====================
      group(name: "jia", {
        let ox = 0.0
        let oy = 0.0

        // 1. 绘制斜面体
        let aw = 4.0
        let ah = 2.0
        line((ox, oy), (ox + aw, oy), (ox, oy + ah), close: true, stroke: 1pt + black)

        // 2. 几何向量计算
        let dx = aw
        let dy = -ah
        let d_len = calc.sqrt(dx * dx + dy * dy)
        let ux = dx / d_len // 斜面向下单位向量
        let uy = dy / d_len
        let nx = -uy // 垂直斜面向外单位向量
        let ny = ux

        // 3. 物块位置与尺寸
        let mid_dist = d_len * 0.45
        let cx = ox + mid_dist * ux
        let cy = oy + ah + mid_dist * uy
        let bw = 1.0
        let bh = 0.8

        // 物块顶点
        let p1 = (cx - bw / 2 * ux, cy - bw / 2 * uy)
        let p2 = (cx + bw / 2 * ux, cy + bw / 2 * uy)
        let p3 = (p2.at(0) + bh * nx, p2.at(1) + bh * ny)
        let p4 = (p1.at(0) + bh * nx, p1.at(1) + bh * ny)
        line(p1, p2, p3, p4, close: true, fill: none, stroke: 1pt + black)

        // 重心位置
        let cg_x = cx + bh / 2 * nx
        let cg_y = cy + bh / 2 * ny
        circle((cg_x, cg_y), radius: 0.05, fill: black)

        // 4. 绘制受力示意图 (静止在粗糙斜面：重力、支持力、摩擦力)
        let f_len = 1.6 // 重力长度
        let fn_len = f_len * calc.cos(calc.atan2(aw, ah)) // 支持力长度 (理论上等于G的法向分力)
        let ff_len = f_len * calc.sin(calc.atan2(aw, ah)) // 摩擦力长度

        // 重力 G
        line((cg_x, cg_y), (cg_x, cg_y - f_len), mark: (end: "stealth", fill: black), stroke: 1.2pt + black)
        content((cg_x + 0.4, cg_y - f_len + 0.2))[ $G$ ]

        // 支持力 F_N
        line(
          (cg_x, cg_y),
          (cg_x + fn_len * nx, cg_y + fn_len * ny),
          mark: (end: "stealth", fill: black),
          stroke: 1.2pt + black,
        )
        content((cg_x + fn_len * nx + 0.1, cg_y + fn_len * ny + 0.4))[ $F_N$ ]

        // 摩擦力 f (沿斜面向上)
        line(
          (cg_x, cg_y),
          (cg_x - ff_len * ux, cg_y - ff_len * uy),
          mark: (end: "stealth", fill: black),
          stroke: 1.2pt + black,
        )
        content((cg_x - ff_len * ux - 0.3, cg_y - ff_len * uy + 0.3))[ $f$ ]

        // 标号
        content((ox + aw / 2, oy - 1.0))[ 甲 ]
      })

      // ==================== 乙：传送带上的物体 ====================
      group(name: "yi", {
        let ox = 6.5
        let oy = 0.5

        // 1. 传送带
        let p1_x = ox + 1.0
        let p2_x = ox + 4.0
        let p_y = oy
        let r = 0.6

        // 两个带轮
        circle((p1_x, p_y), radius: r, stroke: 1pt + black)
        circle((p2_x, p_y), radius: r, stroke: 1pt + black)
        circle((p1_x, p_y), radius: 0.05, fill: black)
        circle((p2_x, p_y), radius: 0.05, fill: black)

        // 转动方向箭头 (采用离散线段绘制以避开 API 渲染偏置问题)
        {
          let r_arrow = 0.3
          let start_a = 150deg
          let end_a = 30deg
          let steps = 10
          // 左轮
          for i in range(steps) {
            let a1 = start_a + i * (end_a - start_a) / steps
            let a2 = start_a + (i + 1) * (end_a - start_a) / steps
            let m = if i == steps - 1 { (end: "stealth", fill: black, size: 4pt) } else { none }
            line(
              (p1_x + r_arrow * calc.cos(a1), p_y + r_arrow * calc.sin(a1)),
              (p1_x + r_arrow * calc.cos(a2), p_y + r_arrow * calc.sin(a2)),
              mark: m,
              stroke: 0.6pt + black,
            )
          }
          // 右轮
          for i in range(steps) {
            let a1 = start_a + i * (end_a - start_a) / steps
            let a2 = start_a + (i + 1) * (end_a - start_a) / steps
            let m = if i == steps - 1 { (end: "stealth", fill: black, size: 4pt) } else { none }
            line(
              (p2_x + r_arrow * calc.cos(a1), p_y + r_arrow * calc.sin(a1)),
              (p2_x + r_arrow * calc.cos(a2), p_y + r_arrow * calc.sin(a2)),
              mark: m,
              stroke: 0.6pt + black,
            )
          }
        }

        // 皮带上下边缘
        line((p1_x, p_y + r), (p2_x, p_y + r), stroke: 1.2pt + black)
        line((p1_x, p_y - r), (p2_x, p_y - r), stroke: 1.2pt + black)

        // 2. 物块
        let bw = 1.0
        let bh = 0.8
        let cg_x = (p1_x + p2_x) / 2
        let cg_y = p_y + r + bh / 2
        rect((cg_x - bw / 2, p_y + r), (cg_x + bw / 2, p_y + r + bh), stroke: 1pt + black)
        circle((cg_x, cg_y), radius: 0.05, fill: black)

        // 速度 v 箭头 (上方)
        line(
          (cg_x - 0.4, cg_y + bh / 2 + 0.3),
          (cg_x + 0.6, cg_y + bh / 2 + 0.3),
          mark: (end: "stealth", fill: black),
          stroke: 0.8pt + black,
        )
        // content((cg_x + 0.1, cg_y + bh / 2 + 0.6))[ $v$ ]

        // 3. 绘制受力示意图 (匀速直线运动，仅受重力和支持力)
        let f_len = 1.4
        // 重力 G
        line((cg_x, cg_y), (cg_x, cg_y - f_len), mark: (end: "stealth", fill: black), stroke: 1.2pt + black)
        content((cg_x + 0.4, cg_y - f_len + 0.2))[ $G$ ]

        // 支持力 F_N
        line((cg_x, cg_y), (cg_x, cg_y + f_len), mark: (end: "stealth", fill: black), stroke: 1.2pt + black)
        content((cg_x + 0.5, cg_y + f_len - 0.2))[ $F_N$ ]

        // 标号
        content((cg_x, oy - 1.5))[ 乙 ]
      })

      // ==================== 丙：靠墙悬挂的小球 ====================
      group(name: "bing", {
        let ox = 13.5
        let oy = 0.0

        // 1. 墙壁
        let wall_h = 3.5
        line((ox, oy), (ox, oy + wall_h), stroke: 1pt + black)
        // 画墙壁阴影线
        for i in range(15) {
          let y = oy + 0.2 + i * 0.22
          line((ox, y), (ox - 0.2, y - 0.2), stroke: 0.5pt + black)
        }

        // 2. 小球与绳子
        let r = 0.6
        let ball_cx = ox + r
        let ball_cy = oy + 1.2
        let attach_y = oy + 3.0

        // 绳子 (连接墙面挂点和球心/球的边缘)
        // 题图绳子延长线过球心
        let str_dx = ball_cx - ox
        let str_dy = ball_cy - attach_y
        let str_len = calc.sqrt(str_dx * str_dx + str_dy * str_dy)
        let edge_x = ball_cx - r * (str_dx / str_len)
        let edge_y = ball_cy - r * (str_dy / str_len)
        line((ox, attach_y), (edge_x, edge_y), stroke: 1pt + black)

        // 小球
        circle((ball_cx, ball_cy), radius: r, fill: none, stroke: 1pt + black)
        circle((ball_cx, ball_cy), radius: 0.05, fill: black) // 球心

        // 3. 绘制受力示意图 (只画重力)
        let g_len = 1.5
        line((ball_cx, ball_cy), (ball_cx, ball_cy - g_len), mark: (end: "stealth", fill: black), stroke: 1.2pt + black)
        content((ball_cx + 0.4, ball_cy - g_len + 0.2))[ $G$ ]

        // 标号
        content((ox + 1.0, oy - 1.0))[ 丙 ]
      })
    })
  ]

  v(1.2em)

  // --- 解析部分 ---
  block(
    width: 100%,
    inset: (x: 1em, y: 0.8em),
    stroke: (left: 2pt + rgb(31, 120, 180)),
    fill: rgb(245, 250, 255),
    radius: 2pt,
  )[
    #set par(first-line-indent: 0em)
    #text(weight: "bold", fill: rgb(31, 120, 180), size: 10pt)[【解析】]
    #v(0.3em)
    #set text(size: 10pt)
    1. *图甲*：物体静止在斜面上，处于平衡状态。它受到竖直向下的*重力* $G$、垂直于斜面向上的*支持力* $F_N$，以及阻碍其相对下滑的沿斜面向上的*静摩擦力* $f$。这三个力的作用点都可以画在物体的重心。
    2. *图乙*：物体随传送带一起向右匀速直线运动。在竖直方向上，受竖直向下的*重力* $G$ 和竖直向上的*支持力* $F_N$ 作用，二者平衡。在水平方向上，物体与传送带之间没有相对运动及相对运动趋势，故*不受摩擦力*。
    3. *图丙*：题目仅要求作出小球所受*重力*的示意图。重力方向竖直向下，作用点在球心，用线段和箭头表示，并标明符号 $G$。

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

    + *甲图*：绘制三角形斜面和其上的矩形物块。确定重心位置后，分别沿竖直向下、垂直斜面向外、平行斜面向上的方向，绘制重力 $G$、支持力 $F_N$ 和摩擦力 $f$ 的矢量箭头。
    + *乙图*：使用两个圆弧线与平行线构建传送带，绘制矩形物块及其上方的速度指示箭头。从物块重心出发，绘制大小相等、方向相反的重力 $G$ 和支持力 $F_N$（水平方向不画力）。
    + *丙图*：绘制带有阴影线标记的墙面、绳索及小球。找到球心坐标，仅向正下方绘制重力 $G$ 的矢量箭头。
  ]
}
