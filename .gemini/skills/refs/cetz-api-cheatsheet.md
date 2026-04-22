# CeTZ 0.4.2 API 速查 & 常见坑

## 核心绘图函数

### line()
```typst
line((x1,y1), (x2,y2), ..., 
  close: true,                    // 封闭多边形
  stroke: 1pt + black,
  fill: rgb("#DBEAFE"),
  mark: (end: "stealth", fill: black, size: 0.25),  // 力的箭头
)
```

### rect()
```typst
rect((x1,y1), (x2,y2), 
  fill: luma(220), 
  stroke: 1pt + black,
)
```

### circle()
```typst
circle((x,y), radius: 2pt, fill: black, stroke: none)  // 实心端点
circle((x,y), radius: 0.08, fill: white, stroke: 1.5pt + blue)  // 空心圆（开区间）
```

### arc() — 最复杂，坑最多

```typst
// 方式1: 以第一个参数为圆心（推荐！）
arc(center_point, 
  start: 45deg, stop: 135deg,   // 或用 delta: 90deg
  radius: 2.8,
  anchor: "origin",             // ⚠️ 关键！让第一个参数作为圆心
  stroke: (paint: blue, thickness: 0.6pt, dash: "dashed"),
)

// 方式2: 扇形填充（饼图用）
arc(start_point,
  start: 0deg, stop: 90deg,
  radius: r,
  mode: "PIE",                  // ⚠️ 扇形模式，自动连接圆心
  fill: color,
  stroke: 1pt + black,
)
```

> **⚠️ 关键坑：`arc()` 默认第一个参数是弧的起始点，不是圆心！**
> - 要让它作为圆心，必须加 `anchor: "origin"`
> - 或者手动计算起始点：`start_point = (cx + r*cos(start_angle), cy + r*sin(start_angle))`
> - `mode: "PIE"` 时第一个参数是弧起始点（不是圆心），它会自动画连接线到圆心

### content()
```typst
content((x,y), anchor: "south-west", padding: 3pt, 
  text(size: 10pt, fill: red, weight: "bold")[$A$]
)
```
- anchor 可选: north, south, east, west, north-east, north-west, south-east, south-west, center

### group()
```typst
group(name: "sub-figure", {
  // 内部代码有独立的命名空间
  // 用于隔离多个子图（如甲/乙/丙），避免坐标冲突
})
```

### merge-path()
```typst
// 填充复杂区域（非简单多边形）
merge-path(fill: rgb("E63946").lighten(85%), stroke: none, {
  line(pt-A, pt-B, pt-C, pt-D, close: true)
})
```

### grid() — CeTZ 内置网格
```typst
grid((0,0), (12,8), 
  stroke: (paint: luma(180), dash: "dashed", thickness: 0.5pt)
)
```

---

## 角度计算

```typst
// 计算从点 A 到点 B 的方向角
let angle = calc.atan2(B.at(0) - A.at(0), B.at(1) - A.at(1))

// ⚠️ typst 的 atan2(x, y) 参数顺序是 (x, y)，不是 (y, x)
```

---

## Stroke 样式速查

```typst
// 实线
0.8pt + black

// 虚线
(paint: blue, thickness: 0.6pt, dash: "dashed")

// 点线
(paint: gray, dash: "dotted")

// 自定义虚线间距
(paint: color, thickness: 0.8pt, dash: (2.5pt, 2pt))
```

---

## 颜色系统

| 用途 | 推荐颜色 |
|------|----------|
| 原题图形 | `black`, `0.8pt + black` |
| 解答/答案部分 | `rgb(31, 120, 180)` 蓝色系, `rgb("#2563EB")` |
| 答案高亮（红色系） | `rgb("#DC2626")`, `rgb("#E63946")` |
| 作图痕迹 | `rgb("#2563EB")` 蓝色虚线 |
| 辅助线 | `luma(120)` ~ `luma(160)`, 虚线 |
| 网格线 | `luma(180)` ~ `luma(200)` |
| 浅色填充 | `.lighten(85%)`, `.transparentize(50%)`, `rgb("#DBEAFE")`, `rgb("#FEE2E2")` |
| 解答块背景 | `rgb(245, 250, 255)` |
| 绘图原理块背景 | `luma(248)` |

---

## 常见错误和解决方案

### 1. arc 画出位置不对
原因：没加 `anchor: "origin"`，导致第一个参数被当作弧起点而非圆心。

### 2. 负号变连字符
```typst
// ❌ 负号显示为连字符
content((x,y))[#text[-3]]

// ✅ 使用数学模式或手动处理
let label-text = if i < 0 { [$-$#calc.abs(i)] } else { str(i) }
```

### 3. 多子图坐标冲突
用 `group(name: "...", { ... })` 将每个子图包裹，避免命名冲突。

### 4. 文字标签遮挡图形
使用 `dot-label()` 工具函数，通过 `dir` 参数控制标签相对于点的方位。
