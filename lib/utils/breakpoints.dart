enum Breakpoints {
  small(640),
  md(768),
  lg(1024),
  xl(1280),
  xxl(1536);

  const Breakpoints(this.size);

  final int size;
}
