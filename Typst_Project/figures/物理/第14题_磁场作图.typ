// ============================================================
// 第14题 · 磁场作图（磁感线、小磁针与磁极）
// 绘图 + 解答合并
// ============================================================

#import "@preview/cetz:0.4.2"

// ==========================================
// 输出：题目 + 解答
// ==========================================
#let render() = {
  // --- 题目 ---
  set par(first-line-indent: 0em)

  text(weight: "bold", size: 12pt, fill: rgb(90, 160, 210))[14.]
  text(size: 11pt)[根据下列要求完成作图。]

  v(0.5em)
  text(size: 11pt)[（1）请在图(a)、(b)中标出磁感线的方向和小磁针的 N、S 极（并将 N 极涂黑）。]

  v(0.5em)
  text(size: 11pt)[（2）根据图(c)、(d)中小磁针静止时所指的方向，画出通过小磁针中心的一条磁感线，并标出磁体的 N、S 极。]

  v(2.0em)

  // --- 绘图 ---
  align(center)[
    #cetz.canvas(length: 0.85cm, {
      import cetz.draw: *

      let caption-color = rgb(88, 166, 216)

      // 辅助函数：绘制小磁针
      let draw_comp(cx, cy, angle_deg, label_N) = {
        group({
          translate((cx, cy))
          group({
            rotate(angle_deg)
            let L = 0.35 // 菱形半长
            let W = 0.15 // 菱形半宽
            // N 极 (涂黑) 以原点为界，指向自身坐标系的正x方向
            line((0, W), (L, 0), (0, -W), close: true, fill: black, stroke: 0.6pt + black)
            // S 极 (留白)
            line((0, W), (-L, 0), (0, -W), close: true, fill: white, stroke: 0.6pt + black)
          })
          if label_N {
            // 文字不随之倾倒，根据角度置于外围
            let r_text = 0.55
            let nx = r_text * calc.cos(angle_deg)
            let ny = r_text * calc.sin(angle_deg)
            content((nx, ny), text(size: 9pt)[N])
            content((-nx, -ny), text(size: 9pt)[S])
          }
        })
      }

      // ================= 图 (a) =================
      group(name: "a", {
        let cx = 0
        let cy = 0
        translate((cx, cy))

        // 变量定点
        let w = 1.2 // 半磁极长度
        let h = 0.4 // 磁极半高度
        let line_w = 2.4 // 两侧长线延伸跨度

        // 条形磁铁
        rect((-w, -h), (0, h), fill: luma(180), stroke: 1pt + black)
        rect((0, -h), (w, h), fill: white, stroke: 1pt + black)
        content((-w / 2, 0), text(weight: "bold")[N])
        content((w / 2, 0), text(weight: "bold")[S])

        // 轴线上的射出和射入直线磁感线
        line((-w, 0), (-line_w, 0), stroke: 0.8pt + black)
        line((-w, 0), (-line_w + 0.8, 0), mark: (end: "stealth", fill: black), stroke: 0.8pt + black)

        line((line_w, 0), (w, 0), stroke: 0.8pt + black)
        line((line_w, 0), (w + 0.8, 0), mark: (end: "stealth", fill: black), stroke: 0.8pt + black)

        // 上下磁感线：打开的贝壳形 bezier 曲线
        // 起点/终点在侧面的上/下四分之一处: y = ±h/2 = ±0.2
        // 控制点 x=±3.0 使曲线左右顶点大幅超出磁体
        let qy = h / 2 // 侧面四分之一位置 = 0.2
        // 上方贝壳线: (-w, qy) → (w, qy)
        bezier((-w, qy), (w, qy), (-3.0, 1.4), (3.0, 1.4), stroke: 0.8pt + black)
        // 下方贝壳线: (-w, -qy) → (w, -qy)
        bezier((-w, -qy), (w, -qy), (-3.0, -1.4), (3.0, -1.4), stroke: 0.8pt + black)

        // 箭头指示器：在曲线约 1/3 处放置切线方向箭头
        line((-1.19, 0.96), (-0.89, 1.02), mark: (end: "stealth", fill: black), stroke: 0.8pt + black)
        line((-1.19, -0.96), (-0.89, -1.02), mark: (end: "stealth", fill: black), stroke: 0.8pt + black)

        // 上下配置的小磁针 (位于贝壳曲线顶/底点，y≈±1.1)
        draw_comp(0, 1.1, 0deg, true)
        draw_comp(0, -1.1, 0deg, true)

        content((0, -2.5))[ #text(fill: caption-color)[(a)] ]
      })

      // ================= 图 (b) =================
      group(name: "b", {
        let cx = 5.0
        let cy = 0
        translate((cx, cy))

        // 变量定点
        let gap = 2.4 // 再远一些
        let x_L = -gap / 2
        let x_R = gap / 2
        let mag_w = 1.0 // 直段截短
        let h = 0.4
        let z = 0.15
        let db_x = 0.25
        let Ry_up = 0.7
        let Ry_dn = 0.85

        let xl_base = x_L - mag_w
        let xr_base = x_R + mag_w

        // 分开放置的 N 极 (左) 和 S 极 (右)
        line(
          (xl_base, h),
          (x_L, h),
          (x_L, -h),
          (xl_base, -h),
          (xl_base - z, -h / 2),
          (xl_base + z, 0),
          (xl_base - z, h / 2),
          close: true,
          fill: luma(180),
          stroke: 1pt + black,
        )
        line(
          (xr_base, h),
          (x_R, h),
          (x_R, -h),
          (xr_base, -h),
          (xr_base + z, -h / 2),
          (xr_base - z, 0),
          (xr_base + z, h / 2),
          close: true,
          fill: white,
          stroke: 1pt + black,
        )

        content((x_L - mag_w / 2, 0), text(weight: "bold")[N])
        content((x_R + mag_w / 2, 0), text(weight: "bold")[S])

        // 中间磁感线
        line((x_L, 0), (x_R, 0), stroke: 0.8pt + black)
        line((x_L, 0), (-0.15, 0), mark: (end: "stealth", fill: black), stroke: 0.8pt + black)

        arc((x_L, db_x), start: 180deg, delta: -180deg, radius: (gap / 2, Ry_up), stroke: 0.8pt + black)
        arc(
          (x_L, db_x),
          start: 180deg,
          delta: -65deg,
          radius: (gap / 2, Ry_up),
          mark: (end: "stealth", fill: black),
          stroke: 0.8pt + black,
        )

        arc((x_L, -db_x), start: 180deg, delta: 180deg, radius: (gap / 2, Ry_dn), stroke: 0.8pt + black)
        arc(
          (x_L, -db_x),
          start: 180deg,
          delta: 65deg,
          radius: (gap / 2, Ry_dn),
          mark: (end: "stealth", fill: black),
          stroke: 0.8pt + black,
        )

        // 底部小磁针
        draw_comp(0, -db_x - Ry_dn, 0deg, true)

        content((0, -2.5))[ #text(fill: caption-color)[(b)] ]
      })

      // ================= 图 (c) =================
      group(name: "c", {
        let cx = 10.0
        let cy = -0.4
        translate((cx, cy))

        // 变形点：U型磁铁再细一点(厚度减小)，两边再宽一点(内径增大)
        let R_outer = 1.2
        let R_inner = 0.8
        let mid_x = (R_outer + R_inner) / 2
        let arm_h = 1.5 // 两臂高度
        let comp_y = 2.2 // 磁针悬空y坐标
        let arc_ry = comp_y - arm_h // 动态垂直偏心

        // 左右U形臂
        line((-R_outer, arm_h), (-R_outer, 0), stroke: 1.2pt + black)
        line((-R_inner, arm_h), (-R_inner, 0), stroke: 1.2pt + black)
        line((-R_outer, arm_h), (-R_inner, arm_h), stroke: 1.2pt + black)

        line((R_outer, arm_h), (R_outer, 0), stroke: 1.2pt + black)
        line((R_inner, arm_h), (R_inner, 0), stroke: 1.2pt + black)
        line((R_outer, arm_h), (R_inner, arm_h), stroke: 1.2pt + black)

        // U形底部双弧线
        arc((-R_outer, 0), start: 180deg, stop: 360deg, radius: R_outer, stroke: 1.2pt + black)
        arc((-R_inner, 0), start: 180deg, stop: 360deg, radius: R_inner, stroke: 1.2pt + black)

        content((-mid_x, 1.0), text(weight: "bold")[N])
        content((mid_x, 1.0), text(weight: "bold")[S])

        // 放置指示磁针
        draw_comp(0, comp_y, 0deg, true)

        // 椭圆曲线磁感线
        arc((-mid_x, arm_h), start: 180deg, delta: -180deg, radius: (mid_x, arc_ry), stroke: 0.8pt + black)
        arc(
          (-mid_x, arm_h),
          start: 180deg,
          delta: -65deg,
          radius: (mid_x, arc_ry),
          mark: (end: "stealth", fill: black),
          stroke: 0.8pt + black,
        )

        content((0, -2.1))[ #text(fill: caption-color)[(c)] ]
      })

      // ================= 图 (d) =================
      group(name: "d", {
        let cx = 15.0
        let cy = 0
        translate((cx, cy))

        let g_w = 1.2 // 两极内壁到中轴的间距
        let bl = 2.4 // 长臂横向尾部延展
        let h = 0.4 // 磁极半高度

        // 算出能让椭圆严格穿过当前 0.7, 1.0 的纵轴半径：
        // 式子为 1.0^2 / y^2 + 0.7^2 / 1.2^2 = 1.0
        let ry = 1.23

        // 面向式双直切磁臂
        line((-bl, h), (-g_w, h), (-g_w, -h), (-bl, -h), stroke: 1.2pt + black)
        content((-(bl + g_w) / 2, 0), text(weight: "bold")[S])

        line((bl, h), (g_w, h), (g_w, -h), (bl, -h), stroke: 1.2pt + black)
        content(((bl + g_w) / 2, 0), text(weight: "bold")[N])

        // 放置偏转磁针 (原样保留新修订的 120deg)
        draw_comp(0.7, 1, 145deg, true)

        // 自然光滑的非整椭圆连线
        arc((g_w, 0), start: 0deg, delta: 180deg, radius: (g_w, ry), stroke: 0.8pt + black)
        arc(
          (g_w, 0),
          start: 0deg,
          delta: 110deg,
          radius: (g_w, ry),
          mark: (end: "stealth", fill: black),
          stroke: 0.8pt + black,
        )

        content((0, -2.5))[ #text(fill: caption-color)[(d)] ]
      })
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

    + *构建小磁针绘制宏*：创建含复用参量（位置、旋转角）的小磁针函数，依定义描绘画出两半分离的菱体将一半涂黑作N极，运用三角方程 `cos`, `sin` 使标记字母独立置于旋转后尖端外围以免文字随之发生颠倒。
    + *磁感线与同源受力标定 (a)(b)*：磁体外围感应场自 N 极溢出并收敛于 S 极，上下圈出圆弧加注向右箭头。在标示箭头的同时将布置在各线切点处的微小验磁器同步设置 N 极朝右与场力线走向高度一致。
    + *逆向推断与抛物线过点追踪 (c)*：原配图中 U 型外置仪指针水平指向右方，反推得知所处位置区域场力相切向右，进而在左右端面上确定了引出的左(N)、引回的右(S)两极。解设一阶控制点二次贝塞尔使得模拟圆弧波谷精准穿插小针质心。
    + *非稳空间畸变场连通 (d)*：由于测针静止于水平夹角达 $150^degree$（偏向左上方）之奇特角度，说明局部分散场存在剧烈曲率扭曲。确定了左 S、右 N 之后，拼合两段具备几何连续性的一阶导受控三阶贝塞尔线段 `bezier` 强制跨越中心强迫角并完美接入两侧对向臂边界重塑异极互向散流全貌。
  ]
}
