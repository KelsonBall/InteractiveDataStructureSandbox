public class SetToPinkAction implements IAction<Button>
{
  public void Invoke(Button sender)
  {
    sender.Background = "pink"; 
  }
}