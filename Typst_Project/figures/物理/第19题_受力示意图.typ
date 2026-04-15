// ============================================================
// 第19题 · 受力示意图（铅球空中运动 + 物体漂浮）
// 绘图 + 解答合并
// ============================================================

#import "@preview/cetz:0.4.2"

// ==========================================
// 输出：题目 + 解答
// ==========================================
#let render() = {
  // --- 题目 ---
  set par(first-line-indent: 0em)

  text(weight: "bold", size: 12pt, fill: rgb(90, 160, 210))[19.]
  text(size: 11pt)[（4 分）按要求作图。]

  v(0.5em)
  text(size: 11pt)[（1）请在图(a)中画出重为 50 N 的铅球在空中运动时，其所受重力的示意图。]

  v(0.5em)
  text(size: 11pt)[（2）如图(b)所示，重 20 N 的物体漂浮在水中，请作出物体所受力的示意图。]

  v(2.0em)

  // --- 绘图 ---
  align(center)[
    #cetz.canvas(length: 0.85cm, {
      import cetz.draw: *

      let caption-color = rgb(88, 166, 216)
      let water-color = rgb(198, 238, 255)
      let ball-color = rgb("#7ad3f0")

      // ================= 图 (a) 铅球空中运动 =================
      group(name: "a", {
        let cx = 0
        let cy = 0
        translate((cx, cy))

        // 仅绘制抛物线的左半部分及越过顶点的部分
        let r = 0.35 // 铅球半径

        // 轨迹：从左下向右上的抛物线段
        bezier(
          (-3.0, -1.0), // 起点
          (2.5, -0.2), // 终点（顶点的右侧）
          (-1.5, 1.5), // 左控制点
          (1.0, 1.5),  // 右控制点
          stroke: (paint: luma(120), thickness: 0.8pt, dash: "dashed"),
        )

        // 铅球置于抛物线轨迹的偏左上方
        let ball_x = -0.5
        let ball_y = 0.72 // 轨迹在 x=-0.5 出的粗略高度

        // 铅球
        circle((ball_x, ball_y), radius: r, fill: ball-color, stroke: 1.2pt + black)
        circle((ball_x, ball_y), radius: 0.05, fill: black) // 重心点

        // 受力分析：空中运动只受重力，竖直向下
        let l_g = 1.8 // 重力箭头长度
        line(
          (ball_x, ball_y),
          (ball_x, ball_y - l_g),
          mark: (end: "stealth", fill: black),
          stroke: 1.5pt + black,
        )
        content((ball_x + 1, ball_y - l_g + 0.2), text(size: 10pt)[ $G = 50 N$ ])

        // 标题
        content((0, -2.5))[ #text(fill: caption-color)[(a)] ]
      })

      // ================= 图 (b) 物体漂浮在水中（斜面上的烧杯） =================
      group(name: "b", {
        let cx = 8.0
        let cy = -0.5
        translate((cx, cy))

        // 1. 绘制斜劈（左高右低的直角三角形）
        let wedge_bl = (-2.5, -1.5) // 底面左端点
        let wedge_br = (2.5, -1.5)  // 底面右端点
        let wedge_tl = (-2.5, 0.5)  // 顶面左端点（垂直面）
        line(wedge_bl, wedge_br, wedge_tl, close: true, stroke: 1.2pt + black)
        
        // 计算斜面角度 alpha (弧度) 并转换为度数
        let dx = wedge_br.at(0) - wedge_tl.at(0) // 5.0
        let dy = wedge_tl.at(1) - wedge_br.at(1) // 2.0
        // 斜面角度，向下倾斜，约 21.8 度
        let a = -21.8deg

        // 将烧杯置于斜面上，中心在 x=0
        // y坐标：利用斜率计算，斜率 k = -2.0 / 5.0 = -0.4
        // 斜面线方程: y = -0.4 * (x - (-2.5)) + 0.5 = -0.4*x - 1.0 + 0.5 = -0.4*x - 0.5
        let center_y = -0.4 * 0 - 0.5 // -0.5
        let C = (0.0, center_y)

        // 烧杯尺寸
        let w = 2.4 // 烧杯底宽
        let h = 2.8 // 烧杯高度

        // 利用带有变换的 group 绘制烧杯底和外壁
        group({
          // 将坐标系移到 C 点，并随斜面旋转
          translate(C)
          rotate(a)
          // 烧杯底和侧壁
          line((-w/2, h), (-w/2, 0), (w/2, 0), (w/2, h), stroke: 1.5pt + black)
        })

        // 用三角函数计算烧杯 4 个角点在全局（未旋转）坐标系中的绝对坐标
        // 以便截断水面并填充水
        let cos_a = calc.cos(a)
        let sin_a = calc.sin(a)
        
        let bl = (C.at(0) - w/2 * cos_a, C.at(1) - w/2 * sin_a)
        let br = (C.at(0) + w/2 * cos_a, C.at(1) + w/2 * sin_a)
        let tl = (bl.at(0) - h * sin_a, bl.at(1) + h * cos_a)
        let tr = (br.at(0) - h * sin_a, br.at(1) + h * cos_a)

        // 水面是绝对水平的，设定水面高度 yw
        let yw = 1.0 // 绝对水面高度 y
        
        // 分别求左壁 (bl -> tl) 和右壁 (br -> tr) 与 y = yw 的交点
        // 两点式：(x - x1) / (x2 - x1) = (y - y1) / (y2 - y1)
        // x = x1 + (y - y1) / (y2 - y1) * (x2 - x1)
        let wl_x = bl.at(0) + (yw - bl.at(1)) / (tl.at(1) - bl.at(1)) * (tl.at(0) - bl.at(0))
        let wr_x = br.at(0) + (yw - br.at(1)) / (tr.at(1) - br.at(1)) * (tr.at(0) - br.at(0))

        // 填充水区域（多边形: 左水面端点 -> 底左 -> 底右 -> 右水面端点）
        line((wl_x, yw), bl, br, (wr_x, yw), close: true, fill: water-color, stroke: none)

        // 重绘水面线
        line((wl_x, yw), (wr_x, yw), stroke: 1pt + rgb(120, 180, 210))

        // 为了防止水填充遮盖边框，再重绘一次烧杯边框（绝对坐标下）
        line(tl, bl, br, tr, stroke: 1.5pt + black)

        // 漂浮物体（球体），部分浸在绝对水平面上
        // 浮体重心位置位于水平连线稍微向上
        let obj_x = 0.5 // 放置在水面偏中心位置
        let obj_r = 0.45
        let obj_y = yw + 0.1 // 水面上方露出一些
        circle((obj_x, obj_y), radius: obj_r, fill: ball-color, stroke: 1.2pt + black)
        circle((obj_x, obj_y), radius: 0.05, fill: black) // 重心点

        // 受力分析：漂浮，重力等于浮力，都处于竖直方向！（绝对不垂直于斜面）
        let l_f = 1.6

        // 重力 G 竖直向下
        line(
          (obj_x, obj_y),
          (obj_x, obj_y - l_f),
          mark: (end: "stealth", fill: black),
          stroke: 1.5pt + black,
        )
        content((obj_x + 1, obj_y - l_f + 0.2), text(size: 10pt)[ $G = 20 N$ ])

        // 浮力 F浮 竖直向上（从旁边留一点偏移量起笔，防止重叠）
        line(
          (obj_x, obj_y),
          (obj_x, obj_y + l_f),
          mark: (end: "stealth", fill: black),
          stroke: 1.5pt + black,
        )
        content((obj_x + 1.1, obj_y + l_f - 0.1), text(size: 10pt)[ $F_(upright("浮")) = 20 N$ ])

        // 标题
        content((0, -2.5))[ #text(fill: caption-color)[(b)] ]
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

    + *图(a) 铅球空中运动*：铅球离手后在空中运动。使用 `bezier` 绘制抛物线的左半部分及越过顶点的短暂下降段，将 `circle` 绘制的球体定位于上升阶段。忽略空气阻力，其绝对受力仅为竖直向下的重力。从重心向下画一条带箭头的竖直线段，标注 $G = 50 N$。
    + *图(b) 倾斜坡面上的漂浮受力*：绘制底面为水平的左高右低直角三角形斜劈，在斜劈上构造倾斜放置的烧杯（通过 `rotate` 及坐标变换处理）。容器中的水面不受斜面倾角影响，仍保持绝对方位的水平，并通过直线方程求解左侧壁和右侧壁截断点实现不规则浅蓝色多边形填充。
    + *漂浮二力平衡要素*：物体稳定漂浮在水面上，处于二力平衡状态。尽管盛水容器倾斜，但*重力和浮力的方向都是绝对的竖直方向*：重力 $G$ 竖直向下，浮力 $F_(upright("浮"))$ 竖直向上，二者等长且反向验证了 $G = F_(upright("浮")) = 20 N$ 的物理本质。
  ]
}
