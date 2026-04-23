# 贡献指南

## 环境准备

```bash
# 1. 克隆仓库
git clone https://github.com/LSMihiing/K12-Math-Physics-LaTeX-Drawings.git
cd K12-Math-Physics-LaTeX-Drawings

# 2. 安装 Typst（编译 .typ 文件）
winget install Typst.Typst
# 或 https://github.com/typst/typst/releases

# 3. 编译验证
cd Typst_Project
typst compile main.typ output/main.pdf --root .
```

## 添加新绘图

### 1. 创建功能分支

```bash
git checkout main && git pull origin main
git checkout -b feat/分类-简短描述
# 例：git checkout -b feat/几何-圆的周长
```

### 2. 新建绘图文件

在 `Typst_Project/figures/{分类}/` 下新建 `.typ` 文件：

```typst
// 圆的周长.typ
#import "@preview/cetz:0.4.2"

#let render() = {
  // 题目
  set par(first-line-indent: 0em)
  text(weight: "bold", size: 12pt)[1. 题目内容]
  v(1em)

  // 绘图
  align(center)[
    #cetz.canvas(length: 1cm, {
      import cetz.draw: *
      // 绘图代码
    })
  ]
}
```

**文件命名**：纯描述性中文，不带题号（如 `圆的周长.typ`、`三角形画高.typ`）。

### 3. 注册到章节聚合文件

编辑对应分类的 `_chapter.typ`，追加两处：

```typst
// 文件顶部追加 import
#import "圆的周长.typ" as _圆的周长

// 对应章节追加 render
=== 圆的周长
#_圆的周长.render()
#sep()
```

### 4. 编译 & 提交

```bash
cd Typst_Project
typst compile main.typ output/main.pdf --root .

git add -A
git commit -m "feat: 新增圆的周长绘图"
git push origin feat/几何-圆的周长
```

### 5. 创建 Pull Request

在 GitHub 仓库页面创建 PR，等待 review 后合并到 `main`。

## 项目结构

```
Typst_Project/
  main.typ              ← 全局样式（一般不需要修改）
  lib/styles.typ         ← 公共工具函数
  figures/
    几何作图/
      _chapter.typ       ← 聚合文件（import + heading + render）
      各绘图文件.typ
    统计图表/
      _chapter.typ
      ...
    线段图/
    物理/
    附录_物理第三册_电磁/
```

**关键原则**：添加新绘图只需修改 2 个文件 — 新的 `.typ` + 对应 `_chapter.typ`。

## 绘图规范

### 文件结构

每个绘图文件导出一个 `render()` 函数，包含：
1. **题目文字**（`text(weight: "bold")`）
2. **CeTZ 绘图**（`cetz.canvas` 居中）
3. **绘图原理**（可选，`block` 注释框）

### 参考资源

- **AI 绘图提示词**：`Typst_Project/typst绘图AI提示词.md`
- **LaTeX 参考案例**：`LaTeX_Project/数学/` 和 `LaTeX_Project/物理/` 下有 315 个成熟 TikZ 案例
- **外部教材参考**：`LaTeX_Project/附录_参考绘图/` 含 1155 张 TikZ 参考图

## 分支命名

```
feat/分类-描述     新增绘图
fix/分类-描述      修复已有绘图
docs/描述          文档更新
```

## 注意事项

- 不要直接在 `main` 分支上提交代码
- 编译通过后再提交（`typst compile main.typ output/main.pdf --root .`）
- 中文文件名、UTF-8 编码
- `output/` 目录已被 `.gitignore` 忽略，不会提交 PDF
