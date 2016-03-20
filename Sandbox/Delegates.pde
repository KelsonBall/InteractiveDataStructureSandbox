// Defines an interface for wrapped methods.
public interface IAction<SenderType>{
  public void Invoke(SenderType sender); 
}