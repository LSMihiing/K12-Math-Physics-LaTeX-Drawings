# 几何题绘图模式参考

## 一、尺规作图

### 核心技巧

尺规作图的关键在于用 `arc()` 绘制圆规痕迹，需要精确控制圆心和角度范围。

### 公共样式定义

```typst
#let main-stroke = 0.8pt + black                    // 原题线段
#let arc-stroke = (paint: rgb("#2563EB"), thickness: 0.6pt, dash: "dashed")  // 圆规痕迹
#let answer-stroke = 1pt + rgb("#DC2626")            // 答案线
#let dot-radius = 1.8pt                              // 端点圆点
```

### 圆规弧的标准画法

```typst
// 以 A 为圆心，r 为半径画弧
// anchor: "origin" 让 A 作为圆心
arc(A, start: start_angle - 8deg, stop: stop_angle + 8deg, 
    radius: r, stroke: arc-stroke, anchor: "origin")

// 角度计算：A 到目标点 P 的方向角
let angle = calc.atan2(P.at(0) - A.at(0), P.at(1) - A.at(1))
```

### 短切痕（交点处的实线弧）

```typst
// 在交点 D 附近画一段短实线弧（±4deg 范围）
let angle-D = calc.atan2(D.at(0) - C.at(0), D.at(1) - C.at(1))
arc(C, start: angle-D - 4deg, stop: angle-D + 4deg, 
    radius: r, stroke: 1.2pt + mark-color, anchor: "origin")
```

### 直角标记函数

```typst
#let draw-right-angle(foot, d1, d2, s: 0.25) = {
  import cetz.draw: *
  let (fx, fy) = foot
  let p1 = (fx + d1.at(0) * s, fy + d1.at(1) * s)
  let p2 = (fx + d1.at(0) * s + d2.at(0) * s, fy + d1.at(1) * s + d2.at(1) * s)
  let p3 = (fx + d2.at(0) * s, fy + d2.at(1) * s)
  line(p1, p2, p3, stroke: 0.5pt + black)
}

// 使用：draw-right-angle(H, (1,0), (0,1))  // 水平+竖直方向
// 使用：draw-right-angle(H, (bc-ux, bc-uy), (n-ax, n-ay))  // 任意方向
```

### 典型作图流程：垂直平分线

1. 计算弧半径 `r > AB/2`
2. 计算两弧交点 M, N：`y = ±sqrt(r² - (AB/2)²)`
3. 以 A 为圆心画弧（角度范围覆盖 M、N，稍扩大 ±8deg）
4. 以 B 为圆心画弧（同理）
5. 连接 M、N 得红色答案线
6. 在中点处画直角标记

### 典型作图流程：角平分线

1. 以角顶点 A 为圆心，半径 r1 画弧交两边于 P1、P2
2. 以 P1、P2 为圆心，半径 r2 画弧交于 Q
3. AQ 即为角平分线

---

## 二、网格几何变换

### 方格纸绘制

```typst
// 使用工具库
#import "../../lib/grid-utils.typ": draw-grid, dot-label
draw-grid(origin: (0,0), cols: 16, rows: 14, step: 1, 
          line-color: luma(190), line-width: 0.3pt)

// 或使用 CeTZ 内置 grid（虚线网格）
grid((0,0), (12,8), stroke: (paint: luma(180), dash: "dashed", thickness: 0.5pt))
```

### 旋转变换（顺时针 90°）

```typst
// 公式：(x,y) → (cx + (y-cy), cy - (x-cx))
#let rotate-cw90(pt, center) = {
  let cx = center.at(0)
  let cy = center.at(1)
  (cx + (pt.at(1) - cy), cy - (pt.at(0) - cx))
}
```

### 中心对称

```typst
// 公式：P' = 2*O - P
let pt-A1 = (2 * O.at(0) - A.at(0), 2 * O.at(1) - A.at(1))
```

### 平移变换

```typst
// 每个顶点 (x,y) → (x+dx, y+dy)
#let ptA1 = (ptA.at(0) + 2, ptA.at(1) + 1)
```

### 辅助箭头（连接变换前后对应点）

```typst
line(ptA, ptA1, 
  stroke: (paint: luma(120), thickness: 0.5pt, dash: "dashed"), 
  mark: (end: "stealth", fill: luma(120)))
```

### 颜色区分

- 原图：`0.8pt + black`
- 平移后：`1pt + rgb("#2563EB")`，半透明填充 `rgb("#DBEAFE").transparentize(50%)`
- 旋转后：`1pt + rgb("#DC2626")`，半透明填充 `rgb("#FEE2E2").transparentize(50%)`
- 顶点标记：1.5pt 实心圆，颜色与所属三角形一致

---

## 三、分数涂色

### 圆形等分与扇形填充

```typst
// 四等分：画十字虚线
line((cx - r, cy), (cx + r, cy), stroke: grid-dash)
line((cx, cy - r), (cx, cy + r), stroke: grid-dash)

// 涂色 1/4（左上象限 90°~180°）
let start-pt = (cx + r * calc.cos(90deg), cy + r * calc.sin(90deg))
arc(start-pt, start: 90deg, stop: 180deg, radius: r, mode: "PIE", fill: fill-color, stroke: none)

// 最后画外框
circle((cx, cy), radius: r, stroke: grid-stroke)
```

### 三角形中位线分割（六等分）

```typst
// 三条中位线
line(a, bc_mid, stroke: grid-dash)
line(b, ac_mid, stroke: grid-dash)
line(c, ab_mid, stroke: grid-dash)

// 涂色某份（用 line + close: true + fill）
let o = (cx, cy)  // 重心
line(o, a, ac_mid, close: true, fill: fill-color, stroke: none)
```

### 九宫格矩形填充

```typst
let third = w / 3
// 填涂 5/9：顶行满 + 中行两格
rect((dx, dy + 2*third), (dx + w, dy + w), fill: fill-color, stroke: none)
rect((dx, dy + third), (dx + 2*third, dy + 2*third), fill: fill-color, stroke: none)
// 外框
rect((dx, dy), (dx + w, dy + w), stroke: grid-stroke)
```

### 多图并排布局

```typst
// 使用 grid 并排
grid(
  columns: 3,
  column-gutter: 2.5em,
  figure-1, figure-2, figure-3,
)

// 分数和比较符标注
content((1.5, y-txt), [#text(size: 14pt)[$frac(1, 4)$]])
circle((3.5, y-txt), radius: 0.5, stroke: 0.8pt + luma(100))  // 比较符圆圈
content((3.5, y-txt), [#text(size: 13pt)[$>$]])
```
