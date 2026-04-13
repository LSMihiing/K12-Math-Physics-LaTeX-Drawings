// ============================================================
// 第10, 11题 · 受力示意图（小车拉力、斜面物块重力）
// 绘图 + 解答合并
// ============================================================

#import "@preview/cetz:0.4.2"

// ==========================================
// 输出：题目 + 解答
// ==========================================
#let render() = {
  // --- 题目 ---
  set par(first-line-indent: 0em)

  text(weight: "bold", size: 12pt, fill: rgb(90, 160, 210))[10.]
  text(
    size: 11pt,
  )[如图 7-3-3 所示，重 $30 upright("N")$ 的小车，受到一个大小为 $50 upright("N")$ 的拉力。这个拉力作用于 $A$ 点且与水平面成 $30^degree$ 角斜向右上方。画出小车受到的拉力和重力的示意图。]

  v(0.5em)

  // 插图并排留空，图与文字也可以紧接着，这里我们放最后统排。

  text(weight: "bold", size: 12pt, fill: rgb(90, 160, 210))[11.]
  text(size: 11pt)[如图 7-3-4 所示，重 $10 upright("N")$ 的物体 $A$ 沿斜面匀速上滑。画出物体 $A$ 所受重力的示意图。]

  v(1.5em)

  // --- 绘图 ---
  align(center)[
    #cetz.canvas(length: 0.9cm, {
      import cetz.draw: *
      let fill-color = rgb(124, 214, 245) // 物块浅蓝填充
      let caption-color = rgb(88, 166, 216) // 图注浅蓝色

      // ==================== (1) 图 7-3-3 小车 ====================
      group(name: "fig10", {
        let ox = 0.0
        let oy = 0.0

        // 地面及其阴影
        line((ox - 0.5, oy), (ox + 4.5, oy), stroke: 1pt + black)
        for i in range(19) {
          let x = ox - 0.4 + i * 0.25
          line((x, oy), (x - 0.2, oy - 0.2), stroke: 0.5pt + black)
        }

        // 两个车轮
        circle((ox + 0.8, oy + 0.3), radius: 0.3, stroke: 1pt + black, fill: white)
        circle((ox + 3.2, oy + 0.3), radius: 0.3, stroke: 1pt + black, fill: white)
        circle((ox + 0.8, oy + 0.3), radius: 0.06, fill: black)
        circle((ox + 3.2, oy + 0.3), radius: 0.06, fill: black)

        // 车身矩形 (紧贴车轮)
        line(
          (ox + 0.0, oy + 0.6),
          (ox + 4.0, oy + 0.6),
          (ox + 4.0, oy + 2.2),
          (ox + 0.0, oy + 2.2),
          close: true,
          stroke: 1pt + black,
          fill: white,
        )

        // A 点
        let ax = ox + 4.0
        let ay = oy + 1.2
        circle((ax, ay), radius: 0.06, fill: black)
        content((ax + 0.3, ay - 0.2))[ $A$ ]

        // 小车的重心 (近似矩形几何中心)
        let cx = ox + 2.0
        let cy = oy + 1.4

        // 重力 G
        let g_len = 1.2
        circle((cx, cy), radius: 0.06, fill: black)
        line((cx, cy), (cx, cy - g_len), mark: (end: "stealth", fill: black), stroke: 1.2pt + black)
        content((cx + 1, cy - g_len + 0.6))[ $G = 30 upright("N")$ ]

        // 拉力 F (大小按照 50N : 30N = 5:3 比例缩放)
        let f_len = g_len * (50 / 30)
        let cos30 = calc.cos(30deg)
        let sin30 = calc.sin(30deg)
        let fx = ax + f_len * cos30
        let fy = ay + f_len * sin30
        line((ax, ay), (fx, fy), mark: (end: "stealth", fill: black), stroke: 1.2pt + black)
        content((fx + 0.2, fy + 0.3))[ $F = 50 upright("N")$ ]

        // 水平辅助点划线线与角度
        line((ax, ay), (ax + 1.5, ay), stroke: (dash: "dashed", paint: black))

        let r = 0.6
        for i in range(15) {
          let a1 = i * 2deg
          let a2 = (i + 1) * 2deg
          let x1 = ax + r * calc.cos(a1)
          let y1 = ay + r * calc.sin(a1)
          let x2 = ax + r * calc.cos(a2)
          let y2 = ay + r * calc.sin(a2)
          line((x1, y1), (x2, y2), stroke: 0.6pt + black)
        }
        content((ax + 0.9, ay + 0.2))[ $30^degree$ ]

        // 底部标题
        content((ox + 2.0, -1.0))[ #text(fill: caption-color)[图 7-3-3] ]
      })

      // ==================== (2) 图 7-3-4 斜面物块 ====================
      group(name: "fig11", {
        let ox = 8.0
        let oy = 0.0

        let H_x = 5.0
        let H_y = 2.5

        // 拉伸出的斜面三角形
        let pt0 = (ox, oy)
        let pt1 = (ox + H_x, oy)
        let pt2 = (ox + H_x, oy + H_y)

        // 绘制斜面底座
        line(pt0, pt1, pt2, close: true, stroke: 1pt + black)

        // 计算斜面基向量 (平行和垂直方向)
        let L = calc.sqrt(H_x * H_x + H_y * H_y)
        let ux = H_x / L
        let uy = H_y / L
        let nx = -uy
        let ny = ux

        // 物块中心沿斜边的具体位置
        let p_along = 2.4
        // 斜面上的点作为参考底端中心
        let p_x = ox + p_along * ux
        let p_y = oy + p_along * uy

        // 物块长宽尺寸
        let w = 0.7 // 宽度的一半
        let h = 0.9 // 高度

        // 真正的重心点 (在法向方向上位移半个高)
        let c_x = p_x + (h / 2) * nx
        let c_y = p_y + (h / 2) * ny

        // 生成矩形四个角坐标
        let bl_x = p_x - w * ux
        let bl_y = p_y - w * uy
        let br_x = p_x + w * ux
        let br_y = p_y + w * uy
        let tr_x = br_x + h * nx
        let tr_y = br_y + h * ny
        let tl_x = bl_x + h * nx
        let tl_y = bl_y + h * ny

        // 绘制物块
        line(
          (bl_x, bl_y),
          (br_x, br_y),
          (tr_x, tr_y),
          (tl_x, tl_y),
          close: true,
          fill: fill-color,
          stroke: 1pt + black,
        )

        // 物块上中心A字
        content((c_x, c_y))[A]

        // 速度矢量 v (在物块正上方)
        let v_base_x = c_x + (h / 2 + 0.2) * nx
        let v_base_y = c_y + (h / 2 + 0.2) * ny
        line(
          (v_base_x, v_base_y),
          (v_base_x + 1.2 * ux, v_base_y + 1.2 * uy),
          mark: (end: "stealth", fill: black),
          stroke: 0.6pt + black,
        )
        content((v_base_x + 1.2 * ux + 0.15, v_base_y + 1.2 * uy + 0.15))[ $v$ ]

        // 重力 G
        let g_len_11 = 1.3
        line((c_x, c_y), (c_x, c_y - g_len_11), mark: (end: "stealth", fill: black), stroke: 1.2pt + black)
        content((c_x + 1.3, c_y - g_len_11 + 0.3))[ $G = 10 upright("N")$ ]

        // 底部标题
        content((ox + 2.5, -1.0))[ #text(fill: caption-color)[图 7-3-4] ]
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

    + *坐标及排版*：将图 7-3-3 和图 7-3-4 在同一个画布中左右平移绘制，偏移量分别设定为 `ox=0` 和 `ox=8.0`。对原图题目标签，通过直接映射RGB色值保持一致的浅蓝风格。
    + *模型特征实现*：第10题通过正交几何和圆构建带摩擦下划线的地面与双轮小车，利用车身矩形构建车体积；第11题通过向量投影 (`ux, uy` 代表沿斜面方向的正交向量) 以及三角形比例关系，构建并翻转出处于斜面上并填充浅蓝色的矩形物块。
    + *力学比例与矢量控制*：本题中含有精确受力比例。小车受 $30$ N重力与 $50$ N拉力，代码将拉力箭头标量进行 $5/3$ 系数倍乘拉伸；另外严格保证拉力作用点起始于所标记的 $A$ 点表面，而重力起始于物块内部形心（矩形的交叉几何中心）。
    + *角度与标注*：利用 `$30^degree$` 控制角度表示。鉴于角度圆弧平滑性，利用离散细分割循环 `for i in range(...)` 绘制角度圆弧，防止图形计算错位，添加辅助参考虚线。
  ]
}
