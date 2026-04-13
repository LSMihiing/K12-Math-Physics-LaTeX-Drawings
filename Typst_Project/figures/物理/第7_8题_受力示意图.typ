// ============================================================
// 第7, 8题 · 受力示意图（圆周运动重力、悬挂小球拉力）
// 绘图 + 解答合并
// ============================================================

#import "@preview/cetz:0.4.2"

// ==========================================
// 输出：题目 + 解答
// ==========================================
#let render() = {
  // --- 题目 ---
  set par(first-line-indent: 0em)
  
  text(weight: "bold", size: 12pt, fill: rgb(90, 160, 210))[7. ]
  text(size: 11pt)[如图 7-6-3 所示，小明用一根细线拴住一块橡皮并甩起来，使橡皮绕手做圆周运动。请你在图中画出橡皮所受重力的示意图。]

  v(1.0em)
  
  text(weight: "bold", size: 12pt, fill: rgb(90, 160, 210))[8. ]
  text(size: 11pt)[如图 7-6-4 所示，悬挂的小球处于静止状态，画出它所受拉力的示意图。]

  v(2.0em)

  // --- 绘图 ---
  align(center)[
    #cetz.canvas(length: 0.9cm, {
      import cetz.draw: *
      let fill-color = rgb(124, 214, 245)
      let caption-color = rgb(88, 166, 216)

      // ==================== (1) 图 7-6-3 圆周运动 ====================
      group(name: "fig7", {
        let ox = 0.0
        let oy = 0.0

        let cx = ox + 4.0 // 椭圆中心
        let cy = oy + 2.5
        let rx = 3.2
        let ry = 0.8

        // 轨迹椭圆 (虚线)
        circle((cx, cy), radius: (rx, ry), stroke: (dash: "dashed", paint: luma(80)))
        
        // 运动方向箭头 (在最下方切线位置绘制一段极短的带箭头的实线)
        let ax = cx
        let ay = cy - ry
        line((ax - 0.05, ay), (ax + 0.15, ay), mark: (end: "stealth", fill: black), stroke: 1.0pt + black)

        // 橡皮(位于左端)
        let ex = cx - rx
        let ey = cy
        let ew = 0.2  // 横向半宽
        let eh = 0.45 // 纵向半高
        
        // 细线 (从橡皮到手中心)
        line((ex + ew, ey), (cx, ey), stroke: 1pt + black)
        // 中心垂直引下的线段
        line((cx, ey), (cx, cy - 0.2), stroke: 1pt + black)
        
        // 由于真实手部绘图可能过于繁杂引发歧义，此处利用简约几何形表示手的夹握与胳膊
        rect((cx - 0.25, cy - 0.5), (cx + 0.25, cy - 0.2), radius: 0.1, fill: white, stroke: 1pt + black)
        line((cx - 0.2, cy - 0.5), (cx - 0.35, cy - 1.8), stroke: 1pt + black)
        line((cx + 0.2, cy - 0.5), (cx + 0.15, cy - 1.8), stroke: 1pt + black)

        // 绘制橡皮自身 (为避免线条被线覆盖，放在上面重绘)
        rect(
          (ex - ew, ey - eh), 
          (ex + ew, ey + eh), 
          fill: fill-color, 
          stroke: 1pt + black
        )

        // 重力 G
        let g_len = 1.4
        // 质点圆心
        circle((ex, ey), radius: 0.06, fill: black)
        line((ex, ey), (ex, ey - g_len), mark: (end: "stealth", fill: black), stroke: 1.2pt + black)
        content((ex + 0.5, ey - g_len + 0.3))[ $G$ ]

        // 底部标题
        content((ox + 4.0, -1.0))[ #text(fill: caption-color)[图 7-6-3] ]
      })

      // ==================== (2) 图 7-6-4 悬挂小球 ====================
      group(name: "fig8", {
        let ox = 11.5
        let oy = 0.0

        // 天花板水平截面线与阴影 (45度斜线)
        let ceil_y = 3.5
        line((ox - 1.5, ceil_y), (ox + 1.5, ceil_y), stroke: 1pt + black)
        for i in range(13) {
          let x = ox - 1.3 + i * 0.2
          line((x, ceil_y), (x + 0.3, ceil_y + 0.3), stroke: 0.5pt + black)
        }

        let ball_y = 1.0
        let ball_r = 0.8

        // 悬挂细线
        line((ox, ceil_y), (ox, ball_y + ball_r), stroke: 1pt + black)

        // 小球实体
        circle((ox, ball_y), radius: ball_r, fill: fill-color, stroke: 1pt + black)
        // 几何中心圆点
        circle((ox, ball_y), radius: 0.06, fill: black)

        // 拉力 F
        let f_len = 1.6
        line((ox, ball_y), (ox, ball_y + f_len), mark: (end: "stealth", fill: black), stroke: 1.2pt + black)
        content((ox + 0.6, ball_y + f_len - 0.2))[ $F$ ]

        // 底部标题
        content((ox, -1.0))[ #text(fill: caption-color)[图 7-6-4] ]
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

    + *坐标及排版布局*：将图 7-6-3 与图 7-6-4 放于同一个画布的左右两侧（向右平移 `ox` 坐标系解决冲突），题号标题使用同原先一样的渐变深蓝色 `#5a82a0` 或一致的视觉主题色，图号标引采用相同的浅蓝色 `#58A6D8`。
    + *左侧 (图 7-6-3) 制图细节*：
      - *轨迹*：使用 `#circle` 方法赋予水平和垂直不相等的半径形成 `radius: (rx, ry)` 的椭圆底座，并加上 `dashed` 虚化笔触来表示水平面内的圆周轨迹；在最底端加入极短线段标注速度沿逆时针方向。
      - *手与物体*：由于人物真实手臂属于非规则多面体作画，此代码采用了视觉层级降维——利用圆角矩形及下方发散线段代理表示人手夹握姿态，既不失真又保持了物理作图的严谨性；在右侧椭圆端点绘制被拉拽的矩形橡皮块。
      - *重力*：在橡皮质量中心显式打入一个实心参考圆，然后直接竖直引向正下方的带箭头线段并配上 `$G$` 予以标识。
    + *右侧 (图 7-6-4) 制图细节*：
      - 利用 `for i in range(...)` 排列等距小短斜线（配合一条水平基准横线）生成标准力学题库中的天花板界面。
      - 画出带有中心点 `#circle(..., radius: 0.05, fill: black)` 的完全正圆小球和上端拉索。
      - 题目要求表述拉力大小方向，通过在同一支点向引线正上方延展出受力向量 `$F$`。
  ]
}
