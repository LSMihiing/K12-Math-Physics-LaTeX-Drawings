// CeTZ 正弦波绘制工具函数
// 用于替代 TikZ 的 plot[domain=a:b]{sin(x)}
#import "@preview/cetz:0.4.2"

// 绘制正弦波点列
// domain: (start, end) 弧度
// amp: 振幅
// freq: 频率乘数(默认1)
// phase: 相位(弧度,默认0)
// offset-y: y轴偏移(默认0)
// samples: 采样数(默认100)
#let sine-points(domain-start, domain-end, amp: 1, freq: 1, phase: 0, offset-y: 0, samples: 100) = {
  let pts = ()
  for i in range(0, samples + 1) {
    let t = domain-start + float(i) / float(samples) * (domain-end - domain-start)
    let y = amp * calc.sin(freq * t + phase) + offset-y
    pts.push((t, y))
  }
  pts
}

// 绘制 |sin(x)| 全波整流
#let abs-sine-points(domain-start, domain-end, amp: 1, freq: 1, phase: 0, offset-y: 0, samples: 100) = {
  let pts = ()
  for i in range(0, samples + 1) {
    let t = domain-start + float(i) / float(samples) * (domain-end - domain-start)
    let y = calc.abs(amp * calc.sin(freq * t + phase)) + offset-y
    pts.push((t, y))
  }
  pts
}
