// ============================================================
// grid-utils.js — 方格纸绘图工具
// 对标 Typst grid-utils.typ
// ============================================================

/**
 * 在 Canvas 上绘制方格纸
 * @param {CanvasRenderingContext2D} ctx - Canvas 上下文
 * @param {Object} options
 * @param {number} options.originX - 网格起点 X（像素）
 * @param {number} options.originY - 网格起点 Y（像素）
 * @param {number} options.cols    - 列数
 * @param {number} options.rows    - 行数
 * @param {number} options.step    - 每格尺寸（像素）
 * @param {string} options.lineColor - 格线颜色
 * @param {number} options.lineWidth - 格线宽度
 */
export function drawGrid(ctx, {
  originX = 0,
  originY = 0,
  cols = 10,
  rows = 10,
  step = 40,
  lineColor = '#c0c0c0',
  lineWidth = 0.5,
} = {}) {
  const w = cols * step;
  const h = rows * step;

  ctx.save();
  ctx.strokeStyle = lineColor;
  ctx.lineWidth = lineWidth;

  // 竖线
  for (let i = 0; i <= cols; i++) {
    const x = originX + i * step;
    ctx.beginPath();
    ctx.moveTo(x, originY);
    ctx.lineTo(x, originY + h);
    ctx.stroke();
  }

  // 横线
  for (let j = 0; j <= rows; j++) {
    const y = originY + j * step;
    ctx.beginPath();
    ctx.moveTo(originX, y);
    ctx.lineTo(originX + w, y);
    ctx.stroke();
  }

  ctx.restore();
}
