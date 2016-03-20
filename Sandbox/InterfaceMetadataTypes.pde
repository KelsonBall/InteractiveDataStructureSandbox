public class UIDimensions{
  
  public int XOffset = 0; // Element.width/2
  public double XScale = 0; // 0.5
  public int YOffset = 0; //Element.height/2
  public double YScale = 0; // 0.5
  
  public UIDimensions(int xOffset, double xScale, int yOffset, double yScale)
  {
    this.XOffset = xOffset;
    this.XScale = xScale;
    this.YOffset = yOffset;
    this.YScale = yScale;
  }
}