// ============================================================
// draw-helpers.js — 通用绘图辅助函数
// ============================================================

/**
 * 绘制三角形（填充 + 描边）
 * @param {CanvasRenderingContext2D} ctx
 * @param {Array<[number, number]>} vertices - 三个顶点 [[x1,y1],[x2,y2],[x3,y3]]
 * @param {Object} options
 * @param {string} options.strokeColor - 描边颜色
 * @param {number} options.lineWidth   - 描边宽度
 * @param {string|null} options.fillColor - 填充颜色（null = 不填充）
 */
export function drawTriangle(ctx, vertices, {
  strokeColor = '#000',
  lineWidth = 1.5,
  fillColor = null,
} = {}) {
  ctx.save();
  ctx.beginPath();
  ctx.moveTo(vertices[0][0], vertices[0][1]);
  ctx.lineTo(vertices[1][0], vertices[1][1]);
  ctx.lineTo(vertices[2][0], vertices[2][1]);
  ctx.closePath();

  if (fillColor) {
    ctx.fillStyle = fillColor;
    ctx.fill();
  }

  ctx.strokeStyle = strokeColor;
  ctx.lineWidth = lineWidth;
  ctx.stroke();
  ctx.restore();
}

/**
 * 绘制虚线箭头（辅助平移示意）
 * @param {CanvasRenderingContext2D} ctx
 * @param {number} x1 - 起点 X
 * @param {number} y1 - 起点 Y
 * @param {number} x2 - 终点 X
 * @param {number} y2 - 终点 Y
 * @param {Object} options
 * @param {string} options.color    - 线条颜色
 * @param {number} options.lineWidth - 线宽
 * @param {number} options.arrowSize - 箭头大小
 */
export function drawDashedArrow(ctx, x1, y1, x2, y2, {
  color = '#888',
  lineWidth = 1,
  arrowSize = 8,
  dashPattern = [6, 4],
} = {}) {
  ctx.save();
  ctx.strokeStyle = color;
  ctx.fillStyle = color;
  ctx.lineWidth = lineWidth;
  ctx.setLineDash(dashPattern);

  // 虚线
  ctx.beginPath();
  ctx.moveTo(x1, y1);
  ctx.lineTo(x2, y2);
  ctx.stroke();

  // 箭头
  ctx.setLineDash([]);
  const angle = Math.atan2(y2 - y1, x2 - x1);
  ctx.beginPath();
  ctx.moveTo(x2, y2);
  ctx.lineTo(
    x2 - arrowSize * Math.cos(angle - Math.PI / 6),
    y2 - arrowSize * Math.sin(angle - Math.PI / 6),
  );
  ctx.lineTo(
    x2 - arrowSize * Math.cos(angle + Math.PI / 6),
    y2 - arrowSize * Math.sin(angle + Math.PI / 6),
  );
  ctx.closePath();
  ctx.fill();

  ctx.restore();
}

/**
 * 绘制实线箭头
 */
export function drawSolidArrow(ctx, x1, y1, x2, y2, {
  color = '#000',
  lineWidth = 1.5,
  arrowSize = 10,
} = {}) {
  ctx.save();
  ctx.strokeStyle = color;
  ctx.fillStyle = color;
  ctx.lineWidth = lineWidth;

  ctx.beginPath();
  ctx.moveTo(x1, y1);
  ctx.lineTo(x2, y2);
  ctx.stroke();

  const angle = Math.atan2(y2 - y1, x2 - x1);
  ctx.beginPath();
  ctx.moveTo(x2, y2);
  ctx.lineTo(
    x2 - arrowSize * Math.cos(angle - Math.PI / 6),
    y2 - arrowSize * Math.sin(angle - Math.PI / 6),
  );
  ctx.lineTo(
    x2 - arrowSize * Math.cos(angle + Math.PI / 6),
    y2 - arrowSize * Math.sin(angle + Math.PI / 6),
  );
  ctx.closePath();
  ctx.fill();
  ctx.restore();
}

/**
 * 绘制带中点箭头的线段（箭头在线段中部）
 */
export function drawMidArrowLine(ctx, x1, y1, x2, y2, {
  color = '#000',
  lineWidth = 1.5,
  arrowSize = 9,
} = {}) {
  ctx.save();
  ctx.strokeStyle = color;
  ctx.fillStyle = color;
  ctx.lineWidth = lineWidth;

  // 画完整线段
  ctx.beginPath();
  ctx.moveTo(x1, y1);
  ctx.lineTo(x2, y2);
  ctx.stroke();

  // 在中点画箭头
  const mx = (x1 + x2) / 2;
  const my = (y1 + y2) / 2;
  const angle = Math.atan2(y2 - y1, x2 - x1);
  ctx.beginPath();
  ctx.moveTo(mx + arrowSize * 0.5 * Math.cos(angle), my + arrowSize * 0.5 * Math.sin(angle));
  ctx.lineTo(
    mx - arrowSize * 0.5 * Math.cos(angle - Math.PI / 5),
    my - arrowSize * 0.5 * Math.sin(angle - Math.PI / 5),
  );
  ctx.lineTo(
    mx - arrowSize * 0.5 * Math.cos(angle + Math.PI / 5),
    my - arrowSize * 0.5 * Math.sin(angle + Math.PI / 5),
  );
  ctx.closePath();
  ctx.fill();
  ctx.restore();
}

/**
 * 绘制虚线（无箭头）
 */
export function drawDashedLine(ctx, x1, y1, x2, y2, {
  color = '#888',
  lineWidth = 1,
  dashPattern = [6, 4],
} = {}) {
  ctx.save();
  ctx.strokeStyle = color;
  ctx.lineWidth = lineWidth;
  ctx.setLineDash(dashPattern);
  ctx.beginPath();
  ctx.moveTo(x1, y1);
  ctx.lineTo(x2, y2);
  ctx.stroke();
  ctx.restore();
}

/**
 * 绘制实线（无箭头）
 */
export function drawLine(ctx, x1, y1, x2, y2, {
  color = '#000',
  lineWidth = 1.5,
} = {}) {
  ctx.save();
  ctx.strokeStyle = color;
  ctx.lineWidth = lineWidth;
  ctx.beginPath();
  ctx.moveTo(x1, y1);
  ctx.lineTo(x2, y2);
  ctx.stroke();
  ctx.restore();
}

/**
 * 绘制角度弧线标记
 */
export function drawAngleArc(ctx, cx, cy, startAngle, endAngle, {
  radius = 20,
  color = '#666',
  lineWidth = 1,
} = {}) {
  ctx.save();
  ctx.strokeStyle = color;
  ctx.lineWidth = lineWidth;
  ctx.beginPath();
  ctx.arc(cx, cy, radius, startAngle, endAngle);
  ctx.stroke();
  ctx.restore();
}
