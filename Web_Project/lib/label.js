// ============================================================
// label.js — 点标签绘图工具
// 对标 Typst dot-label
// ============================================================

// 8 方向偏移量映射（单位像素）
const DIR_OFFSET = {
  n:  [0, -1],
  s:  [0,  1],
  e:  [1,  0],
  w:  [-1, 0],
  ne: [0.7, -0.7],
  nw: [-0.7, -0.7],
  se: [0.7,  0.7],
  sw: [-0.7, 0.7],
};

/**
 * 在 Canvas 上绘制标签点 + 文字
 * @param {CanvasRenderingContext2D} ctx
 * @param {number} x          - 像素坐标 X
 * @param {number} y          - 像素坐标 Y
 * @param {string} label      - 标签文字（如 "A", "A'", "A''"）
 * @param {Object} options
 * @param {string} options.dir       - 方向 ("n","s","e","w","ne","nw","se","sw")
 * @param {number} options.dotRadius - 圆点半径
 * @param {string} options.dotColor  - 圆点颜色
 * @param {string} options.textColor - 文字颜色
 * @param {string} options.font      - 文字字体
 * @param {number} options.offset    - 偏移距离（像素）
 */
export function drawDotLabel(ctx, x, y, label, {
  dir = 'ne',
  dotRadius = 3,
  dotColor = '#000',
  textColor = '#333',
  font = 'italic 14px "Times New Roman", "KaTeX_Math", serif',
  offset = 14,
} = {}) {
  // 绘制圆点
  ctx.save();
  ctx.beginPath();
  ctx.arc(x, y, dotRadius, 0, Math.PI * 2);
  ctx.fillStyle = dotColor;
  ctx.fill();
  ctx.restore();

  // 绘制文字标签
  const [dx, dy] = DIR_OFFSET[dir] || DIR_OFFSET['ne'];
  const tx = x + dx * offset;
  const ty = y + dy * offset;

  ctx.save();
  ctx.font = font;
  ctx.fillStyle = textColor;
  ctx.textAlign = 'center';
  ctx.textBaseline = 'middle';
  ctx.fillText(label, tx, ty);
  ctx.restore();
}

/**
 * 绘制带文字的实心圆点（较大半径，用于旋转中心 O 等）
 */
export function drawCenterDot(ctx, x, y, label, {
  radius = 5,
  color = '#DC2626',
  textColor = '#333',
  dir = 's',
  font = 'italic 14px "Times New Roman", "KaTeX_Math", serif',
  offset = 14,
} = {}) {
  ctx.save();
  ctx.beginPath();
  ctx.arc(x, y, radius, 0, Math.PI * 2);
  ctx.fillStyle = color;
  ctx.fill();
  ctx.restore();

  const [dx, dy] = DIR_OFFSET[dir] || DIR_OFFSET['s'];
  const tx = x + dx * offset;
  const ty = y + dy * offset;

  ctx.save();
  ctx.font = font;
  ctx.fillStyle = textColor;
  ctx.textAlign = 'center';
  ctx.textBaseline = 'middle';
  ctx.fillText(label, tx, ty);
  ctx.restore();
}
