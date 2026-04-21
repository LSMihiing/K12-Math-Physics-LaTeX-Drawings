// ============================================================
// 受力示意图（斜面上烧杯中浮球的浮力）
// 绘图 + 解答合并
// ============================================================

#import "@preview/cetz:0.4.2"

// ==========================================
// 输出：题目 + 解答
// ==========================================
#let render() = {
  // --- 题目 ---
  set par(first-line-indent: 0em)

  text(weight: "bold", size: 12pt, fill: rgb(90, 160, 210))[4.]
  text(
    size: 11pt,
  )[如图 9-7-2 所示，把装有一定量水的烧杯放在斜面上，再把乒乓球放入水中，松手后乒乓球漂浮在水面上。请画出乒乓球所受浮力的示意图。]

  v(2.0em)

  // --- 绘图 ---
  align(center)[
    #cetz.canvas(length: 1cm, {
      import cetz.draw: *

      let caption-color = rgb(88, 166, 216)
      let water-color = rgb(198, 238, 255) // 参考图中的浅蓝色
      let ball-color = rgb(124, 214, 245) // 参考图中的深蓝色

      let H = 3.0
      let W = 5.196
      let A = (0, H)
      let B = (W, 0)
      let C = (0, 0)

      // 绘制斜面三角形
      line(C, B, A, close: true, stroke: 1.5pt + black)

      let theta = 30deg
      let m = calc.tan(theta) // ~0.57735

      // 定位烧杯在斜面上的位置
      let d = 2.6 // 沿斜面向下平移距离
      let origin_x = d * calc.cos(-theta)
      let origin_y = H + d * calc.sin(-theta)

      group(name: "beaker", {
        translate((origin_x, origin_y))
        rotate(-theta)

        // --- 局部坐标系 ---
        // x轴沿斜面向下，y轴垂直斜面向上
        let bx1 = -1.2
        let bx2 = 1.2
        let tx1 = -1.2
        let tx2 = 1.2
        let h = 3.2

        // 烧杯壁计算 (直壁)
        let k = 0.0 // 直璧，斜率为0
        let yw = 1.4 // 中心处水面高度

        // Water line intercept in local coords: y = yw + m*x
        // Right edge intersection: y_R = yw + m*(1.2 + k*y_R) => y_R = (yw + 1.2m) / (1 - m*k)
        let y_R = (yw + 1.2 * m) / (1 - m * k)
        let x_R = 1.2 + k * y_R

        // Left edge intersection: y_L = yw + m*(-1.2 - k*y_L) => y_L = (yw - 1.2m) / (1 + m*k)
        let y_L = (yw - 1.2 * m) / (1 + m * k)
        let x_L = -1.2 - k * y_L

        // 1. 填充水区域
        line((bx1, 0), (bx2, 0), (x_R, y_R), (x_L, y_L), close: true, fill: water-color, stroke: none)

        // 2. 绘制水面线条
        line((x_L, y_L), (x_R, y_R), stroke: 1pt + rgb(120, 180, 210))

        // 3. 绘制烧杯外框
        line((bx1, 0), (bx2, 0), stroke: 1.5pt + black) // 底边
        line((bx2, 0), (tx2, h), stroke: 1.5pt + black) // 右侧边
        line((bx1, 0), (tx1, h), (tx1 - 0.2, h + 0.1), (tx1 - 0.05, h + 0.05), stroke: 1.5pt + black) // 左侧边含倾倒嘴

        // 4. 计算小球位置并绘制
        let cx = 0.2
        let cy = yw + m * cx // 保持球心在水面上
        circle((cx, cy), radius: 0.45, fill: ball-color, stroke: 1.2pt + black)
        circle((cx, cy), radius: 0.05, fill: black) // 重心/浮心

        // 5. 浮力示意图 (方向要求全局竖直向上)
        // 局部坐标下，全局向上对应角度为 90deg + theta (120deg)
        let f_len = 2.4
        let f_angle = 90deg + theta
        let f_vx = f_len * calc.cos(f_angle)
        let f_vy = f_len * calc.sin(f_angle)

        line((cx, cy), (cx + f_vx, cy + f_vy), mark: (end: "stealth", fill: black), stroke: 1.5pt + black)
        content((cx + f_vx + 0.4, cy + f_vy), [ $F_("浮")$ ])
      })

      // 底部标题
      content((W / 2, -1.0))[ #text(fill: caption-color)[图 9-7-2] ]
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

    + *坐标及排版布局*：利用 CeTZ 建立全局坐标系，先绘制固定角度（设定为 $30^degree$）的直角三角形作为斜面基础。
    + *局部坐标系旋转*：使用 `group` 配合 `translate` 与 `rotate`，将坐标系原点平移至斜面斜边上的某点并旋转 $-30^degree$，使得在局部坐标系内，可以用常规方式相对对称地绘制倾斜的烧杯结构。
    + *水面交点精确计算*：由于水面在全局空间呈现绝对水平，而在旋转了 $-30^degree$ 的烧杯局部坐标系下，它表现为一条倾斜直线 $y = y_w + (\\tan 30^degree)x$。通过求解该直线与烧杯左右两侧壁（截距式线性方程）的精确交点，利用 `poly` 准确填充水的多边形区域，确保图示中水平面完全水平。
    + *浮力矢量绘制*：依据物理定律，浮力的方向始终保持竖直向上不受外桶倾斜影响。在局部旋转的坐标系中，计算竖直向上的对应角度为 $90^degree + 30^degree = 120^degree$。求得向量终点坐标偏移后，自重心处画出指向竖直向上的带箭头线段并标注符号 $F_("浮")$，实现精确作图。
  ]
}
