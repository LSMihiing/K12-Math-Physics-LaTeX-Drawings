// ============================================================
// 杠杆最小力作图
// 根据题干图判断：水平台面上放竖直长方体，台面下两个支点（滚轮）
// 要求画出使台面翘起的最小力 F 及其力臂 L
// ============================================================

#import "@preview/cetz:0.4.2"

// ==========================================
// 输出：题目 + 解答
// ==========================================
#let render() = {
  // --- 题目 ---
  set par(first-line-indent: 0em)

  text(weight: "bold", size: 12pt, fill: rgb(90, 160, 210))[20.]
  text(size: 11pt)[如图所示，请画出使杠杆绕支点 O 逆时针转动的最小力 F，并画出力臂 L。]

  v(2.0em)

  // --- 绘图 ---
  align(center)[
    #cetz.canvas(length: 0.85cm, {
      import cetz.draw: *

      let caption-color = rgb(88, 166, 216)
      let block-color = rgb(120, 190, 230)

      // 杠杆参数
      let beam_l = -3.5 // 杠杆左端 x
      let beam_r = 3.5 // 杠杆右端 x
      let beam_h = 0.15 // 杠杆半厚度
      let beam_y = 0 // 杠杆中心 y

      // 支点位置（两个滚轮）
      let o1_x = -1.0 // 左支点
      let o2_x = 1.0 // 右支点（转动支点 O）
      let roller_r = 0.2 // 滚轮半径
      let roller_y = beam_y - beam_h - roller_r

      // 底面（地面）
      let ground_y = roller_y - roller_r - 0.1
      line((beam_l - 0.5, ground_y), (beam_r + 0.5, ground_y), stroke: 1pt + black)
      // 地面斜线纹理
      for i in range(15) {
        let gx = beam_l - 0.3 + i * 0.5
        line((gx, ground_y), (gx - 0.25, ground_y - 0.25), stroke: 0.6pt + luma(120))
      }

      // 杠杆（横梁）
      rect(
        (beam_l, beam_y - beam_h),
        (beam_r, beam_y + beam_h),
        fill: luma(230),
        stroke: 1.2pt + black,
      )

      // 两个滚轮/支点
      circle((o1_x, roller_y), radius: roller_r, fill: white, stroke: 1.2pt + black)
      circle((o1_x, roller_y), radius: 0.04, fill: black)

      circle((o2_x, roller_y), radius: roller_r, fill: white, stroke: 1.2pt + black)
      circle((o2_x, roller_y), radius: 0.04, fill: black)

      // 标注右支点为 O
      content((o2_x + 0.05, roller_y - 0.45), text(size: 9pt, weight: "bold")[O])

      // 竖直长方体（放在杠杆右侧）
      let blk_w = 0.8 // 方块宽度
      let blk_h = 2.0 // 方块高度
      let blk_x = 2.2 // 方块中心 x
      rect(
        (blk_x - blk_w / 2, beam_y + beam_h),
        (blk_x + blk_w / 2, beam_y + beam_h + blk_h),
        fill: block-color,
        stroke: 1.2pt + black,
      )

      // ====== 答案部分 ======
      // 绕右支点 O 逆时针转动，需要在杠杆左端施加向下的力
      // 最小力条件：力臂最长 → 力的作用点在离支点最远处（左端）
      // 力的方向垂直于支点到作用点的连线

      // 支点 O 在 (o2_x, roller_y) = (1.0, ...)
      // 左端点在 (beam_l, beam_y) = (-3.5, 0)
      // 连线方向：从 O 到左端 = (beam_l - o2_x, beam_y - roller_y)

      let ox = o2_x
      let oy = roller_y
      let ax = beam_l // 力的作用点 = 杠杆左端
      let ay = beam_y // 杠杆面

      // 力臂 = 从 O 到左端的距离（这就是最长力臂）
      // 力的方向：垂直于 OA 连线，且使杠杆逆时针转动 → 向下偏左
      let dx = ax - ox // -4.5
      let dy = ay - oy // 正值（从滚轮中心到杠杆面）
      // 垂直于 (dx, dy) 的方向有两个：(dy, -dx) 和 (-dy, dx)
      // 逆时针转动要求向下的分力 → 选择 (-dy, dx)
      // 归一化
      let mag = calc.sqrt(dx * dx + dy * dy)
      let perp_x = -dy / mag
      let perp_y = dx / mag

      // 最小力 F 箭头
      let f_len = 2.0
      line(
        (ax, ay),
        (ax + f_len * perp_x, ay + f_len * perp_y),
        mark: (end: "stealth", fill: black),
        stroke: 1.5pt + black,
      )
      content(
        (ax + f_len * perp_x - 0.4, ay + f_len * perp_y + 0.3),
        text(size: 10pt, weight: "bold")[ $F$ ],
      )

      // 力臂 L（从支点 O 到力的作用线的距离 = OA 连线长度）
      // 用虚线从 O 画到 A
      line(
        (ox, oy),
        (ax, ay),
        stroke: (paint: black, thickness: 0.8pt, dash: "dashed"),
      )

      // 力臂标注 L（在 OA 中点）
      let mid_x = (ox + ax) / 2
      let mid_y = (oy + ay) / 2
      content(
        (mid_x, mid_y + 0.45),
        text(size: 10pt, weight: "bold")[ $L$ ],
      )

      // 直角标记（力 F 垂直于力臂 OA）
      let sq = 0.25
      let sq_dx = dx / mag * sq
      let sq_dy = dy / mag * sq
      let sq_px = perp_x * sq
      let sq_py = perp_y * sq
      line(
        (ax + sq_dx, ay + sq_dy),
        (ax + sq_dx + sq_px, ay + sq_dy + sq_py),
        (ax + sq_px, ay + sq_py),
        stroke: 0.8pt + black,
      )

      // 标题
      content((0, -2.5))[ #text(fill: caption-color)[(第 20 题)] ]
    })
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

    + *场景构建*：绘制水平杠杆（矩形横梁）、两个滚轮支点、地面斜线纹理、以及放置在杠杆右侧的竖直长方体。右侧支点标记为 O。
    + *最小力分析*：使杠杆绕 O 逆时针转动，力的作用点应选在离 O 最远处（杠杆左端 A），此时力臂 $L = |O A|$ 最长。最小力 $F$ 方向垂直于 $O A$ 连线。
    + *力臂绘制*：从支点 O 到作用点 A 画虚线段，标注为 $L$。在作用点 A 处画垂直于 $O A$ 的箭头表示最小力 $F$，并用直角符号标记 $F perp L$。
    + *垂直方向计算*：通过向量运算 `(-dy, dx) / |OA|` 求出垂直于 $O A$ 连线且产生逆时针力矩的单位方向，确保力的方向物理正确。
  ]
}
